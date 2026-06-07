# Postura de Seguridad — BrokerCore

Este documento describe honestamente el estado actual de seguridad de BrokerCore: qué está implementado, qué no lo está, y las recomendaciones para fortalecer el sistema antes o durante el despliegue en producción.

---

## Lo que sí está implementado

### Hashing de contraseñas (bcrypt)

Las contraseñas de los usuarios se almacenan en la tabla `users` usando el algoritmo bcrypt a través de `werkzeug.security`:

```python
from werkzeug.security import generate_password_hash, check_password_hash

# Al crear usuario
hash = generate_password_hash(password)

# Al verificar login
check_password_hash(stored_hash, provided_password)
```

Bcrypt incluye salt automático y es resistente a ataques de fuerza bruta por diseño. Esta es la práctica correcta para almacenamiento de contraseñas.

### Autenticación basada en sesión (Flask session)

Las sesiones de usuario están firmadas criptográficamente con `SECRET_KEY`. Un atacante no puede falsificar una cookie de sesión sin conocer esta clave.

### Permisos a nivel de base de datos

Cada usuario de la aplicación es un usuario MySQL con permisos explícitamente asignados según su rol (ver [tecnico/base-de-datos.md](./base-de-datos.md)). Esto significa que un usuario con rol "Ventas" no puede ejecutar INSERT o DELETE en MySQL aunque encuentre una forma de eludir la capa de aplicación.

### Recuperación de contraseña con tokens

El sistema de restablecimiento de contraseña genera tokens temporales (tabla `password_resets`) con fecha de expiración. Los tokens son de un solo uso.

---

## Lo que NO está implementado — Riesgos actuales

### 1. Contraseña almacenada en texto plano en la sesión

```python
# En funciones_login.py (autenticación exitosa)
session['pass'] = password  # ← La contraseña en texto plano queda en la sesión
```

**Por qué es un riesgo:** La sesión de Flask se almacena en una cookie del navegador (firmada pero no cifrada). Si un atacante obtiene acceso al servidor o a la `SECRET_KEY`, puede leer las contraseñas de los usuarios activos. Peor aún, si la sesión se filtra por cualquier medio, la contraseña real del usuario MySQL queda expuesta.

Esto es necesario por el modelo de autenticación actual (la conexión MySQL usa las credenciales de sesión), pero introduce un riesgo real.

---

### 2. Sin protección CSRF

Los formularios POST del sistema no incluyen tokens CSRF (Cross-Site Request Forgery). Esto significa que una página web maliciosa podría, en teoría, engañar a un usuario autenticado para que realice operaciones no deseadas (crear, modificar o eliminar registros).

---

### 3. Sin rate limiting en el login

El endpoint de login no tiene límite de intentos. Un atacante puede intentar contraseñas ilimitadas sin ser bloqueado automáticamente.

---

### 4. Sin validación/sanitización de entradas estandarizada

La validación de formularios es parcial y no estandarizada. Aunque MySQL connector usa parámetros preparados (lo que previene SQL injection en las queries), no hay una capa consistente de validación de tipos y longitudes en el servidor.

---

### 5. Sin connection pooling

Cada request abre y cierra una conexión MySQL nueva. Esto no es un riesgo de seguridad directo, pero es un vector de ataque de disponibilidad (DoS): un atacante podría saturar el servidor con muchas peticiones concurrentes.

---

### 6. Credenciales Gmail en `.env`

Las credenciales de correo (`SMTP_EMAIL`, `SMTP_PASSWORD`) son credenciales reales de Gmail que dan acceso a esa cuenta de correo. Si `.env` se filtra, el atacante controla esa cuenta.

---

### 7. Usuario de respaldo con permisos amplios

`DB_FALLBACK_USER` / `DB_FALLBACK_PASSWORD` son credenciales de un usuario MySQL con permisos amplios, almacenadas en `.env`. Son necesarias para operaciones de administración (crear/eliminar usuarios), pero representan un riesgo alto si `.env` es accesible.

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

Consulte la sección correspondiente en [tecnico/despliegue.md](./despliegue.md). HTTPS cifra la comunicación entre el navegador y el servidor, protegiendo las cookies de sesión (que contienen la contraseña del usuario) de ataques de intercepción.

---

### 4. Reemplazar Gmail con un servicio SMTP dedicado (prioridad media)

En lugar de credenciales de Gmail, use un servicio transaccional como:
- **SendGrid** (tiene capa gratuita generosa)
- **Mailgun**
- **Amazon SES**

Estos servicios usan API keys con permisos limitados (solo envío de correo), no contraseñas de cuentas reales.

---

### 5. Implementar connection pooling (prioridad media)

```python
# Con mysql-connector-python
import mysql.connector.pooling

pool = mysql.connector.pooling.MySQLConnectionPool(
    pool_name="brokercore_pool",
    pool_size=10,
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

### 7. Restringir acceso al servidor MySQL (prioridad media)

Por defecto, MySQL puede estar escuchando en `0.0.0.0`. Restrinja a `localhost` solo si la aplicación corre en el mismo servidor:

```sql
-- En MySQL, verificar bind-address
SHOW VARIABLES LIKE 'bind_address';
```

En `/etc/mysql/mysql.conf.d/mysqld.cnf`:

```ini
bind-address = 127.0.0.1
```

---

### 8. Revisar el modelo de sesión a largo plazo (prioridad baja — requiere refactorización)

La raíz del problema de la contraseña en sesión es el diseño de autenticación acoplada a MySQL. Una solución más robusta a largo plazo sería:
- Usar connection pooling con un usuario de servicio de la aplicación.
- Implementar los controles de acceso por rol en la capa de aplicación (middleware/decoradores).
- Eliminar la necesidad de credenciales individuales de MySQL por usuario.

Este cambio requiere refactorización significativa del modelo de autenticación y de la capa de conexión a base de datos.

---

## Resumen de riesgos

| Riesgo | Severidad | Mitigación disponible | Esfuerzo |
|---|---|---|---|
| Contraseña en sesión | Alta | Requiere refactorización de arquitectura | Alto |
| Sin CSRF | Alta | Flask-WTF | Bajo |
| Sin rate limiting | Media | Flask-Limiter | Bajo |
| Gmail en .env | Media | Servicio SMTP dedicado | Bajo |
| Sin HTTPS | Alta (en red pública) | Nginx + Certbot | Bajo |
| Sin connection pooling | Baja (rendimiento) | mysql-connector pooling | Medio |
| DB_FALLBACK en .env | Media | Permisos restrictivos en .env | Inmediato |
