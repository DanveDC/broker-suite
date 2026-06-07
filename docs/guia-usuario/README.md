# Guía de Usuario — BrokerCore

Esta sección contiene las guías operativas para cada módulo de BrokerCore. Están dirigidas a los usuarios finales del sistema: ejecutivos, operadores administrativos y gerentes de la corredora.

---

## Sistema de roles y permisos

BrokerCore define cuatro roles de usuario. El rol se asigna al crear el usuario y determina qué módulos y acciones están disponibles.

| Rol | Descripción | Acceso |
|---|---|---|
| **Administración** | Administrador del sistema | Acceso completo: gestión de usuarios, comisiones, carga masiva, reportes y todas las operaciones. |
| **Gerencia** | Directivos y gerentes | Acceso a comisiones, reportes y consulta de toda la información operativa. |
| **Operaciones** | Personal operativo | CRUD completo sobre pólizas, siniestros y asegurados (crear, editar, eliminar). Sin acceso a gestión de usuarios ni comisiones. |
| **Ventas** | Ejecutivos de ventas | Solo lectura. Pueden consultar asegurados, pólizas y siniestros, pero no modificar nada. |

> **Nota:** El rol `dev` existe para uso interno del equipo de desarrollo y tiene los mismos permisos que `Administración`.

### ¿Qué ve cada rol?

La barra de navegación y los botones de acción se adaptan automáticamente según el rol del usuario autenticado. Por ejemplo:
- Un usuario con rol **Ventas** verá los listados pero no encontrará botones de "Nuevo" o "Editar".
- Un usuario con rol **Operaciones** no verá el módulo de Comisiones ni Usuarios en el menú.
- Solo **Administración** y **Gerencia** pueden acceder al módulo de Comisiones.

---

## Índice de módulos

| Módulo | Guía | Roles con acceso |
|---|---|---|
| Asegurados | [asegurados.md](./asegurados.md) | Todos |
| Pólizas | [polizas.md](./polizas.md) | Todos |
| Siniestros | [siniestros.md](./siniestros.md) | Todos |
| Comisiones | [comisiones.md](./comisiones.md) | Administración, Gerencia |
| Cobranza | [cobranza.md](./cobranza.md) | Administración, Gerencia, Operaciones |
| Usuarios y Roles | [usuarios-y-roles.md](./usuarios-y-roles.md) | Administración |

---

## Convenciones de esta guía

- Los campos marcados con `*` son obligatorios en los formularios.
- Las capturas de pantalla pueden variar ligeramente según la versión del sistema.
- Los ejemplos de datos (cédulas, nombres, montos) son ficticios y solo tienen fines ilustrativos.
