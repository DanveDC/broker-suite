# BrokerCore — Guión de Demo

Guión para una demo en vivo de ~15 minutos. Pensado para mostrar el camino completo del negocio, no una lista de features sueltas.

## Antes de empezar

- Tener un usuario de prueba con rol **Administración** (acceso a todos los módulos).
- Tener al menos una compañía, un ejecutivo y un asegurado ya cargados, para no perder tiempo llenando formularios en vivo.
- Abrir la app en un monitor grande o compartir pantalla a resolución 1080p — el sidebar y las tablas se ven mejor con espacio.

---

## 1. Login y Dashboard (1 min)

Entrar con el usuario de prueba. Mostrar el dashboard: KPIs de negocio en tiempo real (pólizas activas, comisiones del mes, cobranza pendiente).

**Mensaje clave:** "Esto no es una planilla más — es un panel que se actualiza solo con la operación diaria."

## 2. Asegurados (1 min)

Buscar un asegurado existente por cédula. Mostrar la ficha completa: datos personales, pólizas asociadas, historial.

**Mensaje clave:** "Un asegurado, un lugar. No hay que buscarlo en tres archivos distintos."

## 3. Alta de póliza — el corazón del sistema (4 min)

Registrar una póliza nueva paso a paso:
1. Elegir asegurado, compañía, ramo (Persona, Auto, Patrimonial, Viaje o Fianza).
2. Mostrar cómo el Subramo y el Producto se filtran automáticamente según la compañía y el ramo elegidos — vienen del catálogo, no son texto libre.
3. Completar prima, frecuencia de pago y guardar.

**Mensaje clave:** "Los productos que ofrece cada aseguradora están centralizados en un catálogo administrable (módulo Gestión de Producto) — si una aseguradora agrega o discontinúa un producto, se actualiza en un solo lugar y se refleja en el formulario de pólizas al instante, sin tocar código."

## 4. Gestión de Producto (2 min)

Abrir el módulo nuevo. Mostrar la lista de productos por compañía/ramo/subramo, con búsqueda en vivo. Agregar un producto de prueba y mostrar cómo aparece inmediatamente disponible al volver al formulario de pólizas.

**Mensaje clave:** "Esto es exactamente el tipo de configuración que antes vivía hardcodeada — ahora cualquier persona con permisos la administra sin depender de un desarrollador."

## 5. Siniestros (2 min)

Mostrar la lista de siniestros (Carta Aval, Reembolso, Auto) con sus estados. Abrir el detalle de uno para mostrar el seguimiento por notas.

**Mensaje clave:** "Seguimiento auditado de cada reclamación, con el historial completo a mano."

## 6. Comisiones y Cobranza (3 min)

Mostrar el registro de comisiones recibidas de una aseguradora y el reporte por ejecutivo. Pasar a Cobranza: proyección anual de cobros y exportación a Excel.

**Mensaje clave:** "El cierre de mes deja de ser un ejercicio de reconstrucción manual — los números ya están ahí."

## 7. Reportes y cierre (2 min)

Mostrar el reporte regulatorio Sudaseg generado desde la app. Cerrar volviendo al dashboard.

**Mensaje clave de cierre:** "Todo lo que viste corre hoy en producción, con una base de datos real. No es un prototipo — es la operación diaria de una corredora, en una sola plataforma."

---

## Preguntas frecuentes que pueden salir

- **"¿Corre en la nube o hay que instalar algo?"** — Está desplegado en Render.com; también hay soporte Docker para quien prefiera hospedarlo en su propia infraestructura.
- **"¿Cuántos usuarios soporta?"** — El sistema maneja roles (Administración, Gerencia, Operaciones, Ventas) con permisos diferenciados por módulo; no hay límite de usuarios en la arquitectura.
- **"¿Qué pasa si una aseguradora cambia sus productos?"** — Se actualiza desde Gestión de Producto, sin tocar código ni depender de un desarrollador.
