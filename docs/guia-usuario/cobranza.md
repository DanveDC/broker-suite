# Módulo de Cobranza

## ¿Qué es la cobranza?

El módulo de **Cobranza** centraliza el seguimiento del cobro de primas: permite ver qué pagos se han recibido, cuáles están pendientes, y proyectar los ingresos esperados para el año. Es el complemento operativo del módulo de Pólizas, enfocado en la perspectiva financiera.

---

## Listado de pagos

Al acceder al módulo de **Cobranza** desde el menú lateral, se muestra el listado completo de pagos registrados en el sistema.

### Información mostrada por pago

| Columna | Descripción |
|---|---|
| **Fecha** | Fecha en que se registró el pago |
| **Asegurado** | Nombre del titular de la póliza |
| **Póliza** | Código de la póliza correspondiente |
| **Compañía** | Aseguradora a la que pertenece la póliza |
| **Ramo** | Tipo de seguro |
| **Monto** | Monto cobrado al asegurado |
| **Moneda** | Bs o USD |
| **Método de pago** | Transferencia, efectivo, punto de venta, Zelle, etc. |
| **Estado** | Cobrado / Pendiente |
| **Ejecutivo** | Ejecutivo responsable de esa póliza |

---

## Filtros disponibles

El listado de cobranza puede filtrarse por:

- **Período:** Seleccione mes y año para ver los pagos de ese período.
- **Estado:** Cobrado, Pendiente, o todos.
- **Compañía:** Para ver los cobros correspondientes a una aseguradora específica.
- **Ejecutivo:** Para ver la cobranza gestionada por un ejecutivo en particular.
- **Moneda:** Para separar la vista en Bs y USD.
- **Ramo:** Por tipo de póliza.

---

## Proyección anual

La vista de **Proyección Anual** muestra una tabla con los ingresos de primas mes a mes para el año en curso, permitiendo:

- Identificar los meses con mayor y menor flujo de cobros.
- Detectar pólizas con pagos atrasados.
- Estimar los ingresos pendientes de cobro para el resto del año.

Para acceder: **Cobranza → Proyección Anual**.

La proyección calcula los cobros esperados basándose en las pólizas activas y sus frecuencias de pago, comparándolos contra los pagos efectivamente registrados.

---

## Vista de cobranza de comisiones

Esta vista cruza la información de pagos con las comisiones generadas, mostrando:

- Cuánto de lo cobrado corresponde a comisión de la corredora.
- Estado de distribución de esas comisiones a los ejecutivos.

Acceda desde: **Cobranza → Comisiones por Cobrar**.

---

## Exportar a Excel

Desde cualquier vista del módulo de Cobranza, puede exportar los datos filtrados a un archivo Excel:

1. Aplique los filtros deseados.
2. Haga clic en el botón **Exportar a Excel** (ícono de hoja de cálculo).
3. El archivo se descargará automáticamente con los datos de la vista actual.

El archivo Excel incluye todas las columnas visibles en la tabla y un resumen de totales al final.

> **Nota técnica:** Los archivos Excel generados se almacenan temporalmente en `static/downloads-excel/` antes de enviarse al navegador. Esta carpeta se limpia periódicamente de manera automática.

---

## Registrar un cobro desde Cobranza

Si detecta un pago pendiente desde esta vista, puede marcarlo como cobrado sin necesidad de ir al módulo de Pólizas:

1. Ubique la fila del pago pendiente.
2. Haga clic en **Registrar cobro**.
3. Complete los datos del pago (fecha, método, referencia).
4. Confirme.

El registro se actualizará en tiempo real en la vista de cobranza.
