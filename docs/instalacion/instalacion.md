# Guía de Instalación — BrokerCore

Esta guía cubre la instalación completa de BrokerCore desde cero, incluyendo dependencias, base de datos, primer usuario administrador y configuración del servidor.

---

## Requisitos previos

| Componente | Versión mínima | Notas |
|---|---|---|
| Python | 3.11 | Coincide con `runtime.txt` y la imagen Docker (`python:3.11-slim`) |
| MySQL / TiDB Cloud | 8.0+ compatible | Puede ser un MySQL propio o una instancia de TiDB Cloud (recomendado, es lo que usa producción) |
| pip | Incluido con Python | Actualizar con `pip install --upgrade pip` |
| Git | Cualquier versión reciente | Opcional si se entrega como ZIP |
| Docker + Docker Compose | Opcional | Solo si sigue la ruta de instalación con Docker (ver más abajo) |

**Sistema operativo:** Linux (recomendado para producción) o Windows (desarrollo y producción con waitress). También puede saltarse todo lo relativo al entorno virtual con la instalación vía Docker.

---

## Instalación con Docker (alternativa rápida)

Si tiene Docker instalado, esta es la vía más rápida para levantar BrokerCore sin preocuparse por el entorno virtual ni la versión de Python:

```bash
git clone <url-del-repositorio> broker-suite
cd broker-suite
cp .env.example .env
```

Edite `.env` con al menos `DATABASE_URL` (o `MYSQL_URL`) apuntando a su base de datos (TiDB Cloud o MySQL propio) y `SECRET_KEY`. Luego:

```bash
docker compose up --build
```

Esto construye la imagen (`python:3.11-slim`, con `ca-certificates` instalado para soportar TLS contra TiDB), instala `requirements.txt` y arranca la aplicación con `python wsgi.py` en el puerto `8000`. La base de datos y su esquema (`BD/`) deben existir de antemano — Docker no las crea por usted, solo levanta la aplicación.

La aplicación queda disponible en `http://localhost:8000`. Continúe en el [Paso 9 — Verificar el inicio de sesión](#paso-9-verificar-el-inicio-de-sesión) (necesitará un primer usuario administrador; ver [Paso 7](#paso-7-crear-el-primer-usuario-en-la-tabla-users) más abajo, que aplica igual con o sin Docker).

Si prefiere la instalación manual paso a paso (entorno virtual + pip), continúe con la siguiente sección.

---

## Paso 1 — Obtener el código fuente

```bash
# Opción A: clonar desde repositorio
git clone <url-del-repositorio> broker-suite
cd broker-suite

# Opción B: descomprimir el archivo entregado
unzip brokercore-v1.0.0.zip
cd broker-suite
```

---

## Paso 2 — Crear y activar entorno virtual

```bash
# Linux / macOS
python3 -m venv venv
source venv/bin/activate

# Windows (PowerShell)
python -m venv venv
.\venv\Scripts\Activate.ps1

# Windows (Command Prompt)
python -m venv venv
venv\Scripts\activate.bat
```

El prompt del terminal debe mostrar `(venv)` al inicio para confirmar que el entorno está activo.

---

## Paso 3 — Instalar dependencias

Con el entorno virtual activo:

```bash
pip install -r requirements.txt
```

Este comando instala Flask, PyMySQL, pandas, openpyxl, reportlab, waitress y el resto de las dependencias del proyecto.

---

## Paso 4 — Configurar variables de entorno

Copie el archivo de ejemplo y edítelo:

```bash
cp .env.example .env
```

Abra `.env` en un editor de texto y complete cada variable. Consulte [`docs/configuracion.md`](./configuracion.md) para la descripción detallada de cada una. Como mínimo, configure una de las dos formas de conexión a la base de datos:

```dotenv
# Opción A: URL de conexión completa (recomendado, usado en producción)
DATABASE_URL=mysql://usuario:contraseña@host:puerto/brokercore
MYSQL_SSL=true

# Opción B: variables discretas (alternativa para MySQL local)
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=contraseña_segura
DB_NAME=brokercore

SECRET_KEY=cambie_esto_por_una_clave_aleatoria_larga
```

> **Importante:** Nunca use el archivo `.env.example` directamente en producción. Cree siempre una copia con nombre `.env`.

---

## Paso 5 — Crear la base de datos MySQL

Conéctese a MySQL con un usuario que tenga privilegios de administración:

```bash
mysql -u root -p
```

Dentro de la consola de MySQL:

```sql
CREATE DATABASE brokercore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

---

## Paso 6 — Ejecutar el esquema SQL

Los archivos SQL del esquema están en la carpeta `BD/`. Aplíquelos en el siguiente orden:

```bash
# Desde el directorio raíz del proyecto
mysql -u root -p brokercore < BD/schema.sql
```

Si existen archivos de migración adicionales en `BD/`, aplíquelos en orden cronológico:

```bash
mysql -u root -p brokercore < BD/migration_001.sql
mysql -u root -p brokercore < BD/migration_002.sql
# ... y así sucesivamente
```

---

## Paso 7 — Crear el primer usuario en la tabla `users`

La tabla `users` de la aplicación almacena los metadatos del usuario y el hash de su contraseña para verificación. Debe crear el registro manualmente para el primer administrador.

Ejecute el siguiente script Python desde el directorio raíz del proyecto (con el entorno virtual activo):

```python
from werkzeug.security import generate_password_hash
from conexion.conexionBD import connectionBD

conn = connectionBD()
cursor = conn.cursor()

email = 'correo@ejemplo.com'
nombre = 'Administrador'
apellido = 'Principal'
password = 'contraseña_del_usuario'
rol = 'Administracion'

password_hash = generate_password_hash(password)

cursor.execute("""
    INSERT INTO users (name_surname, email_user, pass_user, permisos)
    VALUES (%s, %s, %s, %s)
""", (f"{nombre} {apellido}", email, password_hash, rol))

conn.commit()
cursor.close()
conn.close()

print(f"Usuario '{email}' creado exitosamente con rol '{rol}'.")
```

Guarde este contenido como `crear_admin.py` y ejecútelo:

```bash
python crear_admin.py
```

> **Elimine este archivo** después de ejecutarlo, ya que contiene credenciales en texto plano.

---

## Paso 8 — Iniciar el servidor de desarrollo

```bash
python run.py
```

El servidor quedará disponible en `http://localhost:5600`. Verifique en la terminal que aparece el mensaje de inicio de Flask sin errores.

---

## Paso 9 — Verificar el inicio de sesión

1. Abra `http://localhost:5600` en el navegador.
2. Ingrese el correo electrónico y la contraseña del administrador creado.
3. Debe acceder al dashboard principal.

Si la autenticación falla, revise la sección de [Solución de problemas](#solución-de-problemas) al final de este documento.

---

## Despliegue en producción

La producción actual de BrokerCore corre en **Render.com** (ver `render.yaml`), y también puede desplegarse con **Docker** de forma portable. Ambas opciones, más la alternativa manual con Nginx + systemd, están documentadas en [`docs/tecnico/despliegue.md`](./tecnico/despliegue.md).

Para entornos de producción, BrokerCore incluye `wsgi.py` que utiliza **waitress** como servidor WSGI. Waitress es compatible con Linux y Windows.

```bash
python wsgi.py
```

Esto inicia el servidor en el puerto `8000` (configurable con la variable `PORT`).

---

## Solución de problemas

### Error: `ModuleNotFoundError: No module named 'flask'`

El entorno virtual no está activo o las dependencias no se instalaron.

```bash
source venv/bin/activate   # Linux
pip install -r requirements.txt
```

### Error: `pymysql.err.OperationalError: (1045, "Access denied for user ...")`

Las credenciales en `.env` son incorrectas: revise `DATABASE_URL`/`MYSQL_URL`, o `DB_USER`/`DB_PASSWORD` si está usando las variables discretas. Recuerde que es una única credencial compartida por toda la aplicación, no una por usuario.

### Error al iniciar sesión: `Credenciales inválidas`

Causa común: el hash de contraseña almacenado en `users.pass_user` no corresponde a la contraseña ingresada. Verifique que el registro se haya creado con `generate_password_hash` y que esté comparando contra la contraseña correcta.

### Error: `Can't connect to MySQL server`

Verifique que MySQL esté corriendo:

```bash
# Linux
sudo systemctl status mysql

# Windows
net start MySQL80
```

### Error: `SECRET_KEY not set` o sesiones que expiran inmediatamente

Asegúrese de que `SECRET_KEY` en `.env` tenga un valor definido y que Flask esté cargando el archivo `.env` correctamente.

### Los archivos estáticos no cargan (CSS/JS)

En modo desarrollo esto no debería ocurrir. En producción con Nginx, verifique que el bloque `location /static/` en la configuración de Nginx apunte correctamente al directorio `static/` del proyecto.
