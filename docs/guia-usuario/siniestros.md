# Módulo de Siniestros

## ¿Qué es un siniestro?

Un **siniestro** es el evento cubierto por la póliza que genera una reclamación ante la aseguradora. BrokerCore gestiona tres tipos de siniestro, cada uno con un flujo y campos distintos.

---

## Tipos de siniestro

### 1. Carta Aval

Una **Carta Aval** es una autorización que la aseguradora emite *antes* de que se realice un procedimiento médico, garantizando que cubrirá los costos. El asegurado o la clínica solicita la carta a través de la corredora para que la aseguradora la evalúe y apruebe.

**Cuándo usarla:**
- Cirugías programadas
- Hospitalizaciones planificadas
- Procedimientos médicos de alto costo que requieren pre-autorización

**Flujo típico:**
1. La clínica o el asegurado contacta a la corredora.
2. La corredora crea la Carta Aval en BrokerCore y la gestiona ante la aseguradora.
3. La aseguradora aprueba o rechaza. Se actualiza el estado en el sistema.
4. Si se aprueba, la clínica procede con el procedimiento y factura directamente a la aseguradora.

---

### 2. Reembolso

Un **Reembolso** es cuando el asegurado ya pagó un gasto médico de su propio bolsillo y solicita que la aseguradora le reintegre el monto cubierto por la póliza.

**Cuándo usarlo:**
- El asegurado fue a una clínica no afiliada a la aseguradora.
- Ocurrió una emergencia y no hubo tiempo de gestionar una Carta Aval.
- Medicamentos o tratamientos ambulatorios cubiertos por la póliza.

**Flujo típico:**
1. El asegurado entrega las facturas y documentos a la corredora.
2. La corredora crea el Reembolso en BrokerCore con el monto reclamado.
3. Se gestiona la solicitud ante la aseguradora y se hace seguimiento.
4. Se actualiza el estado cuando la aseguradora procesa el pago.

---

### 3. Siniestro Auto

Un **Siniestro Auto** registra un accidente o daño a un vehículo asegurado.

**Cuándo usarlo:**
- Accidente de tránsito (colisión)
- Daños por fenómenos naturales (inundación, granizo)
- Robo total o parcial del vehículo
- Daños a terceros causados por el vehículo asegurado

**Flujo típico:**
1. El asegurado reporta el accidente a la corredora.
2. La corredora crea el Siniestro Auto en BrokerCore con los datos del evento.
3. Se coordina el peritaje con la aseguradora.
4. Se registran las notas del proceso hasta la liquidación.

---

## Crear un siniestro

### Carta Aval o Reembolso

1. Acceda al módulo **Siniestros** desde el menú lateral.
2. Haga clic en **Nuevo Siniestro** y seleccione el tipo.
3. Complete el formulario:

| Campo | Descripción |
|---|---|
| **Asegurado** | Busque por cédula o nombre. La póliza se cargará automáticamente. |
| **Póliza** | Seleccione la póliza HCM correspondiente. |
| **Fecha del evento** | Fecha en que ocurrió el evento médico o accidente. |
| **Descripción** | Diagnóstico o descripción del procedimiento/evento. |
| **Monto reclamado** | Para reembolsos, el monto total de las facturas presentadas. |
| **Clínica / Centro médico** | Nombre del centro donde se atendió al asegurado. |
| **Médico tratante** | Nombre del médico (opcional pero recomendado). |

4. Haga clic en **Guardar**.

### Siniestro Auto

1. Seleccione **Siniestro Auto** como tipo.
2. Complete el formulario con los datos del vehículo y el evento:

| Campo | Descripción |
|---|---|
| **Asegurado** | Titular de la póliza de auto. |
| **Póliza** | Póliza de Auto correspondiente. |
| **Fecha del accidente** | Fecha en que ocurrió el siniestro. |
| **Descripción del evento** | Narración de lo ocurrido. |
| **Lugar del accidente** | Dirección o referencia donde ocurrió. |
| **Daños reportados** | Descripción de los daños al vehículo. |

---

## Seguimiento y notas

Cada siniestro tiene una sección de **notas** donde se puede registrar el historial de gestión:
- Respuestas de la aseguradora
- Documentos solicitados y entregados
- Fechas de seguimiento
- Resolución final

### Agregar una nota

1. Abra el detalle del siniestro.
2. En la sección **Notas**, haga clic en **Agregar nota**.
3. Escriba el contenido de la nota y guarde.

Las notas quedan registradas con fecha y hora, y con el nombre del usuario que las creó.

---

## Estados de un siniestro

| Estado | Descripción |
|---|---|
| **Abierto** | El siniestro fue registrado y está en proceso de gestión. |
| **En revisión** | La aseguradora está evaluando la solicitud. |
| **Aprobado** | La aseguradora aprobó la cobertura o el reembolso. |
| **Rechazado** | La aseguradora negó la cobertura. |
| **Cerrado** | El siniestro fue resuelto (pagado, rechazado o desistido). |

---

## Editar un siniestro

1. En el listado de siniestros, haga clic en el ícono de edición.
2. Modifique los campos necesarios (estado, montos, información adicional).
3. Guarde los cambios.

> **Nota:** Una vez que un siniestro está en estado **Cerrado**, se recomienda no modificarlo para preservar la integridad del historial. Si es necesario reabrirlo, contacte al administrador.

---

## Buscar y filtrar siniestros

El listado de siniestros permite filtrar por:
- Tipo de siniestro (Carta Aval, Reembolso, Auto)
- Estado
- Rango de fechas
- Asegurado (búsqueda por nombre o cédula)
- Compañía aseguradora
