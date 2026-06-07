# Arquitectura del Sistema — BrokerCore

## Visión general

BrokerCore es un **monolito Flask** estructurado en un patrón MVC loosely-coupled: las rutas actúan como controladores delgados, toda la lógica de negocio vive en funciones de controlador centralizadas, y las vistas son plantillas Jinja2.

El sistema no utiliza Blueprints de Flask, lo que significa que toda la aplicación se define en un único conjunto de archivos de rutas y funciones. Esto simplifica el despliegue y el razonamiento lineal, a costa de escalabilidad modular.

```
Navegador → Flask Router → Controller Function → SQL (mysql-connector) → MySQL 8.0
                                    ↓
                              Jinja2 Template → HTML Response
```

---

## Estructura de archivos y responsabilidades

```
broker-suite/
├── app.py                    ← Flask app factory. Registra routers, carga .env, define context processors.
├── run.py                    ← Entrada para desarrollo. Inicia Flask en puerto 5600 con debug=True.
├── wsgi.py                   ← Entrada para producción. Inicia waitress en puerto 8000.
├── .env / .env.example       ← Variables de configuración del entorno.
├── requirements.txt          ← Dependencias Python.
│
├── conexion/
│   └── conexionBD.py         ← Fábrica de conexiones MySQL. Lee credenciales de la sesión Flask activa.
│
├── controllers/
│   ├── funciones_home.py     ← Toda la lógica de negocio (~8900 líneas). Una función por operación.
│   └── funciones_login.py    ← Lógica de autenticación, creación/eliminación de usuarios MySQL.
│
├── routers/
│   ├── router_home.py        ← ~130 rutas de la aplicación. Cada ruta llama a una función de controller.
│   ├── router_login.py       ← Rutas de login, logout, recuperación de contraseña.
│   └── router_page_not_found.py ← Handler de error 404.
│
├── templates/public/         ← Plantillas Jinja2. Una carpeta por módulo.
│   ├── base_cpanel.html      ← Plantilla base con navbar, sidebar y bloque de contenido.
│   └── [modulo]/             ← index.html, create.html, edit.html, detail.html por módulo.
│
├── static/
│   ├── css/                  ← Estilos Sneat Bootstrap 5 y overrides personalizados.
│   ├── js/                   ← Scripts de ApexCharts, tablas y formularios.
│   ├── fotos_empleados/      ← Fotos de empleados subidas por el sistema.
│   └── downloads-excel/      ← Archivos Excel generados temporalmente.
│
├── BD/                       ← Archivos SQL del esquema y migraciones.
└── scripts/                  ← Scripts Python de migración puntual.
```

---

## Capa de autenticación

BrokerCore implementa un modelo de autenticación no convencional: **la sesión de usuario almacena las credenciales MySQL del usuario**, y cada consulta a la base de datos se ejecuta con esas credenciales.

### Flujo de autenticación

```
POST /login
    ↓
funciones_login.py:
  1. Consulta users WHERE email_user = ? usando DB_FALLBACK_USER
  2. Verifica hash con werkzeug.check_password_hash
  3. Si válido: session['conectado'] = True
                session['email_user'] = email
                session['pass'] = password_plaintext   ← ⚠ en texto plano
                session['permisos'] = rol
```

### Conexión por request

```python
# conexionBD.py (simplificado)
def get_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        user=session['email_user'],   # Usuario MySQL = email del app user
        password=session['pass'],     # Contraseña en sesión
        database=DB_NAME
    )
```

Este diseño significa que los controles de acceso de MySQL (GRANT/REVOKE) aplican automáticamente por usuario, pero implica limitaciones importantes documentadas en [tecnico/seguridad.md](./seguridad.md).

---

## Capa de rutas

`router_home.py` contiene aproximadamente 130 rutas. El patrón es uniforme:

```python
@router_home.route('/asegurados')
@login_required
def listar_asegurados():
    data = funciones_home.get_asegurados()
    return render_template('public/asegurados/index.html', data=data)

@router_home.route('/asegurados/crear', methods=['POST'])
@login_required
def crear_asegurado():
    return funciones_home.crear_asegurado(request.form)
```

**Caso especial — códigos de póliza con barras:**
Los códigos de póliza (`cod_poliza`) pueden contener barras `/`, lo que genera conflictos en URLs de Flask. La solución adoptada es sustituir `/` por `-` al construir las URLs y revertir la sustitución en el controller antes de consultar la base de datos.

---

## Capa de lógica de negocio

`funciones_home.py` contiene toda la lógica de negocio en ~8900 líneas. No hay separación por módulo; todas las funciones coexisten en el mismo archivo.

Las funciones usan SQL directo (sin ORM):

```python
def get_asegurados(filtros=None):
    conn = conexionBD.get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM asegurado WHERE ...")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result
```

No existe connection pooling: cada llamada abre y cierra una conexión nueva.

---

## Context processor

`app.py` define un context processor que inyecta en todas las plantillas el conteo de pólizas pendientes (del módulo de comisiones):

```python
@app.context_processor
def inject_pending_count():
    if 'conectado' in session:
        count = funciones_home.get_polizas_pendientes_count()
        return {'pending_count': count}
    return {}
```

Este valor aparece como badge en el ícono de comisiones en el sidebar y se calcula en cada request.

---

## Sistema de plantillas

Las plantillas extienden `base_cpanel.html` mediante herencia Jinja2:

```html
{% extends "public/base_cpanel.html" %}

{% block title %}Asegurados{% endblock %}

{% block content %}
  <!-- contenido del módulo -->
{% endblock %}
```

La plantilla base incluye:
- Sneat Bootstrap 5 (navbar + sidebar responsivo).
- Bloque de scripts para ApexCharts (dashboard).
- Indicador de pólizas pendientes en el sidebar.
- Nombre y rol del usuario autenticado en el header.

---

## Deuda técnica conocida

| Área | Problema | Impacto |
|---|---|---|
| `funciones_home.py` | ~8900 líneas en un solo archivo | Mantenibilidad crítica. Dificulta pruebas y cambios aislados. |
| Sin connection pooling | Nueva conexión por request | Overhead de red en alta concurrencia. |
| Sin Blueprints | Todo en dos archivos de rutas | Dificulta escalar el equipo o extraer módulos. |
| Contraseña en sesión | `session['pass']` en texto plano | Riesgo de seguridad si la sesión se compromete. |
| Sin CSRF | Formularios sin token CSRF | Vulnerable a ataques cross-site request forgery. |
| Sin tests | Cero cobertura de pruebas | Riesgo alto ante refactorizaciones. |
| Context processor | Consulta DB en cada request | Impacto de rendimiento con muchos usuarios simultáneos. |

Para detalles sobre el posicionamiento de seguridad actual y recomendaciones de hardening, consulte [tecnico/seguridad.md](./seguridad.md).
