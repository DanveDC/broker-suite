# Gestión de Usuarios y Roles

> **Acceso requerido:** Solo el rol Administración puede crear, modificar o eliminar usuarios.

## Modelo de usuarios en BrokerCore

BrokerCore utiliza un modelo de autenticación acoplado a MySQL: cuando se crea un usuario en la aplicación, el sistema también crea automáticamente un usuario real en el servidor MySQL con los permisos correspondientes a su rol. Esto significa que los controles de acceso operan en dos niveles:

1. **Nivel aplicación:** BrokerCore verifica el rol y oculta o restringe las secciones correspondientes.
2. **Nivel base de datos:** El usuario MySQL del empleado solo tiene los permisos de SQL (SELECT, INSERT, UPDATE, DELETE) que corresponden a su rol.

Esto implica que eliminar un usuario en BrokerCore también elimina su cuenta en MySQL.

---

## Roles disponibles

| Rol | Operaciones permitidas | Módulos disponibles |
|---|---|---|
| **Administración** | SELECT, INSERT, UPDATE, DELETE sobre toda la base de datos | Todos los módulos, incluyendo Usuarios, Comisiones, Carga Masiva y Reportes |
| **Gerencia** | SELECT, INSERT, UPDATE, DELETE | Todos excepto gestión de Usuarios. Acceso completo a Comisiones y Reportes. |
| **Operaciones** | SELECT, INSERT, UPDATE, DELETE | Asegurados, Pólizas, Siniestros, Cobranza, Ejecutivos, Compañías. Sin acceso a Comisiones ni Usuarios. |
| **Ventas** | Solo SELECT | Todos los módulos de consulta. No puede crear ni modificar ningún registro. |

---

## Crear un nuevo usuario

1. Acceda a **Usuarios** desde el menú lateral.
2. Haga clic en **Nuevo Usuario**.
3. Complete el formulario:

| Campo | Descripción |
|---|---|
| **Nombre y apellido** | Nombre completo del usuario tal como aparecerá en el sistema. |
| **Correo electrónico** | Será el nombre de usuario para iniciar sesión. Debe ser único y válido. |
| **Contraseña** | Contraseña inicial. Se recomienda que el usuario la cambie en su primer ingreso. |
| **Rol** | Seleccione entre Administración, Gerencia, Operaciones o Ventas. |

4. Haga clic en **Crear Usuario**.

Al confirmar, el sistema realiza automáticamente:
- Inserta el registro en la tabla `users` con el hash de la contraseña.
- Crea el usuario en MySQL con el correo como nombre de usuario.
- Otorga los privilegios MySQL correspondientes al rol seleccionado.

> **Importante:** El correo electrónico no puede cambiarse una vez creado el usuario, ya que es el nombre de usuario MySQL. Si es necesario cambiar el correo, se debe eliminar el usuario y crear uno nuevo.

---

## Cambiar la contraseña de un usuario

### Como administrador (cambiar la contraseña de otro usuario)

1. En el listado de usuarios, haga clic en **Editar** junto al usuario.
2. Ingrese la nueva contraseña en el campo correspondiente.
3. Guarde los cambios.

El sistema actualiza simultáneamente:
- El hash en la tabla `users` de la aplicación.
- La contraseña real del usuario MySQL con `ALTER USER`.

Ambas deben mantenerse sincronizadas para que el login funcione correctamente.

### Como usuario (cambiar su propia contraseña)

1. Haga clic en el nombre de usuario en la esquina superior derecha del panel.
2. Seleccione **Cambiar contraseña**.
3. Ingrese la contraseña actual y la nueva contraseña dos veces.
4. Confirme el cambio.

---

## Eliminar un usuario

1. En el listado de usuarios, haga clic en el botón **Eliminar** junto al usuario.
2. Confirme la acción en el diálogo de confirmación.

El sistema eliminará:
- El registro en la tabla `users`.
- El usuario MySQL correspondiente (con `DROP USER`).

> **Atención:** Esta acción es irreversible. Si el usuario tiene registros asociados en el sistema (pólizas como ejecutivo responsable, comisiones, etc.), esos registros se conservan pero el usuario ya no podrá iniciar sesión.

---

## Perfil de usuario

Cada usuario puede acceder a su perfil desde el menú desplegable en la esquina superior derecha. Desde el perfil puede:
- Ver su información actual (nombre, correo, rol).
- Cambiar su contraseña.

Los usuarios no pueden cambiar su propio rol ni el de otros usuarios. Solo los administradores pueden modificar roles.

---

## Recuperación de contraseña

Si un usuario olvida su contraseña:

1. En la pantalla de login, haga clic en **¿Olvidaste tu contraseña?**
2. Ingrese el correo electrónico registrado.
3. El sistema enviará un enlace de recuperación al correo (requiere configuración de SMTP en `.env`).
4. El usuario hace clic en el enlace y establece una nueva contraseña.

> **Nota:** El enlace de recuperación expira después de 24 horas. Si expira, el usuario debe solicitar un nuevo enlace o contactar al administrador para que le cambie la contraseña directamente.

---

## Bitácora de actividad

Todas las operaciones realizadas en BrokerCore quedan registradas en la tabla `bitacora` de la base de datos, mediante triggers de MySQL. Esto incluye inserciones, modificaciones y eliminaciones en las tablas principales. El registro contiene:
- Fecha y hora de la operación.
- Tabla afectada.
- Tipo de operación (INSERT, UPDATE, DELETE).
- Datos anteriores y posteriores (para UPDATE).
- Usuario de sesión que realizó la operación.

Este registro no tiene interfaz visual en la versión actual, pero puede consultarse directamente en la base de datos por el administrador.
