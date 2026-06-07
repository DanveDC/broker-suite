# Módulo de Comisiones

> **Acceso requerido:** Roles Administración y Gerencia.

## ¿Qué son las comisiones?

Las **comisiones** son los pagos que las aseguradoras realizan a la corredora como retribución por las pólizas gestionadas. Cada aseguradora emite periódicamente un reporte (generalmente en Excel o PDF) detallando las comisiones correspondientes a cada póliza.

El módulo de comisiones de BrokerCore permite:
1. Cargar el reporte de la aseguradora.
2. Emparejar automáticamente cada línea del reporte con las pólizas registradas en el sistema.
3. Revisar y resolver manualmente los casos que no emparejaron automáticamente.
4. Generar reportes de comisiones por ejecutivo y por período.

---

## Aseguradoras soportadas

BrokerCore tiene parsers especializados para los reportes de las siguientes aseguradoras:

| N° | Aseguradora |
|---|---|
| 1 | Star |
| 2 | Caracas |
| 3 | Pirámide |
| 4 | Universitas |
| 5 | Banesco |
| 6 | Venezuela |
| 7 | Internacional |
| 8 | Mercantil |
| 9 | Oceánica |

Cada aseguradora tiene un formato de reporte distinto. El sistema identifica automáticamente el formato según la aseguradora seleccionada al cargar el archivo.

---

## Flujo completo de procesamiento

### Paso 1 — Cargar el reporte de la aseguradora

1. Acceda al módulo **Comisiones** desde el menú lateral.
2. Haga clic en **Cargar Reporte**.
3. Seleccione la aseguradora de la lista desplegable.
4. Seleccione el archivo del reporte (Excel `.xlsx` o `.xls`, según la aseguradora).
5. Indique el período al que corresponde el reporte (mes y año).
6. Haga clic en **Procesar**.

El sistema analizará el archivo y mostrará un resumen de las líneas encontradas antes de confirmar la carga.

> **Formatos de archivo:** El formato específico esperado varía según la aseguradora. Utilice el archivo tal como lo entrega la compañía de seguros, sin modificarlo. Si el archivo fue alterado (columnas movidas, filas agregadas), el parser puede fallar.

---

### Paso 2 — Emparejamiento automático con pólizas

Una vez procesado el archivo, el sistema intenta emparejar automáticamente cada línea del reporte con una póliza existente en BrokerCore. El emparejamiento se realiza por **código de póliza** (`cod_poliza`), usando coincidencia difusa (fuzzy matching) para tolerar pequeñas diferencias de formato entre la aseguradora y el sistema.

El sistema clasifica cada línea en una de tres categorías:

| Resultado | Descripción |
|---|---|
| **Emparejada** | La póliza fue encontrada con alta confianza. Se crea el registro de comisión automáticamente. |
| **Emparejada con revisión** | Se encontró una póliza similar pero con menor confianza. El usuario debe confirmar. |
| **Sin emparejar** | No se encontró ninguna póliza correspondiente. Va a la cola de pendientes. |

---

### Paso 3 — Revisar pólizas pendientes

Las líneas del reporte que no emparejaron automáticamente se almacenan en la tabla **Pólizas Pendientes** (`polizas_pendientes`). Estas requieren resolución manual.

1. Acceda a **Comisiones → Pólizas Pendientes**.
2. Para cada línea pendiente, el sistema muestra:
   - El código de póliza tal como aparece en el reporte de la aseguradora.
   - El nombre del asegurado (si la aseguradora lo incluye).
   - El monto de la comisión.
3. Para resolver una línea pendiente, tiene tres opciones:

| Acción | Cuándo usarla |
|---|---|
| **Vincular a póliza existente** | La póliza sí existe en BrokerCore pero el código es diferente. Busque la póliza manualmente y confirme el vínculo. |
| **Crear póliza nueva** | La póliza no estaba registrada. El sistema la pre-crea con los datos disponibles del reporte. Deberá completar la información después. |
| **Descartar** | La línea del reporte no corresponde a una póliza de esta corredora (error de la aseguradora, póliza de otra cartera, etc.). |

> **Recomendación:** Revisar las pólizas pendientes el mismo día que se carga el reporte, mientras la información está fresca. Las líneas pendientes sin resolver afectan la precisión de los reportes de comisiones por ejecutivo.

---

### Paso 4 — Generar reporte de comisiones por ejecutivo

Una vez procesadas y emparejadas las comisiones, puede generar reportes detallados:

1. Acceda a **Comisiones → Reportes**.
2. Seleccione:
   - **Ejecutivo** (o "Todos" para un reporte consolidado).
   - **Rango de fechas** (período a reportar).
   - **Aseguradora** (opcional, para filtrar por compañía).
3. Haga clic en **Generar Reporte**.

El reporte se puede exportar a **Excel** y muestra:
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

**¿Qué hago si el archivo de la aseguradora no es reconocido?**
Verifique que seleccionó la aseguradora correcta. Si el formato del archivo cambió (las aseguradoras ocasionalmente actualizan sus plantillas), notifique al equipo de soporte técnico para actualizar el parser.

**¿Por qué una póliza que sí existe aparece como "sin emparejar"?**
El código de póliza en BrokerCore puede estar registrado de forma diferente al que usa la aseguradora en su reporte. Revise ambos y use la opción "Vincular a póliza existente" para resolver el caso manualmente.

**¿Puedo cargar el mismo reporte dos veces?**
El sistema detecta reportes duplicados por aseguradora y período. Si intenta cargar un reporte ya procesado, mostrará una advertencia. En caso de error en un reporte ya procesado, contacte al administrador para revertir la carga.
