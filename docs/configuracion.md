# Referencia de Configuración — BrokerCore

Todas las variables de configuración de BrokerCore se gestionan a través del archivo `.env` ubicado en el directorio raíz del proyecto. El archivo `.env.example` incluido en el repositorio sirve como plantilla documentada.

Para crear su configuración:

```bash
cp .env.example .env
```

Edite `.env` con los valores de su entorno. **Nunca confirme `.env` en un repositorio de código.**

---

## Base de datos

### `DB_HOST`

| Campo | Valor |
|---|---|
| Descripción | Hostname o dirección IP del servidor MySQL |
| Ejemplo | `localhost` |
| Requerido | Sí |

Para instalaciones locales use `localhost` o `127.0.0.1`. Para bases de datos remotas, use la IP o hostname del servidor.

---

### `DB_PORT`

| Campo | Valor |
|---|---|
| Descripción | Puerto TCP del servidor MySQL |
| Ejemplo | `3306` |
| Requerido | No (por defecto: `3306`) |

Cambie este valor solo si MySQL está configurado en un puerto no estándar.

---

### `DB_NAME`

| Campo | Valor |
|---|---|
| Descripción | Nombre de la base de datos de BrokerCore |
| Ejemplo | `brokercore` |
| Requerido | Sí |

La base de datos debe existir antes de iniciar la aplicación. Créela siguiendo el [Paso 5 de la guía de instalación](./instalacion.md).

---

### `DB_FALLBACK_USER`

| Campo | Valor |
|---|---|
| Descripción | Usuario MySQL de respaldo, utilizado para operaciones del sistema (creación de usuarios, consultas administrativas) |
| Ejemplo | `admin_brokercore` |
| Requerido | Sí |

Este usuario se usa en operaciones donde la sesión de usuario no está disponible (por ejemplo, durante el proceso de login, creación de nuevos usuarios, restablecimiento de contraseñas). Debe tener permisos amplios sobre la base de datos.

> **Seguridad:** Este usuario debe tener una contraseña robusta. Nunca use `root` como usuario de respaldo.

---

### `DB_FALLBACK_PASSWORD`

| Campo | Valor |
|---|---|
| Descripción | Contraseña del usuario MySQL de respaldo |
| Ejemplo | `M1_C0ntr4s3ñ4_S3gur4!` |
| Requerido | Sí |

Debe coincidir con la contraseña del usuario `DB_FALLBACK_USER` en MySQL.

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
2. Actualice `.env`.
3. Reinicie el servidor de la aplicación.
4. En el caso de `SECRET_KEY`, avise a los usuarios que deberán iniciar sesión nuevamente.
5. En el caso de contraseñas de base de datos, actualícelas también en MySQL con `ALTER USER`.
