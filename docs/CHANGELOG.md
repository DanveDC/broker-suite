# Changelog — BrokerCore

Todas las versiones de este proyecto están documentadas en este archivo.

El formato sigue [Keep a Changelog](https://keepachangelog.com/es/1.0.0/).

---

## [Sin versionar] — 2026-07-21

### Agregado

- **Gestión de Producto:** nuevo módulo CRUD para administrar el catálogo Compañía → Ramo → Subramo → Producto (tabla `catalogo_producto`, soft-delete vía `activo`), que reemplaza el objeto JavaScript hardcodeado que vivía en el formulario de pólizas. Incluye migración de los ~234 productos existentes.
- Sistema de diseño unificado: tokens de radio (`--radius-sm/md/lg/pill`) y sombra (`--shadow-sm/lg`) consolidados en `static/assets/css/my_style.css`, con una paleta secundaria (`--analytics-*`) para los dashboards de BI.
- Partial reutilizable de estado vacío (`templates/public/includes/empty_state.html`) y clase de utilidad `.list-toolbar`, aplicados en Ejecutivos, Usuarios, Compañías, Siniestros, Asegurados y Gestión de Producto.
- Accesibilidad WCAG 2.1 AA: `aria-label` en botones de solo ícono, asociación `label`/`input` vía `for`/`id`, landmark `<main>` en el layout base, contraste de texto corregido.
- Microinteracciones: transiciones en botones, dropdowns y acordeones, estados de carga en acciones AJAX, overlay de DataTables estilizado — todo respetando `prefers-reduced-motion`.
- Presentación de producto en HTML (`docs/presentacion/presentacion.html`) y guión de demo (`docs/presentacion/DEMO-GUION.md`).

### Corregido

- **Crítico:** 17 funciones en `controllers/funciones_home.py` usaban `TO_CHAR()` (sintaxis PostgreSQL) contra una conexión MySQL — cada una tiraba un error de SQL silenciosamente convertido en `None`, causando 500 en Pólizas, Comisiones, Empleados y otros módulos. Reemplazado por `DATE_FORMAT()`.
- **Crítico:** rutas con rutas de plantilla en minúscula (`public/poliza/...`, `public/ejecutivo/...`) que solo funcionaban en filesystems case-insensitive (Windows/WSL) — rompían en Linux (Render) con `TemplateNotFound`.
- **Crítico:** tres `url_for()` apuntando a endpoints inexistentes (`inicioCpanel`, `index`, `main.listaEjecutivo`) causaban `BuildError` (500) en cualquier acceso sin sesión a esas rutas.
- Formulario de pólizas: normalizado el mismatch `Fianza`/`Fianzas` y `Viaje`/`Viajes` entre el catálogo y el `<select>` de Ramo, que dejaba productos de Viaje internacional inalcanzables; agregado el Ramo "Mascotas", ausente desde siempre.
- Botón "Crear Nuevo Usuario" vivía dentro del bloque condicional de lista no vacía — no había forma de crear un usuario cuando la lista estaba vacía.

---

## [Sin versionar] — 2026-07-18

### Cambiado

- **Base de datos:** revertida la migración a Postgres (intento abandonado) y consolidado el acceso a MySQL/TiDB Cloud vía PyMySQL (`conexion/conexionBD.py`). Se eliminaron las dependencias `psycopg2`/`pg8000` de `requirements.txt`.
- **Comisiones (beta):** simplificado el flujo de carga a **solo Carga Manual**. Se removieron del sidebar las tarjetas de carga por aseguradora (Star, Caracas, Mercantil, Internacional, Oceánica, Pirámide, Venezuela, Universitas, Banesco); las rutas de esos parsers siguen existiendo en el backend pero ya no están enlazadas desde el menú.
- **Sidebar:** el ítem "Comisiones Recibidas" se renombró a **"Registro de Comisión Recibida"**. Se removió el sub-ítem "Pólizas Pendientes" de la sección Pólizas. Se removió el módulo "Carga Masiva" del menú (las rutas `/upload` y `/upload_mercantil` siguen existiendo, solo quedaron sin acceso desde la UI).

### Agregado

- Soporte de despliegue con **Docker**: `Dockerfile` (`python:3.11-slim`, con `ca-certificates` para TLS contra TiDB), `.dockerignore` y `docker-compose.yml` (servicio único `app`, variables desde `.env` local). Es una alternativa adicional a Render.com, no un reemplazo.

---

## [1.0.0] — 2024

### Lanzamiento inicial

Primera versión de BrokerCore, sistema de gestión integral para corredoras de seguros venezolanas.

#### Módulos incluidos

- **Asegurados** — Registro y búsqueda de personas aseguradas por cédula de identidad. Soporte de campos: profesión, localidad, canal, ejecutivo asignado.

- **Pólizas** — Gestión completa del ciclo de vida de pólizas para cinco tipos: Persona/HCM, Auto, Patrimonial, Viaje y Fianza. Incluye creación, renovación, pagos de prima, transferencia y anulación.

- **Pagos** — Registro de cobros de primas con soporte de monedas (Bs/USD), tasa de cambio BCV automática, múltiples métodos de pago y control de cuotas.

- **Siniestros** — Gestión de tres tipos de siniestro: Carta Aval (pre-autorización médica), Reembolso médico y Siniestro de Auto. Sistema de notas de seguimiento por siniestro.

- **Comisiones** — Carga y procesamiento de reportes de comisiones de 9 aseguradoras (Star, Caracas, Pirámide, Universitas, Banesco, Venezuela, Internacional, Mercantil, Oceánica). Emparejamiento automático con pólizas mediante similitud de texto. Gestión de pólizas pendientes (no emparejadas). Reportes por ejecutivo con exportación a Excel. Configuración de porcentajes por aseguradora y ramo.

- **Cobranza** — Seguimiento de cobros de primas, proyección anual, vista de comisiones por cobrar y exportación a Excel.

- **Ejecutivos** — CRUD de ejecutivos de ventas.

- **Compañías** — CRUD de compañías aseguradoras.

- **Empleados** — Gestión de personal interno con carga de foto.

- **Usuarios y Roles** — Administración de usuarios con cuatro roles: Administración, Gerencia, Operaciones, Ventas. Creación automática de usuarios MySQL acoplada a la creación de usuarios de la app. Recuperación de contraseña por email.

- **Dashboard** — Panel de control con indicadores de negocio usando ApexCharts. Vista BI Master Control y Sales Dashboard.

- **Carga Masiva** — Importación de datos desde CSV/Excel con flujo de previsualización y confirmación.

- **Reportes** — Generación del reporte regulatorio Sudaseg.

#### Stack tecnológico

- Flask 2.3.2 (Python 3.10+)
- MySQL 8.0 con mysql-connector-python
- Jinja2 + Sneat Bootstrap 5 Admin UI
- waitress (servidor WSGI para producción)
- pandas / openpyxl / reportlab (procesamiento y exportación de datos)
- pyDolarVenezuela (tasa de cambio BCV en tiempo real)

#### Infraestructura de base de datos

- 27 tablas incluyendo entidades principales, extensiones por tipo de póliza y tablas auxiliares.
- Sistema de auditoría completo mediante triggers de MySQL sobre tabla `bitacora`.
- Modelo de autenticación acoplado a usuarios MySQL por rol.
