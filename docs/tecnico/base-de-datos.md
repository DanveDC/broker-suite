# Base de Datos — BrokerCore

## Visión general del diseño

BrokerCore utiliza **MySQL 8.0** con SQL directo (sin ORM). El esquema sigue un modelo relacional tradicional con algunas particularidades:

- Las **relaciones entre tablas existen semánticamente** (se leen juntas con JOINs) pero no se han declarado con FOREIGN KEY constraints en todos los casos. Las integridades referenciales son responsabilidad de la capa de aplicación.
- El **sistema de auditoría** se implementa mediante triggers de MySQL que escriben en la tabla `bitacora`.
- Los **usuarios de la aplicación** son también usuarios reales de MySQL, lo cual es parte central del modelo de autenticación.

---

## Referencia de tablas

### Entidades principales

| Tabla | Propósito | Clave primaria | Columnas clave |
|---|---|---|---|
| `asegurado` | Personas aseguradas | `ci` (cédula de identidad) | `nombre`, `apellido`, `profesion`, `localidad`, `canal`, `id_ejecutivo` |
| `poliza` | Contratos de seguro | `id_poliza` | `cod_poliza`, `id_asegurado` (CI), `id_compania`, `ramo`, `prima`, `moneda`, `fecha_inicio`, `fecha_vencimiento`, `id_ejecutivo`, `estado` |
| `renovacion` | Historial de renovaciones de pólizas | `id_renovacion` | `id_poliza`, `fecha_inicio`, `fecha_vencimiento`, `prima`, `estado` |
| `pago` | Pagos de primas | `id_pago` | `id_poliza`, `id_renovacion`, `monto`, `moneda`, `tasa`, `metodo_pago`, `num_cuota`, `estado`, `fecha_pago` |
| `beneficiario` | Beneficiarios vinculados a pólizas | `id_beneficiario` | `id_poliza`, `ci`, `nombre`, `apellido`, `parentesco` |

### Tipos de póliza (tablas de extensión)

Cada tipo de póliza tiene una tabla complementaria con sus datos específicos, relacionada con `poliza` a través de `id_poliza`:

| Tabla | Tipo de póliza | Columnas clave |
|---|---|---|
| `persona` | Póliza HCM / Salud | `id_poliza`, datos de cobertura médica |
| `auto` | Póliza de Auto | `id_poliza`, `marca`, `modelo`, `año`, `placa`, `serial`, `color` |
| `patrimonio` | Póliza Patrimonial | `id_poliza`, descripción del bien asegurado |
| `fianza` | Póliza de Fianza | `id_poliza`, datos del contrato garantizado |
| `viaje` | Póliza de Viaje | `id_poliza`, `destino`, `fecha_viaje` |

### Siniestros

| Tabla | Propósito | Columnas clave |
|---|---|---|
| `carta_aval` | Siniestros de tipo Carta Aval (pre-autorización médica) | `id_carta_aval`, `id_poliza`, `fecha_evento`, `descripcion`, `estado`, `clinica` |
| `reembolso` | Siniestros de tipo Reembolso médico | `id_reembolso`, `id_poliza`, `monto_reclamado`, `monto_aprobado`, `estado` |
| `automovilsiniestro` | Siniestros de Auto | `id_siniestro`, `id_poliza`, `fecha_accidente`, `descripcion`, `lugar` |

### Notas de siniestros

Las notas de seguimiento de cada tipo de siniestro se almacenan en tablas separadas:

| Tabla | Siniestro relacionado |
|---|---|
| `nota_cartaaval` | Notas de Carta Aval |
| `nota_reembolso` | Notas de Reembolso |
| `nota_auto` | Notas de Siniestro Auto |

### Comisiones

| Tabla | Propósito | Columnas clave |
|---|---|---|
| `comision` | Registro de comisiones por póliza | `id_comision`, `id_poliza`, `id_compania`, `monto`, `porcentaje`, `periodo`, `estado` |
| `comisiones_config` | Porcentajes de comisión configurables por aseguradora y ramo | `id_config`, `id_compania`, `ramo`, `porcentaje` |
| `comisiones_ejecutivos` | Distribución de comisiones por ejecutivo | `id_cej`, `id_comision`, `id_ejecutivo`, `monto` |
| `polizas_pendientes` | Líneas de reporte sin emparejar automáticamente | `id_pendiente`, `cod_poliza_reporte`, `id_compania`, `periodo`, `monto` |
| `bloque_pago_comision` | Registro de bloques de comisiones ya distribuidas | `id_bloque`, `fecha_pago`, `id_ejecutivo` |

### Administración y usuarios

| Tabla | Propósito | Columnas clave |
|---|---|---|
| `users` | Usuarios de la aplicación | `id`, `name_surname`, `email_user`, `pass_user` (hash bcrypt), `permisos` (rol) |
| `password_resets` | Tokens para recuperación de contraseña | `id`, `email`, `token`, `created_at`, `expires_at` |
| `ejecutivo` | Ejecutivos de ventas | `id_ejecutivo`, `nombre`, `apellido`, `email` |
| `compania` | Compañías aseguradoras | `id_compania`, `nombre`, `rif`, `contacto` |

### Empleados

| Tabla | Propósito | Columnas clave |
|---|---|---|
| (tabla empleados) | Personal interno de la corredora | `id`, `nombre`, `apellido`, `cargo`, `foto` (nombre de archivo) |

### Auditoría

| Tabla | Propósito | Columnas clave |
|---|---|---|
| `bitacora` | Log de auditoría automático | `id`, `tabla`, `operacion` (INSERT/UPDATE/DELETE), `datos_anteriores`, `datos_nuevos`, `fecha`, `usuario` |

---

## Relaciones entre entidades

```
asegurado (ci)
    └── poliza (id_asegurado = ci)
            ├── renovacion (id_poliza)
            ├── pago (id_poliza)
            ├── beneficiario (id_poliza)
            ├── [persona | auto | patrimonio | fianza | viaje] (id_poliza)
            ├── carta_aval (id_poliza)
            │       └── nota_cartaaval
            ├── reembolso (id_poliza)
            │       └── nota_reembolso
            ├── automovilsiniestro (id_poliza)
            │       └── nota_auto
            └── comision (id_poliza)

compania (id_compania)
    ├── poliza (id_compania)
    ├── comision (id_compania)
    └── comisiones_config (id_compania)

ejecutivo (id_ejecutivo)
    ├── asegurado (id_ejecutivo)
    ├── poliza (id_ejecutivo)
    └── comisiones_ejecutivos (id_ejecutivo)
```

---

## Sistema de auditoría (bitacora)

MySQL triggers activos en las tablas principales (asegurado, poliza, pago, renovacion, y otras) capturan automáticamente cada INSERT, UPDATE y DELETE y escriben un registro en `bitacora`.

El registro incluye:
- Tabla afectada y tipo de operación.
- Representación JSON (o delimitada) de los datos anteriores y posteriores.
- Timestamp de la operación.
- El usuario MySQL activo en ese momento (que corresponde al email del usuario de la aplicación).

Esto proporciona trazabilidad completa de todas las modificaciones sin ninguna acción requerida del código de aplicación.

Para consultar la bitácora directamente:

```sql
SELECT * FROM bitacora
WHERE tabla = 'poliza'
  AND usuario = 'operador@empresa.com'
ORDER BY fecha DESC
LIMIT 50;
```

---

## Usuarios MySQL como mecanismo de acceso

Cada usuario de la aplicación tiene un usuario MySQL correspondiente cuyo nombre de usuario es su dirección de email. Los permisos se asignan al momento de crear el usuario:

```sql
-- Rol Operaciones: CRUD completo
GRANT SELECT, INSERT, UPDATE, DELETE ON brokercore.* TO 'email@empresa.com'@'localhost';

-- Rol Ventas: solo lectura
GRANT SELECT ON brokercore.* TO 'email@empresa.com'@'localhost';

-- Rol Administración: acceso completo
GRANT ALL PRIVILEGES ON brokercore.* TO 'email@empresa.com'@'localhost';
```

Este diseño delega parte del control de acceso al propio motor de base de datos.

---

## Decisiones de diseño y sus compensaciones

| Decisión | Motivo | Compensación |
|---|---|---|
| SQL directo sin ORM | Control total sobre las queries, sin overhead de abstracción | Mayor verbosidad, sin migraciones automáticas |
| FK sin constraints declarados | Flexibilidad para operaciones masivas y migraciones | Posibilidad de datos huérfanos si la aplicación falla |
| Usuarios MySQL = usuarios de la app | Aprovecha el sistema de permisos de MySQL nativamente | Alta complejidad en gestión de usuarios; la contraseña debe sincronizarse manualmente |
| Triggers para bitácora | Auditoria garantizada independientemente de la aplicación | Overhead por cada operación; no es visible desde la UI |
| CI como PK de asegurado | La cédula es el identificador natural en el contexto venezolano | No permite cédulas duplicadas; errores de carga son difíciles de corregir |

---

## Migraciones y scripts

La carpeta `BD/` contiene el esquema base. La carpeta `scripts/` contiene scripts Python de migración puntual para cambios que requieren transformación de datos o DDL incremental.

Para aplicar una migración SQL:

```bash
mysql -u root -p brokercore < BD/nombre_migracion.sql
```

Para ejecutar un script Python de migración:

```bash
source venv/bin/activate
python scripts/nombre_script.py
```

> **Buenas prácticas:** Siempre haga un respaldo (`mysqldump`) antes de aplicar una migración en producción.

```bash
mysqldump -u root -p brokercore > backup_antes_migracion_$(date +%Y%m%d).sql
```
