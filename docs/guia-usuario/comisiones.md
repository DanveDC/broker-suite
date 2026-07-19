# Módulo de Comisiones

> **Acceso requerido:** Roles Administración y Gerencia.

## ¿Qué son las comisiones?

Las **comisiones** son los pagos que las aseguradoras realizan a la corredora como retribución por las pólizas gestionadas. El módulo de comisiones de BrokerCore permite:

1. Registrar manualmente una comisión recibida de una aseguradora, vinculada a la póliza y al pago (cuota/recibo) correspondiente.
2. Agrupar los registros en un bloque de pago, con soporte para retenciones.
3. Confirmar el bloque para dejarlo registrado en el sistema.
4. Generar reportes de comisiones por ejecutivo y por período.

---

## Registrar una comisión recibida (Carga Manual)

1. Acceda a **Registro de Comisión Recibida** desde el menú lateral (dentro de la sección Comisiones).
2. Si todavía no hay ningún registro cargado, verá la tarjeta **Carga Manual**. Haga clic en ella para abrir el formulario.
3. En el formulario:
   - **Buscar Póliza:** ingrese el número de póliza y haga clic en **Buscar**.
   - **Seleccionar Cuota/Recibo Pagado:** el sistema solo muestra los pagos con estado "PAGADO" de esa póliza.
   - Complete **Monto Comisión (USD)**, **Tasa de Cambio** y una **Descripción/Movimiento** (por ejemplo, "COMISION 1RA CUOTA").
4. Haga clic en **Agregar a Tabla**. La línea queda agregada al bloque que se está armando.
5. Repita el proceso para cada comisión que quiera registrar en el mismo bloque.

> **Nota:** Los parsers automáticos por aseguradora que existían en versiones anteriores (carga de archivo Excel/PDF con emparejamiento automático) ya no están disponibles desde el menú. El registro de comisiones se hace exclusivamente por Carga Manual.

---

## Confirmar el bloque de pago

Una vez agregadas todas las líneas correspondientes a un bloque:

1. Si corresponde, use **Agregar Retención** para descontar una retención del bloque antes de confirmarlo.
2. Revise el resumen del bloque (información y totales en la parte superior de la pantalla).
3. Haga clic en **Confirmar Bloque** para guardar el registro.

Si necesita descartar lo cargado y empezar de nuevo antes de confirmar, use **Otra Carga**.

---

## Generar reporte de comisiones por ejecutivo

Una vez confirmadas las comisiones, puede generar reportes detallados:

1. Acceda a **Comisiones → Reportes**.
2. Seleccione:
   - **Ejecutivo** (o "Todos" para un reporte consolidado).
   - **Rango de fechas** (período a reportar).
   - **Aseguradora** (opcional, para filtrar por compañía).
3. Haga clic en **Generar Reporte**.

El reporte se puede exportar a **Excel** o **PDF** y muestra:
- Detalle de cada póliza con comisión en el período.
- Porcentaje de comisión aplicado.
- Monto de comisión en Bs y USD.
- Subtotales por aseguradora y ejecutivo.

---

## Configurar porcentajes de comisión

Los porcentajes de comisión que aplica la corredora se configuran por aseguradora y tipo de ramo. Esta configuración se almacena en la tabla `comisiones_config`.

Para modificar los porcentajes:

1. Acceda a **Comisiones → Configuración**.
2. Seleccione la aseguradora.
3. Edite el porcentaje para cada ramo (HCM, Auto, Patrimonial, etc.).
4. Guarde los cambios.

> **Nota:** Los cambios en los porcentajes afectan los cálculos de comisiones nuevas, pero no recalculan retroactivamente las comisiones ya registradas. Si necesita corregir comisiones pasadas, contacte al administrador del sistema.

---

## Bloqueo de pagos de comisión

El sistema permite marcar bloques de comisiones como "pagadas" mediante los registros en `bloque_pago_comision`. Esto indica que la corredora ya distribuyó esas comisiones a los ejecutivos correspondientes.

---

## Preguntas frecuentes

**¿Puedo registrar una comisión para una cuota que todavía no está pagada?**
No. El buscador de Carga Manual solo muestra cuotas/recibos con estado "PAGADO" de la póliza seleccionada.

**Cargué una línea con datos incorrectos antes de confirmar el bloque, ¿cómo la corrijo?**
Use **Otra Carga** para descartar el bloque en construcción y empezar de nuevo, o contacte al administrador si el bloque ya fue confirmado.

**¿Qué pasa con los datos de comisiones cargados con el sistema anterior (por aseguradora)?**
Los registros previos se conservan. Lo que cambió es la forma de cargar comisiones nuevas: ahora es exclusivamente manual.
