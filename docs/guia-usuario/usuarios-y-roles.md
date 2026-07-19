# Gestión de Usuarios y Roles

> **Acceso requerido:** Solo el rol Administración puede crear, modificar o eliminar usuarios.

## Modelo de usuarios en BrokerCore

BrokerCore gestiona los usuarios enteramente a nivel de aplicación: un usuario es un registro en la tabla `users` con nombre, correo, contraseña (hasheada) y un rol (`permisos`). No existe ninguna cuenta MySQL asociada — todas las conexiones a la base de datos usan la misma credencial configurada por variables de entorno, sin importar quién esté logueado.

El control de acceso es responsabilidad exclusiva de la aplicación: en cada ruta y en cada plantilla, BrokerCore compara `session['permisos']` contra el rol requerido para decidir si muestra u oculta una sección, o si permite ejecutar una acción.

---

## Roles disponibles

| Rol | Operaciones permitidas | Módulos disponibles |
|---|---|---|
| **Administración** | Crear, editar y eliminar en todos los módulos | Todos los módulos, incluyendo Usuarios, Comisiones y Reportes |
| **Gerencia** | Crear, editar y eliminar | Todos excepto gestión de Usuarios. Acceso completo a Comisiones y Reportes. |
| **Operaciones** | Crear, editar y eliminar | Asegurados, Pólizas, Siniestros, Cobranza, Ejecutivos, Compañías. Sin acceso a Comisiones ni Usuarios. |
| **Ventas** | Solo consulta | Todos los módulos de consulta. No puede crear ni modificar ningún registro. |

> Estas restricciones son controles de la capa de aplicación (verificación de `session['permisos']` en cada ruta), no privilegios de base de datos. Ver [tecnico/base-de-datos.md](../tecnico/base-de-datos.md).

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

Al confirmar, el sistema inserta el registro en la tabla `users` con el hash de la contraseña (werkzeug, método scrypt) y el rol seleccionado. No se crea ni se modifica ninguna cuenta de base de datos: es una operación puramente de aplicación.

> **Nota:** El correo electrónico es el nombre de usuario para iniciar sesión. Cambiarlo no tiene restricciones a nivel de base de datos, pero verifique que sea único.

---

## Cambiar la contraseña de un usuario

### Como administrador (cambiar la contraseña de otro usuario)

1. En el listado de usuarios, haga clic en **Editar** junto al usuario.
2. Ingrese la nueva contraseña en el campo correspondiente.
3. Guarde los cambios.

El sistema actualiza el hash de la contraseña en la tabla `users` de la aplicación. No hay ninguna cuenta de base de datos que sincronizar.

### Como usuario (cambiar su propia contraseña)

1. Haga clic en el nombre de usuario en la esquina superior derecha del panel.
2. Seleccione **Cambiar contraseña**.
3. Ingrese la contraseña actual y la nueva contraseña dos veces.
4. Confirme el cambio.

---

## Eliminar un usuario

1. En el listado de usuarios, haga clic en el botón **Eliminar** junto al usuario.
2. Confirme la acción en el diálogo de confirmación.

El sistema elimina el registro correspondiente en la tabla `users`. Es una baja definitiva (no un campo de estado/inactivo): no hay forma de recuperar el usuario desde la interfaz una vez eliminado.

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
