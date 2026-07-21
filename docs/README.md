# BrokerCore — Sistema de Gestión para Corredoras de Seguros

## ¿Qué es BrokerCore?

BrokerCore es un sistema de gestión integral diseñado específicamente para corredoras de seguros. Desarrollado en Flask (Python) con base de datos MySQL, centraliza la administración de asegurados, pólizas, siniestros, comisiones y cobranzas en una única plataforma web accesible desde cualquier navegador. Incluye un panel de control con indicadores de negocio en tiempo real, gestión de usuarios por roles y herramientas de importación/exportación de datos.

> **Documento principal:** [BrokerCore-Funcionalidades-y-Requerimientos.docx](./BrokerCore-Funcionalidades-y-Requerimientos.docx) — funcionalidades y requerimientos completos del sistema. Punto de partida recomendado para cualquiera que se sume al proyecto.

---

## Módulos principales

- **Asegurados** — Registro y búsqueda de personas aseguradas por cédula de identidad.
- **Pólizas** — Gestión del ciclo completo de pólizas (Persona/HCM, Auto, Patrimonial, Viaje, Fianza), incluyendo renovaciones, pagos y anulaciones.
- **Siniestros** — Seguimiento de reclamaciones: Carta Aval, Reembolso médico y Siniestro de Auto.
- **Gestión de Producto** — Catálogo administrable de Compañía → Ramo → Subramo → Producto que alimenta el formulario de pólizas, con altas/bajas restringidas por rol.
- **Comisiones** — Registro de comisiones recibidas de las aseguradoras (carga manual) y generación de reportes por ejecutivo.
- **Cobranza** — Seguimiento de cobros de primas, proyección anual y exportación a Excel.
- **Ejecutivos** — CRUD de ejecutivos de ventas.
- **Compañías** — CRUD de compañías aseguradoras.
- **Empleados** — Gestión de empleados internos con foto.
- **Usuarios y Roles** — Administración de accesos: Administración, Gerencia, Operaciones, Ventas.
- **Dashboard** — Panel de control con visualizaciones (ApexCharts) de ventas y operaciones.
- **Reportes** — Generación del reporte regulatorio Sudaseg.

---

## ¿Para quién es BrokerCore?

BrokerCore está diseñado para corredoras de seguros venezolanas que necesitan:
- Centralizar la operación en un sistema accesible por todo el equipo.
- Gestionar comisiones de múltiples aseguradoras.
- Mantener un registro auditado de todas las operaciones.
- Generar reportes regulatorios (Sudaseg) y reportes internos por ejecutivo.

---

## Inicio rápido

1. **Instalación** — Siga la guía completa en [`instalacion/instalacion.md`](./instalacion/instalacion.md) para configurar el entorno, la base de datos y el primer usuario administrador.
2. **Configuración** — Revise las variables de entorno en [`instalacion/configuracion.md`](./instalacion/configuracion.md).
3. **Primer ingreso** — Inicie el servidor con `python run.py` y acceda a `http://localhost:5600` con las credenciales del usuario administrador creado durante la instalación.

---

## Índice de documentación

### Documento principal

| Documento | Descripción |
|---|---|
| [BrokerCore-Funcionalidades-y-Requerimientos.docx](./BrokerCore-Funcionalidades-y-Requerimientos.docx) | Funcionalidades y requerimientos técnico-funcionales completos del sistema |

### Presentación

| Documento | Descripción |
|---|---|
| [presentacion/RESUMEN-EJECUTIVO.md](./presentacion/RESUMEN-EJECUTIVO.md) | Resumen de una página: problema, módulos, stack y estado actual |
| [presentacion/DEMO-GUION.md](./presentacion/DEMO-GUION.md) | Guión paso a paso para la demo en vivo |
| [presentacion/presentacion.html](./presentacion/presentacion.html) | Presentación de producto en HTML — abrir en cualquier navegador |
| [presentacion/BrokerCore-Presentacion.pptx](./presentacion/BrokerCore-Presentacion.pptx) | Presentación de producto en slides (versión anterior, puede estar desactualizada) |

### Guías de usuario

| Documento | Descripción |
|---|---|
| [guia-usuario/README.md](./guia-usuario/README.md) | Índice de guías de usuario y sistema de roles |
| [guia-usuario/asegurados.md](./guia-usuario/asegurados.md) | Gestión de asegurados |
| [guia-usuario/polizas.md](./guia-usuario/polizas.md) | Gestión de pólizas, renovaciones y pagos |
| [guia-usuario/siniestros.md](./guia-usuario/siniestros.md) | Registro y seguimiento de siniestros |
| [guia-usuario/comisiones.md](./guia-usuario/comisiones.md) | Procesamiento de comisiones por aseguradora |
| [guia-usuario/cobranza.md](./guia-usuario/cobranza.md) | Seguimiento de cobranza y proyección anual |
| [guia-usuario/usuarios-y-roles.md](./guia-usuario/usuarios-y-roles.md) | Gestión de usuarios y permisos |

### Documentación técnica

| Documento | Descripción |
|---|---|
| [tecnico/arquitectura.md](./tecnico/arquitectura.md) | Arquitectura general del sistema |
| [tecnico/base-de-datos.md](./tecnico/base-de-datos.md) | Esquema de base de datos y relaciones |
| [tecnico/despliegue.md](./tecnico/despliegue.md) | Despliegue en desarrollo y producción |
| [tecnico/seguridad.md](./tecnico/seguridad.md) | Postura de seguridad y recomendaciones |
| [tecnico/limitaciones-conocidas.md](./tecnico/limitaciones-conocidas.md) | Deuda técnica conocida y próximos pasos |

### Instalación y configuración

| Documento | Descripción |
|---|---|
| [instalacion/instalacion.md](./instalacion/instalacion.md) | Guía de instalación paso a paso |
| [instalacion/configuracion.md](./instalacion/configuracion.md) | Referencia completa de variables de entorno |
| [CHANGELOG.md](./CHANGELOG.md) | Historial de versiones |
