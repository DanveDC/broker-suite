# Referencia de Configuración — BrokerCore

Todas las variables de configuración de BrokerCore se gestionan a través del archivo `.env` ubicado en el directorio raíz del proyecto. El archivo `.env.example` incluido en el repositorio sirve como plantilla documentada.

Para crear su configuración:

```bash
cp .env.example .env
```

Edite `.env` con los valores de su entorno. **Nunca confirme `.env` en un repositorio de código.**

---

## Base de datos

BrokerCore se conecta a MySQL/TiDB Cloud mediante PyMySQL (`conexion/conexionBD.py`), usando **una única credencial compartida** para toda la aplicación. Hay dos formas de configurarla; la aplicación usa la primera que encuentre:

### `DATABASE_URL` / `MYSQL_URL`

| Campo | Valor |
|---|---|
| Descripción | URL de conexión completa. Si está presente, tiene prioridad sobre las variables discretas de abajo. Se acepta cualquiera de los dos nombres. |
| Ejemplo | `mysql://usuario:contraseña@host:4000/brokercore` |
| Requerido | No (recomendado en producción / Render) |

Se parsea con `urlparse`: host, usuario, contraseña, base de datos y puerto se extraen de la URL. Es la variable que usa el despliegue en Render (se configura manualmente como secret en el dashboard) y el `docker-compose.yml` local.

---

### `MYSQL_SSL`

| Campo | Valor |
|---|---|
| Descripción | Fuerza la conexión TLS/SSL a la base de datos |
| Ejemplo | `true` |
| Requerido | No |

Se activa automáticamente sin necesidad de esta variable si el host de `DATABASE_URL`/`MYSQL_URL` contiene `tidb`, `tidbcloud`, `planetscale` o `aiven` (caso de TiDB Cloud). Configúrela explícitamente en `true` si su proveedor requiere SSL y no cae en esa detección automática.

---

### `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `DB_PORT`

| Campo | Valor |
|---|---|
| Descripción | Variables discretas de conexión, usadas solo si **no** hay `DATABASE_URL` ni `MYSQL_URL` definida |
| Ejemplo | `DB_HOST=localhost`, `DB_USER=root`, `DB_PASSWORD=...`, `DB_NAME=brokercore`, `DB_PORT=3306` |
| Requerido | Solo si no se usa `DATABASE_URL`/`MYSQL_URL` |

Pensadas para desarrollo local contra un MySQL propio. `DB_PORT` por defecto es `3306` y `DB_USER` por defecto es `root` si no se especifica.

---

## Aplicación

### `SECRET_KEY`

| Campo | Valor |
|---|---|
| Descripción | Clave secreta de Flask utilizada para firmar las cookies de sesión |
| Ejemplo | `a8f5f167f44f4964e6c998dee827110c` |
| Requerido | Sí |

**Esta es la variable más crítica de seguridad.** Una clave débil o predecible permite que un atacante falsifique cookies de sesión y tome control de cualquier cuenta.

Genere una clave aleatoria segura con:

```python
python -c "import secrets; print(secrets.token_hex(32))"
```

> **Producción:** Cambie esta clave antes del primer despliegue en producción. Cambiarla después invalida todas las sesiones activas (todos los usuarios deberán volver a iniciar sesión).

---

## Correo electrónico

BrokerCore utiliza Gmail con contraseña de aplicación para el envío de correos (recuperación de contraseña, notificaciones).

### `SMTP_EMAIL`

| Campo | Valor |
|---|---|
| Descripción | Dirección de correo Gmail utilizada como remitente |
| Ejemplo | `brokercore.notificaciones@gmail.com` |
| Requerido | Sí (si se usa la función de recuperación de contraseña) |

---

### `SMTP_PASSWORD`

| Campo | Valor |
|---|---|
| Descripción | Contraseña de aplicación de Gmail (no la contraseña de la cuenta) |
| Ejemplo | `xxxx xxxx xxxx xxxx` |
| Requerido | Sí (si se usa la función de recuperación de contraseña) |

Para obtener una contraseña de aplicación de Gmail:
1. Acceda a su cuenta de Google → Seguridad → Verificación en dos pasos (debe estar activa).
2. En la misma sección, busque "Contraseñas de aplicaciones".
3. Genere una contraseña para "Correo" en "Otro dispositivo".
4. Copie las 16 letras generadas (sin espacios o con espacios, ambos formatos funcionan).

---

## Notas para producción

### Variables adicionales recomendadas

En producción, considere agregar las siguientes variables aunque no estén en `.env.example`:

```dotenv
# Deshabilitar el modo debug de Flask (crítico en producción)
FLASK_DEBUG=0

# Entorno (development / production)
FLASK_ENV=production
```

### Protección del archivo .env

En servidores Linux, restrinja los permisos del archivo `.env` para que solo el usuario que corre la aplicación pueda leerlo:

```bash
chmod 600 .env
chown brokercore_user:brokercore_user .env
```

### Rotación de claves

Si sospecha que `SECRET_KEY` o las credenciales de base de datos han sido comprometidas:

1. Genere nuevos valores.
2. Actualice `.env` (o el secret de `DATABASE_URL` en Render, o el `.env` local de Docker).
3. Reinicie el servidor de la aplicación.
4. En el caso de `SECRET_KEY`, avise a los usuarios que deberán iniciar sesión nuevamente.
5. En el caso de la contraseña de base de datos, cámbiela en el proveedor (TiDB Cloud, MySQL propio, etc.) y actualice la variable de conexión correspondiente.

---

## Docker

Además de Render, BrokerCore puede levantarse localmente o en cualquier entorno con Docker mediante el `Dockerfile` y `docker-compose.yml` del repositorio.

```bash
cp .env.example .env   # completar con las variables reales (DATABASE_URL/MYSQL_URL, SECRET_KEY, etc.)
docker compose up --build
```

`docker-compose.yml` define un único servicio `app`, construye la imagen desde el `Dockerfile` (`python:3.11-slim`), mapea el puerto `8000` y lee las variables de entorno desde el `.env` local (nunca se commitea). Ver [tecnico/despliegue.md](./tecnico/despliegue.md) para más detalle.
