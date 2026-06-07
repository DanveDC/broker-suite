# Módulo de Pólizas

## ¿Qué es una póliza?

Una **póliza** es el contrato de seguro que vincula a un asegurado con una compañía aseguradora, gestionado a través de la corredora. En BrokerCore, la póliza es la entidad central de la operación: alrededor de ella se registran pagos, renovaciones y siniestros.

### Ciclo de vida de una póliza

```
Creación → Activa → Renovación → Pago de prima → Vigente
                                                    ↓
                                              Siniestro (si aplica)
                                                    ↓
                               Renovación al vencimiento → o → Anulación
```

---

## Tipos de póliza

BrokerCore maneja cinco tipos de póliza, cada uno con campos específicos:

| Tipo | Ramo | Descripción |
|---|---|---|
| **Persona / HCM** | Hospitalización, Cirugía y Maternidad | Seguro de salud individual o colectivo. Cubre gastos médicos, hospitalización y maternidad. |
| **Auto** | Automóvil | Seguro de vehículo. Incluye datos del vehículo (marca, modelo, año, placa). |
| **Patrimonial** | Patrimonio / Incendio | Seguro de bienes: inmuebles, contenido, equipos. |
| **Viaje** | Viaje | Seguro de asistencia en viaje internacional. Generalmente de corta duración. |
| **Fianza** | Fianza | Garantía de cumplimiento de obligaciones contractuales. |

---

## Crear una póliza

1. Acceda al módulo **Pólizas** desde el menú lateral.
2. Haga clic en **Nueva Póliza**.
3. Seleccione el tipo de póliza (Persona, Auto, Patrimonial, Viaje o Fianza).
4. Complete el formulario:

### Campos comunes a todos los tipos

| Campo | Descripción | Obligatorio |
|---|---|---|
| **Código de póliza** (`cod_poliza`) | Número o código asignado por la aseguradora. Puede contener letras, números y guiones. Ej: `HCM-2024-001234` | Sí |
| **Compañía** | Aseguradora que emite la póliza. Se selecciona del listado de compañías registradas. | Sí |
| **Asegurado** | Persona titular de la póliza. Búsqueda por cédula o nombre. | Sí |
| **Ramo** | Tipo de cobertura. Se selecciona según el tipo de póliza. | Sí |
| **Prima** | Monto de la prima a pagar por el asegurado. | Sí |
| **Frecuencia de pago** | Con qué periodicidad se paga la prima: Mensual, Trimestral, Semestral, Anual. | Sí |
| **Moneda** | Divisa de la prima: `Bs` (bolívares) o `USD` (dólares). | Sí |
| **Fecha de inicio** | Fecha de vigencia inicial de la póliza. | Sí |
| **Fecha de vencimiento** | Fecha en que la póliza debe renovarse o vence. | Sí |
| **Ejecutivo** | Ejecutivo responsable de esta póliza. | No |

### Campos adicionales para pólizas de Auto

| Campo | Descripción |
|---|---|
| **Marca** | Marca del vehículo. Ej: `Toyota`, `Chevrolet` |
| **Modelo** | Modelo del vehículo. Ej: `Corolla`, `Aveo` |
| **Año** | Año del vehículo |
| **Placa** | Placa del vehículo |
| **Número de serial** | Serial de carrocería (VIN) |
| **Color** | Color del vehículo |

5. Haga clic en **Guardar**.

> **Importante sobre códigos de póliza:** El código de póliza es el identificador que utilizan las aseguradoras en sus reportes de comisiones. Asegúrese de ingresarlo exactamente como aparece en los documentos de la aseguradora para que el módulo de comisiones pueda hacer el emparejamiento automático.

---

## Renovaciones

Cada vez que una póliza se renueva al vencimiento, se crea un registro de **renovación** (`renovacion`) vinculado a la póliza original. Esto permite mantener el historial completo de la relación con el asegurado.

### Renovar una póliza

1. Acceda al detalle de la póliza.
2. Haga clic en **Renovar**.
3. Ingrese la nueva fecha de vencimiento y la prima actualizada.
4. Confirme la renovación.

El sistema creará un nuevo registro de renovación con estado `Pendiente de pago`, mientras mantiene el registro de la póliza activa.

### Estados de una renovación

| Estado | Significado |
|---|---|
| **Pendiente de pago** | La renovación fue registrada pero el asegurado aún no ha pagado la prima. |
| **Pagada** | La prima de esta renovación ha sido cobrada. |
| **Anulada** | La renovación fue cancelada. |

---

## Registrar un pago de prima

1. Desde el detalle de la póliza o la renovación, haga clic en **Registrar Pago**.
2. Complete el formulario de pago:

| Campo | Descripción |
|---|---|
| **Monto pagado** | Monto recibido del asegurado |
| **Moneda** | `Bs` o `USD` |
| **Tasa de cambio** | Tasa BCV del día. El sistema puede obtenerla automáticamente haciendo clic en el botón de actualización (requiere conexión a internet). |
| **Método de pago** | Efectivo, Transferencia, Punto de venta, Zelle, etc. |
| **Número de cuota** | Número de la cuota si la prima se paga en partes |
| **Referencia** | Número de referencia de la transferencia o transacción (opcional) |
| **Fecha de pago** | Fecha en que se recibió el pago |

3. Haga clic en **Guardar Pago**.

> **Tasa BCV automática:** El botón de actualización de tasa consulta el servicio pyDolarVenezuela en tiempo real. Si no hay conexión a internet o el servicio no está disponible, ingrese la tasa manualmente.

---

## Transferir una póliza

La transferencia (traspaso) permite cambiar el ejecutivo responsable de una póliza, manteniendo el historial completo.

1. Desde el detalle de la póliza, haga clic en **Traspasar**.
2. Seleccione el nuevo ejecutivo.
3. Confirme el traspaso.

---

## Anular una póliza

La anulación marca la póliza como cancelada. Esta acción no elimina el registro; lo marca como `Anulada` para mantener el historial.

1. Desde el detalle de la póliza, haga clic en **Anular**.
2. Seleccione el motivo de anulación.
3. Confirme la anulación.

> **Nota:** Una póliza anulada no genera registros de comisión y no aparece en los reportes de cartera activa.

---

## Buscar y filtrar pólizas

El listado de pólizas permite filtrar por:
- Tipo de póliza (Persona, Auto, Patrimonial, etc.)
- Compañía aseguradora
- Estado (Activa, Vencida, Anulada)
- Ejecutivo responsable
- Rango de fechas de vencimiento

Use estos filtros para identificar pólizas próximas a vencer y gestionar las renovaciones preventivamente.
