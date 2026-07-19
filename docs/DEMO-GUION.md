# Guión de Demo — BrokerCore

Script corto para la presentación en vivo. Sigue el camino feliz de punta a punta: alta de un asegurado, su póliza, un pago, una comisión recibida, y cierre con dashboard y reporte regulatorio.

---

## 0. Login

- Ir a `/login`.
- Ingresar correo y contraseña del usuario administrador.
- Confirmar que redirige al panel principal.

---

## 1. Registrar un asegurado

- Sidebar → **Asegurados → Registrar asegurado** (`GET /registrar-asegurado`).
- Completar el formulario (cédula, nombre, apellido, profesión, localidad, canal, ejecutivo).
- Enviar (`POST /form-registrar-asegurado`).
- Mostrar que aparece en el listado (`/lista-de-asegurado`).

---

## 2. Registrar una póliza para ese asegurado

- Sidebar → **Pólizas → Registrar póliza** (`GET /registrar-poliza`).
- Buscar el asegurado recién creado.
- Elegir tipo de póliza (Persona/HCM, Auto, Patrimonial, Viaje o Fianza — usar la que más impacte en la demo, por ejemplo Auto).
- Completar los datos específicos del tipo elegido y enviar (`POST /form-registrar-poliza`).
- Mostrar el detalle de la póliza creada.

---

## 3. Registrar un pago / cobranza

- Sidebar → **Cobranza → Lista de Pagos** (`GET /cobranza`).
- Ubicar la póliza recién creada (o entrar desde el detalle de la póliza, botón de Pagos).
- Registrar un pago de cuota con monto, moneda y método de pago.
- Marcar el pago como **PAGADO** — esto es un requisito para poder asignarle una comisión en el paso siguiente.

---

## 4. Registrar una comisión recibida (Carga Manual)

- Sidebar → **Registro de Comisión Recibida** (`GET /comisiones-beta`).
- Clic en la tarjeta **Carga Manual**.
- Buscar la póliza por número.
- Seleccionar la cuota/recibo que se marcó como PAGADO en el paso anterior.
- Completar monto de comisión (USD), tasa de cambio y descripción.
- **Agregar a Tabla** y luego **Confirmar Bloque** (`POST /procesar-comisiones-beta`).

---

## 5. Mostrar el dashboard

- Sidebar → **Reportes → Dashboard de Ventas** (`GET /dashboard-reportes`).
- Recorrer los indicadores (ApexCharts): ventas, pólizas, comisiones.
- Opcional, si hay tiempo: **Reportes → BI Master Control** (`GET /dashboard-bi-master`) para una vista más ejecutiva.

---

## 6. Mostrar el reporte Sudaseg

- Sidebar → **Reportes → Reporte Sudaseg** (`GET /reporte-sudaseg`).
- Mostrar el reporte regulatorio generado y, si aplica, la descarga en Excel (`GET /descargar-excel-sudaseg`).

---

## Notas para el presentador

- Todo el recorrido usa datos reales de la base de datos (TiDB Cloud) — no hay datos mockeados.
- Si algo fallara en vivo, el fallback es mostrar registros ya cargados previamente en lugar de crear nuevos desde cero.
- La demo no cubre siniestros ni empleados/ejecutivos/compañías (CRUDs) — mencionarlos verbalmente como módulos existentes si surge la pregunta, no hace falta entrar a cada uno.
