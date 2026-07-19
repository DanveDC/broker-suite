# Limitaciones Conocidas y Próximos Pasos — BrokerCore

Este documento resume, de forma directa, las decisiones de arquitectura que hoy generan deuda técnica, por qué no bloquean el uso actual del sistema, y cuál sería el paso natural siguiente para cada una. Es un mapa de estado y ruta, no una lista de disculpas.

---

## 1. `funciones_home.py` — controlador monolítico (~8900 líneas)

Toda la lógica de negocio de la aplicación (asegurados, pólizas, siniestros, comisiones, cobranza, reportes) vive en un único archivo Python.

- **Por qué no bloquea hoy:** el patrón dentro del archivo es uniforme (una función por operación) y el equipo que lo mantiene lo conoce bien. No hay un problema de correctitud, sino de escalabilidad de mantenimiento a futuro.
- **Próximo paso natural:** dividir por dominio (asegurados, pólizas, siniestros, comisiones, cobranza) en módulos separados, apoyándose en Blueprints de Flask para que el split de rutas acompañe al split de lógica.

---

## 2. Sin ORM (SQL directo)

Todas las queries se escriben a mano con PyMySQL, sin una capa de mapeo objeto-relacional.

- **Por qué no bloquea hoy:** da control total sobre las queries y evita el overhead de aprendizaje/abstracción de un ORM sobre un esquema ya estable de 27 tablas.
- **Próximo paso natural:** no es prioritario introducir un ORM completo hoy; si se decide, sería incremental, empezando por los módulos con lógica más repetitiva (CRUDs simples de ejecutivos/compañías/empleados).

---

## 3. Sin connection pooling

Cada request abre y cierra una conexión PyMySQL nueva contra MySQL/TiDB Cloud.

- **Por qué no bloquea hoy:** el volumen de tráfico actual (una corredora, uso interno del equipo) no genera la concurrencia necesaria para que esto sea un cuello de botella real.
- **Próximo paso natural:** si el tráfico concurrente crece, introducir un pool (por ejemplo `DBUtils.PooledDB` sobre PyMySQL) es un cambio acotado a `conexion/conexionBD.py`, sin tocar el resto de la aplicación.

---

## 4. Sin protección CSRF

Los formularios POST no incluyen tokens CSRF.

- **Por qué no bloquea hoy:** el sistema es de uso interno, con acceso restringido por login y sin exposición pública de formularios sensibles a terceros no autenticados.
- **Próximo paso natural:** agregar Flask-WTF (`CSRFProtect`) es de bajo esfuerzo y es la mejora de seguridad más costo-efectiva disponible; ver detalle en [tecnico/seguridad.md](./seguridad.md).

---

## 5. Sin tests automatizados

No hay carpeta `tests/` ni suite de pruebas automatizadas en el repositorio.

- **Por qué no bloquea hoy:** el control de calidad hasta ahora se apoya en QA manual sobre los flujos principales (golden paths), que ha sido suficiente para el ritmo de cambios del equipo.
- **Próximo paso natural:** priorizar tests de integración sobre el módulo de comisiones — es el más complejo (matching de pólizas, bloques de pago, retenciones) y el que más se beneficiaría de una red de seguridad antes de seguir iterando sobre él.

---

## 6. Sin Blueprints de Flask

Las ~173 rutas de `router_home.py` (más las de `router_login.py`) están registradas directamente sobre el objeto `app`, sin separación modular.

- **Por qué no bloquea hoy:** con un solo desarrollador/equipo pequeño trabajando sobre el código, la falta de modularidad no genera conflictos de organización todavía.
- **Próximo paso natural:** introducir Blueprints en paralelo al split de `funciones_home.py` (punto 1) — son cambios que conviene hacer juntos.

---

## Resumen

| Ítem | Bloquea hoy | Esfuerzo del próximo paso |
|---|---|---|
| Controlador monolítico | No | Alto |
| Sin ORM | No | Medio (opcional) |
| Sin connection pooling | No | Bajo |
| Sin CSRF | No | Bajo |
| Sin tests automatizados | No | Medio (empezando por comisiones) |
| Sin Blueprints | No | Alto (junto al split del controlador) |

Ver también [tecnico/arquitectura.md](./arquitectura.md) para el contexto completo de la arquitectura, y [tecnico/seguridad.md](./seguridad.md) para el detalle de hardening de seguridad.
