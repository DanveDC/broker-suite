# Módulo de Asegurados

## ¿Qué es un asegurado?

Un **asegurado** es la persona natural registrada en BrokerCore que tiene una o más pólizas de seguro gestionadas por la corredora. Es la entidad central del sistema: todas las pólizas, siniestros y operaciones se vinculan a un asegurado.

El identificador único de cada asegurado es su **cédula de identidad (CI)**. El sistema no permite registrar dos asegurados con la misma cédula.

---

## Acceder al módulo

En el menú lateral, haga clic en **Asegurados**. Se mostrará el listado de todos los asegurados registrados, con opciones de búsqueda y filtrado.

---

## Crear un nuevo asegurado

1. En el listado de asegurados, haga clic en el botón **Nuevo Asegurado**.
2. Complete el formulario con los siguientes campos:

| Campo | Descripción | Obligatorio |
|---|---|---|
| **CI** | Cédula de identidad, solo números, sin puntos ni guiones. Ej: `12345678` | Sí |
| **Nombre** | Primer nombre del asegurado | Sí |
| **Apellido** | Primer apellido del asegurado | Sí |
| **Profesión** | Ocupación o profesión declarada. Ej: `Médico`, `Abogado`, `Comerciante` | No |
| **Localidad** | Ciudad o zona donde reside el asegurado. Ej: `Caracas`, `Valencia`, `Maracaibo` | No |
| **Canal** | Canal de venta a través del cual llegó a la corredora. Ej: `Directo`, `Referido`, `Banco` | No |
| **Ejecutivo** | Ejecutivo de ventas responsable de este asegurado. Se selecciona de la lista de ejecutivos registrados | No |

3. Haga clic en **Guardar**.

> **Tip:** Los campos Profesión, Localidad y Canal son importantes para los reportes de segmentación. Complete esta información siempre que sea posible.

---

## Buscar un asegurado

El listado incluye un campo de búsqueda en tiempo real. Puede buscar por:
- Número de cédula
- Nombre
- Apellido

También puede filtrar por **ejecutivo** utilizando el selector de filtros ubicado sobre la tabla.

---

## Editar un asegurado

1. En el listado, haga clic en el botón de **Editar** (ícono de lápiz) en la fila del asegurado.
2. Modifique los campos necesarios.
3. Haga clic en **Guardar cambios**.

> **Nota:** La cédula de identidad no puede modificarse una vez creado el registro, ya que es la clave primaria que vincula al asegurado con sus pólizas y siniestros. Si fue ingresada incorrectamente, contacte al administrador del sistema.

---

## Ver el detalle de un asegurado

Haga clic en el nombre del asegurado o en el ícono de **Ver detalle**. La página de detalle muestra:

- Información personal completa del asegurado.
- **Listado de pólizas activas y vencidas** asociadas a esa cédula. Desde aquí puede acceder directamente a cada póliza.
- Datos de canal, localidad y ejecutivo asignado.

Esta vista es el punto de partida para gestionar las pólizas de un asegurado: desde ella puede crear una nueva póliza directamente vinculada a esa persona.

---

## Consideraciones importantes

- Si intenta registrar una cédula que ya existe en el sistema, el sistema mostrará un error indicando que el asegurado ya está registrado.
- Un asegurado no puede eliminarse mientras tenga pólizas activas asociadas. Primero deberá anular o transferir todas sus pólizas.
