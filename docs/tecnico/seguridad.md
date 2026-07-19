# Postura de Seguridad — BrokerCore

Este documento describe honestamente el estado actual de seguridad de BrokerCore: qué está implementado, qué no lo está, y las recomendaciones para fortalecer el sistema antes o durante el despliegue en producción.

---

## Lo que sí está implementado

### Hashing de contraseñas (scrypt, vía werkzeug)

Las contraseñas de los usuarios se almacenan en la tabla `users` con `werkzeug.security`, usando explícitamente el método `scrypt` (no bcrypt — no hay paquete `bcrypt` en `requirements.txt`):

```python
from werkzeug.security import generate_password_hash, check_password_hash

# controllers/funciones_login.py
nueva_password = generate_password_hash(pass_user, method='scrypt')

# Al verificar login
check_password_hash(stored_hash, provided_password)
```

scrypt incluye salt automático y es resistente a ataques de fuerza bruta por diseño. Esta es una práctica correcta para almacenamiento de contraseñas.

### Autenticación basada en sesión (Flask session)

Las sesiones de usuario están firmadas criptográficamente con `SECRET_KEY`. Un atacante no puede falsificar una cookie de sesión sin conocer esta clave.

### Recuperación de contraseña con tokens

El sistema de restablecimiento de contraseña genera tokens temporales (tabla `password_resets`) con fecha de expiración. Los tokens son de un solo uso.

---

## Lo que NO está implementado — Riesgos actuales

### 1. Todas las queries corren con una única credencial de base de datos

BrokerCore no crea una cuenta MySQL por usuario de la aplicación: toda consulta, sin importar el rol de quien esté logueado, se ejecuta con la misma credencial configurada por variable de entorno (`DATABASE_URL`/`MYSQL_URL` o las discretas `DB_*`). El control de acceso por rol (Administración, Gerencia, Operaciones, Ventas) se resuelve **solo** en la capa de aplicación, comparando `session['permisos']` en cada ruta.

**Por qué importa:** si una ruta específica olvida verificar el rol correctamente, no hay una segunda barrera a nivel de base de datos que lo detenga — a diferencia de un modelo con permisos MySQL por usuario. La sesión de Flask solo guarda identidad (`id`, `email_user`, `permisos`), no credenciales de base de datos, así que una fuga de sesión no expone contraseñas de base de datos.

---

### 2. Sin protección CSRF

Los formularios POST del sistema no incluyen tokens CSRF (Cross-Site Request Forgery). Esto significa que una página web maliciosa podría, en teoría, engañar a un usuario autenticado para que realice operaciones no deseadas (crear, modificar o eliminar registros).

---

### 3. Sin rate limiting en el login

El endpoint de login no tiene límite de intentos. Un atacante puede intentar contraseñas ilimitadas sin ser bloqueado automáticamente.

---

### 4. Sin validación/sanitización de entradas estandarizada

La validación de formularios es parcial y no estandarizada. Aunque PyMySQL usa parámetros preparados (lo que previene SQL injection en las queries), no hay una capa consistente de validación de tipos y longitudes en el servidor.

---

### 5. Sin connection pooling

Cada request abre y cierra una conexión PyMySQL nueva. Esto no es un riesgo de seguridad directo, pero es un vector de ataque de disponibilidad (DoS): un atacante podría saturar el servidor con muchas peticiones concurrentes.

---

### 6. Credenciales Gmail en `.env`

Las credenciales de correo (`SMTP_EMAIL`, `SMTP_PASSWORD`) son credenciales reales de Gmail que dan acceso a esa cuenta de correo. Si `.env` se filtra, el atacante controla esa cuenta.

---

### 7. Una única credencial de base de datos con acceso total en `.env`/secret de despliegue

`DATABASE_URL`/`MYSQL_URL` (o `DB_PASSWORD`) es la credencial que usa toda la aplicación para toda operación sobre la base de datos, sin distinción por rol de usuario. Si esta variable se filtra (`.env` local, secret de Render, o el `.env` de Docker), el atacante tiene el mismo nivel de acceso que la aplicación completa.

---

## Recomendaciones de hardening para producción

Las siguientes recomendaciones están ordenadas por impacto. Implementar las primeras tres antes de ir a producción con datos reales.

### 1. Agregar CSRF con Flask-WTF (prioridad alta)

```bash
pip install flask-wtf
```

```python
# app.py
from flask_wtf.csrf import CSRFProtect

csrf = CSRFProtect(app)
```

```html
<!-- En cada formulario HTML -->
<form method="POST">
    {{ csrf_token() }}
    <!-- campos -->
</form>
```

Esto protege todos los formularios POST contra ataques CSRF con un cambio mínimo de código.

---

### 2. Implementar rate limiting en el login (prioridad alta)

```bash
pip install flask-limiter
```

```python
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

limiter = Limiter(app, key_func=get_remote_address)

@router_login.route('/login', methods=['POST'])
@limiter.limit("10 per minute")
def login():
    ...
```

Esto bloquea ataques de fuerza bruta básicos.

---

### 3. Agregar HTTPS con Nginx + Let's Encrypt (prioridad alta)

Consulte la sección correspondiente en [tecnico/despliegue.md](./despliegue.md). HTTPS cifra la comunicación entre el navegador y el servidor, protegiendo la cookie de sesión firmada de ataques de intercepción. Render provee HTTPS gestionado por defecto; en despliegues con Nginx propio, siga la guía de Certbot/Let's Encrypt.

---

### 4. Reemplazar Gmail con un servicio SMTP dedicado (prioridad media)

En lugar de credenciales de Gmail, use un servicio transaccional como:
- **SendGrid** (tiene capa gratuita generosa)
- **Mailgun**
- **Amazon SES**

Estos servicios usan API keys con permisos limitados (solo envío de correo), no contraseñas de cuentas reales.

---

### 5. Implementar connection pooling (prioridad media)

PyMySQL no trae pooling incorporado. Una opción común es usar `DBUtils` (`PooledDB`) como capa sobre PyMySQL:

```python
from dbutils.pooled_db import PooledDB
import pymysql

pool = PooledDB(
    creator=pymysql,
    maxconnections=10,
    host=DB_HOST,
    database=DB_NAME,
    # ...
)
```

Esto mejora rendimiento y resiliencia, y reduce el vector de ataque de disponibilidad.

---

### 6. Rotar SECRET_KEY periódicamente (prioridad media)

Establezca una política de rotación de `SECRET_KEY` (por ejemplo, cada 90 días). Tenga en cuenta que rotar la clave invalida todas las sesiones activas. Coordine con los usuarios.

Genere una clave nueva con:

```python
python -c "import secrets; print(secrets.token_hex(32))"
```

---

### 7. Restringir el acceso a la base de datos (prioridad media)

Si se usa MySQL propio (no TiDB Cloud), restrinja el bind-address a `localhost` cuando la aplicación corre en el mismo servidor:

```sql
-- En MySQL, verificar bind-address
SHOW VARIABLES LIKE 'bind_address';
```

En `/etc/mysql/mysql.conf.d/mysqld.cnf`:

```ini
bind-address = 127.0.0.1
```

Si se usa TiDB Cloud, use el allowlist de IP del panel de TiDB Cloud en lugar de esta configuración.

---

### 8. Sacar la validación de rol de las rutas y centralizarla (prioridad media — requiere refactorización)

Hoy el control de acceso por rol se repite manualmente al inicio de cada función de ruta (comparaciones de `session['permisos']`). Centralizarlo en un decorador o middleware reutilizable reduciría el riesgo de que una ruta nueva olvide la verificación. No es una vulnerabilidad activa conocida, pero es la mitigación estructural más directa contra el riesgo descrito en el punto 1 de este documento.

---

## Resumen de riesgos

| Riesgo | Severidad | Mitigación disponible | Esfuerzo |
|---|---|---|---|
| Credencial única de BD sin defensa en profundidad a nivel de datos | Media | Centralizar verificación de rol en la app (decorador/middleware) | Medio |
| Sin CSRF | Alta | Flask-WTF | Bajo |
| Sin rate limiting | Media | Flask-Limiter | Bajo |
| Gmail en .env | Media | Servicio SMTP dedicado | Bajo |
| Sin HTTPS | Alta (en red pública) | Nginx + Certbot, o HTTPS gestionado por Render | Bajo |
| Sin connection pooling | Baja (rendimiento) | DBUtils PooledDB sobre PyMySQL | Medio |
| Credencial de BD con acceso total en `.env`/secret | Media | Permisos restrictivos en `.env`, secrets gestionados en Render | Inmediato |
