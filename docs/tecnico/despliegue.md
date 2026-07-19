# Guía de Despliegue — BrokerCore

Esta guía cubre el despliegue de BrokerCore en entornos de desarrollo y producción. Hay tres rutas de despliegue soportadas, en orden de uso recomendado:

1. **Render.com** — producción actual.
2. **Docker** — alternativa portable, para levantar el mismo entorno en cualquier máquina o proveedor con soporte de contenedores.
3. **Manual (Nginx + systemd)** — alternativa bare-metal, para quien necesita o prefiere administrar el servidor directamente.

---

## Despliegue en Render.com (producción actual)

BrokerCore está desplegado en producción en [Render](https://render.com), configurado por el archivo `render.yaml` en la raíz del repositorio:

```yaml
services:
  - type: web
    name: broker-suite
    env: python
    buildCommand: "pip install --no-cache-dir -r requirements.txt"
    startCommand: "python wsgi.py"
    envVars:
      - key: SECRET_KEY
        generateValue: true
      - key: DATABASE_URL
        sync: false
      - key: MYSQL_SSL
        value: "true"
```

Notas:
- `SECRET_KEY` se genera automáticamente por Render al crear el servicio.
- `DATABASE_URL` es un secret que se configura manualmente en el dashboard de Render (no vive en el repositorio). Apunta típicamente a una instancia de TiDB Cloud.
- `MYSQL_SSL=true` fuerza la conexión TLS, requerida por TiDB Cloud.
- Render maneja HTTPS y el proceso del servidor (reinicios, logs) automáticamente; no hace falta configurar Nginx ni systemd en esta ruta.

Para desplegar cambios: hacer push a la rama conectada en Render (o el deploy manual desde el dashboard), Render reconstruye la imagen y reinicia el servicio.

---

## Despliegue con Docker (alternativa portable)

El repositorio incluye `Dockerfile`, `.dockerignore` y `docker-compose.yml` para levantar BrokerCore en cualquier entorno con Docker, como alternativa a Render.

**`Dockerfile`:** parte de `python:3.11-slim` (misma versión que `runtime.txt`), instala `ca-certificates` (necesario para que PyMySQL pueda validar TLS contra TiDB Cloud), instala `requirements.txt` y ejecuta `python wsgi.py`. Expone el puerto de la variable `$PORT` (por defecto `8000`).

**`docker-compose.yml`:** define un único servicio `app`, que construye la imagen desde el `Dockerfile`, mapea el puerto `8000` al host, y lee las variables de entorno desde un archivo `.env` local (gitignored, nunca se commitea).

```bash
cp .env.example .env
# completar DATABASE_URL/MYSQL_URL, SECRET_KEY, MYSQL_SSL, etc.

docker compose up --build
```

La aplicación queda disponible en `http://localhost:8000`. Para correrla en segundo plano: `docker compose up --build -d`. Para detenerla: `docker compose down`.

Esta ruta no requiere entorno virtual de Python ni instalar dependencias en el host — todo corre dentro del contenedor.

---

## Despliegue manual (Nginx + systemd, bare-metal)

Esta es la alternativa para quien necesita administrar el servidor directamente, sin Render ni Docker.

### Modo desarrollo

El servidor de desarrollo está configurado en `run.py`:

```python
# run.py
app.run(host='0.0.0.0', port=5600, debug=True)
```

Para iniciarlo:

```bash
source venv/bin/activate
python run.py
```

La aplicación queda disponible en `http://localhost:5600`.

**Importante:** El modo debug de Flask NO debe usarse en producción. Expone información interna del sistema ante errores y permite ejecución de código arbitrario.

---

### Modo producción con waitress

`wsgi.py` configura waitress como servidor WSGI de producción. Waitress es compatible con Linux y Windows y no requiere software adicional del sistema operativo.

```bash
source venv/bin/activate
python wsgi.py
```

La aplicación queda disponible en el puerto `8000` (o el que esté configurado en `wsgi.py`).

Waitress maneja múltiples workers y es adecuado para carga moderada. Para tráfico muy alto, considere agregar Nginx como proxy inverso (ver sección siguiente).

---

### Nginx como proxy inverso (Linux)

Se recomienda poner Nginx delante de waitress para:
- Terminar SSL (HTTPS).
- Servir archivos estáticos directamente sin pasar por Python.
- Manejar reconexiones y keep-alive de forma más eficiente.

#### Instalación de Nginx

```bash
sudo apt update
sudo apt install nginx
```

#### Configuración del sitio

Cree el archivo de configuración del sitio:

```bash
sudo nano /etc/nginx/sites-available/brokercore
```

Contenido del archivo:

```nginx
server {
    listen 80;
    server_name su-dominio.com;  # Reemplazar con el dominio real o IP del servidor

    # Redirigir HTTP a HTTPS (descomente si tiene certificado SSL)
    # return 301 https://$host$request_uri;

    # Archivos estáticos servidos directamente por Nginx
    location /static/ {
        alias /ruta/al/proyecto/broker-suite/static/;
        expires 7d;
        add_header Cache-Control "public, immutable";
    }

    # Todo lo demás pasa a waitress
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}
```

Para configuración con SSL (usando Certbot/Let's Encrypt):

```nginx
server {
    listen 443 ssl;
    server_name su-dominio.com;

    ssl_certificate /etc/letsencrypt/live/su-dominio.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/su-dominio.com/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    location /static/ {
        alias /ruta/al/proyecto/broker-suite/static/;
        expires 7d;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Redirigir HTTP a HTTPS
server {
    listen 80;
    server_name su-dominio.com;
    return 301 https://$host$request_uri;
}
```

Activar el sitio y recargar Nginx:

```bash
sudo ln -s /etc/nginx/sites-available/brokercore /etc/nginx/sites-enabled/
sudo nginx -t          # Verificar sintaxis
sudo systemctl reload nginx
```

---

### Gestión del proceso con systemd (Linux)

Para que BrokerCore inicie automáticamente con el servidor y se reinicie ante fallos, cree un servicio systemd:

```bash
sudo nano /etc/systemd/system/brokercore.service
```

Contenido:

```ini
[Unit]
Description=BrokerCore Insurance Management System
After=network.target mysql.service

[Service]
User=brokercore
Group=brokercore
WorkingDirectory=/ruta/al/proyecto/broker-suite
Environment="PATH=/ruta/al/proyecto/broker-suite/venv/bin"
EnvironmentFile=/ruta/al/proyecto/broker-suite/.env
ExecStart=/ruta/al/proyecto/broker-suite/venv/bin/python wsgi.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Activar y arrancar el servicio:

```bash
sudo systemctl daemon-reload
sudo systemctl enable brokercore
sudo systemctl start brokercore

# Verificar estado
sudo systemctl status brokercore

# Ver logs en tiempo real
sudo journalctl -u brokercore -f
```

---

### Despliegue en Windows

En Windows, waitress funciona de forma nativa. Para ejecutarlo como servicio de Windows, use **NSSM (Non-Sucking Service Manager)**:

1. Descargue NSSM desde [nssm.cc](https://nssm.cc/download).
2. Abra una terminal como Administrador.
3. Instale el servicio:

```cmd
nssm install BrokerCore "C:\ruta\al\proyecto\venv\Scripts\python.exe" "C:\ruta\al\proyecto\wsgi.py"
nssm set BrokerCore AppDirectory "C:\ruta\al\proyecto"
nssm start BrokerCore
```

---

### Permisos de carpetas de archivos

BrokerCore escribe archivos en dos carpetas dentro de `static/`. El usuario del sistema operativo que ejecuta la aplicación debe tener permisos de escritura en estas rutas:

```bash
# Linux: ajustar propietario y permisos
chown -R brokercore:brokercore /ruta/al/proyecto/broker-suite/static/fotos_empleados
chown -R brokercore:brokercore /ruta/al/proyecto/broker-suite/static/downloads-excel
chmod -R 755 /ruta/al/proyecto/broker-suite/static/fotos_empleados
chmod -R 755 /ruta/al/proyecto/broker-suite/static/downloads-excel
```

| Carpeta | Contenido |
|---|---|
| `static/fotos_empleados/` | Fotos de empleados subidas desde el módulo de Empleados. |
| `static/downloads-excel/` | Archivos Excel generados temporalmente. Se pueden limpiar periódicamente. |

---

### Variables de entorno en producción

En producción, el archivo `.env` debe:
1. Tener permisos restrictivos: `chmod 600 .env`
2. Pertenecer al usuario que corre la aplicación: `chown brokercore:brokercore .env`
3. No estar dentro del directorio servido por Nginx (ya está en la raíz del proyecto, que no es `static/`).

Para mayor seguridad, puede usar el `EnvironmentFile` de systemd (como se muestra arriba) en lugar de depender de que la aplicación lea `.env` directamente.

---

### Actualizar la aplicación

Para actualizar BrokerCore en producción:

```bash
# 1. Ir al directorio del proyecto
cd /ruta/al/proyecto/broker-suite

# 2. Respaldar la base de datos antes de aplicar cambios
mysqldump -u root -p brokercore > backup_$(date +%Y%m%d_%H%M%S).sql

# 3. Obtener los cambios
git pull origin main   # Si usa Git
# o descomprimir el nuevo ZIP en el directorio

# 4. Actualizar dependencias si requirements.txt cambió
source venv/bin/activate
pip install -r requirements.txt

# 5. Aplicar migraciones SQL si las hay
mysql -u root -p brokercore < BD/nueva_migracion.sql

# 6. Reiniciar el servicio
sudo systemctl restart brokercore

# 7. Verificar que inició correctamente
sudo systemctl status brokercore
```

---

### Certificado SSL con Let's Encrypt (Linux)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d su-dominio.com

# La renovación automática se configura sola; verificar con:
sudo certbot renew --dry-run
```
