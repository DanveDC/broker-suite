# Guía de Instalación — BrokerCore

Esta guía cubre la instalación completa de BrokerCore desde cero, incluyendo dependencias, base de datos, primer usuario administrador y configuración del servidor.

---

## Requisitos previos

| Componente | Versión mínima | Notas |
|---|---|---|
| Python | 3.10+ | Se recomienda 3.11 |
| MySQL | 8.0+ | Debe tener acceso root o usuario con privilegios de creación |
| pip | Incluido con Python | Actualizar con `pip install --upgrade pip` |
| Git | Cualquier versión reciente | Opcional si se entrega como ZIP |

**Sistema operativo:** Linux (recomendado para producción) o Windows (desarrollo y producción con waitress).

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

Este comando instala Flask, mysql-connector-python, pandas, openpyxl, reportlab, waitress y el resto de las dependencias del proyecto.

---

## Paso 4 — Configurar variables de entorno

Copie el archivo de ejemplo y edítelo:

```bash
cp .env.example .env
```

Abra `.env` en un editor de texto y complete cada variable. Consulte [`docs/configuracion.md`](./configuracion.md) para la descripción detallada de cada una. Como mínimo, configure:

```dotenv
DB_HOST=localhost
DB_PORT=3306
DB_NAME=brokercore
DB_FALLBACK_USER=admin_brokercore
DB_FALLBACK_PASSWORD=contraseña_segura
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

## Paso 7 — Crear el primer usuario MySQL administrador

BrokerCore utiliza un modelo de autenticación acoplado a MySQL: cada usuario de la aplicación es también un usuario real de MySQL con los permisos correspondientes a su rol. Esto permite que los controles de acceso se apliquen a nivel de base de datos.

Conéctese a MySQL como root y cree el usuario administrador:

```sql
-- Crear el usuario MySQL para el primer administrador
CREATE USER 'correo@ejemplo.com'@'localhost' IDENTIFIED BY 'contraseña_del_usuario';

-- Otorgar todos los privilegios necesarios para el rol Administración
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON brokercore.* TO 'correo@ejemplo.com'@'localhost';

FLUSH PRIVILEGES;
```

> **Nota:** El nombre de usuario MySQL debe ser exactamente la dirección de correo electrónico que usará el administrador para iniciar sesión en BrokerCore.

---

## Paso 8 — Crear el primer usuario en la tabla `users`

La tabla `users` de la aplicación almacena los metadatos del usuario y el hash de su contraseña para verificación. Debe crear el registro manualmente para el primer administrador.

Ejecute el siguiente script Python desde el directorio raíz del proyecto (con el entorno virtual activo):

```python
from werkzeug.security import generate_password_hash
import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

conn = mysql.connector.connect(
    host=os.getenv('DB_HOST'),
    port=int(os.getenv('DB_PORT', 3306)),
    database=os.getenv('DB_NAME'),
    user=os.getenv('DB_FALLBACK_USER'),
    password=os.getenv('DB_FALLBACK_PASSWORD')
)

cursor = conn.cursor()

email = 'correo@ejemplo.com'          # Debe coincidir con el usuario MySQL del paso anterior
nombre = 'Administrador'
apellido = 'Principal'
password = 'contraseña_del_usuario'   # Misma contraseña del usuario MySQL
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

## Paso 9 — Iniciar el servidor de desarrollo

```bash
python run.py
```

El servidor quedará disponible en `http://localhost:5600`. Verifique en la terminal que aparece el mensaje de inicio de Flask sin errores.

---

## Paso 10 — Verificar el inicio de sesión

1. Abra `http://localhost:5600` en el navegador.
2. Ingrese el correo electrónico y la contraseña del administrador creado.
3. Debe acceder al dashboard principal.

Si la autenticación falla, revise la sección de [Solución de problemas](#solución-de-problemas) al final de este documento.

---

## Despliegue en producción

Para entornos de producción, BrokerCore incluye `wsgi.py` que utiliza **waitress** como servidor WSGI. Waitress es compatible con Linux y Windows.

### Usando waitress directamente

```bash
python wsgi.py
```

Esto inicia el servidor en el puerto `8000` (configurable en `wsgi.py`).

### Usando waitress detrás de Nginx (recomendado)

Consulte la guía completa en [`docs/tecnico/despliegue.md`](./tecnico/despliegue.md), que incluye:
- Configuración de Nginx como proxy inverso.
- Configuración de SSL/HTTPS.
- Gestión del proceso con systemd (Linux) o como servicio de Windows.

---

## Solución de problemas

### Error: `ModuleNotFoundError: No module named 'flask'`

El entorno virtual no está activo o las dependencias no se instalaron.

```bash
source venv/bin/activate   # Linux
pip install -r requirements.txt
```

### Error: `mysql.connector.errors.ProgrammingError: Access denied for user`

Las credenciales en `.env` son incorrectas, o el usuario MySQL no fue creado con los permisos correctos. Verifique:

```sql
-- En MySQL, verificar permisos del usuario
SHOW GRANTS FOR 'correo@ejemplo.com'@'localhost';
```

### Error al iniciar sesión: `Credenciales inválidas`

Causas comunes:
1. El hash de contraseña en `users` no corresponde a la contraseña del usuario MySQL. Ambas deben ser la misma contraseña.
2. El correo electrónico en `users.email_user` no coincide exactamente con el usuario MySQL (incluyendo mayúsculas/minúsculas).

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
