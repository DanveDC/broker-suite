import os
from dotenv import load_dotenv
from flask import Flask, jsonify

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')


@app.route('/fix-schema')
def fix_schema():
    from conexion.conexionBD import connectionBD

    MIGRATIONS = [
        # asegurado — missing columns
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS Nombre2 VARCHAR(50)",
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS Apellido2 VARCHAR(50)",
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS Ejecutivo INT",
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS profesion VARCHAR(100)",
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS localidad VARCHAR(100)",
        "ALTER TABLE asegurado ADD COLUMN IF NOT EXISTS canal VARCHAR(50)",
        # poliza — missing columns
        "ALTER TABLE poliza ADD COLUMN IF NOT EXISTS Tipo_venta VARCHAR(50)",
        # renovacion — missing columns
        "ALTER TABLE renovacion ADD COLUMN IF NOT EXISTS riesgo VARCHAR(100)",
        # pago — missing columns
        "ALTER TABLE pago ADD COLUMN IF NOT EXISTS fecha_pagada DATE",
        "ALTER TABLE pago ADD COLUMN IF NOT EXISTS estado VARCHAR(30)",
        "ALTER TABLE pago ADD COLUMN IF NOT EXISTS recibo VARCHAR(100)",
        "ALTER TABLE pago ADD COLUMN IF NOT EXISTS nro_cuota SMALLINT",
        # comision — missing columns
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS monto_d FLOAT",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS monto_pago FLOAT",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS moneda VARCHAR(20)",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS id_bloque INT",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS nro_recibo_externo VARCHAR(100)",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS descripcion TEXT",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS comision_porcentaje FLOAT",
        "ALTER TABLE comision ADD COLUMN IF NOT EXISTS cod_poliza VARCHAR(100)",
        # comisiones_config — missing columns
        "ALTER TABLE comisiones_config ADD COLUMN IF NOT EXISTS cod_ejecutivo INT",
        # Reembolso — missing columns
        "ALTER TABLE Reembolso ADD COLUMN IF NOT EXISTS monto_dolares DECIMAL(10,2)",
        "ALTER TABLE Reembolso ADD COLUMN IF NOT EXISTS Tipo_Atencion VARCHAR(100)",
        # Carta_aval — missing columns
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS Tipo_Atencion VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS Monto_aprobadoD DECIMAL(10,2)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS MES VARCHAR(20)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS NEGOCIO VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS TITULAR VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS RECLAMANTE VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS REFERIDOR VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS ANALISTA VARCHAR(100)",
        "ALTER TABLE Carta_aval ADD COLUMN IF NOT EXISTS OBSERVACION TEXT",
        # users — missing column
        "ALTER TABLE users ADD COLUMN IF NOT EXISTS created_user TIMESTAMP DEFAULT NOW()",
        # New tables
        """CREATE TABLE IF NOT EXISTS bloque_pago_comision (
            id_bloque SERIAL PRIMARY KEY,
            numero_egreso VARCHAR(100),
            referencia_bancaria VARCHAR(100),
            fecha_movimiento DATE,
            monto_total FLOAT,
            compania VARCHAR(100),
            codigo_banco VARCHAR(50),
            fecha_creacion TIMESTAMP DEFAULT NOW()
        )""",
        """CREATE TABLE IF NOT EXISTS polizas_pendientes (
            id SERIAL PRIMARY KEY,
            nro_poliza VARCHAR(100),
            nro_recibo VARCHAR(100),
            nombre_cliente VARCHAR(200),
            monto_prima FLOAT,
            monto_comision FLOAT,
            porcentaje_comision FLOAT,
            fecha_cobro DATE,
            compania VARCHAR(100),
            descripcion TEXT,
            moneda VARCHAR(20),
            tasa FLOAT,
            monto_pagado FLOAT,
            id_bloque INT,
            estado VARCHAR(50)
        )""",
        """CREATE TABLE IF NOT EXISTS comisiones_ejecutivos (
            id SERIAL PRIMARY KEY,
            cod_ejecutivo INT,
            compania VARCHAR(100),
            ramo VARCHAR(100),
            subramo VARCHAR(100),
            producto VARCHAR(100),
            comision_bono FLOAT
        )""",
        """CREATE TABLE IF NOT EXISTS tbl_empleados (
            id_empleado SERIAL PRIMARY KEY,
            nombre_empleado VARCHAR(100),
            apellido_empleado VARCHAR(100),
            sexo_empleado VARCHAR(20),
            telefono_empleado VARCHAR(30),
            email_empleado VARCHAR(100),
            profesion_empleado VARCHAR(100),
            foto_empleado VARCHAR(255),
            salario_empleado FLOAT
        )""",
    ]

    try:
        conn = connectionBD()
        conn.autocommit = True
        cursor = conn.cursor()
        results = []
        for sql in MIGRATIONS:
            try:
                cursor.execute(sql)
                results.append({'sql': sql[:60], 'status': 'ok'})
            except Exception as e:
                results.append({'sql': sql[:60], 'status': 'error', 'error': str(e)})
        cursor.close()
        conn.close()
        errors = [r for r in results if r['status'] == 'error']
        return jsonify({'status': 'ok', 'total': len(MIGRATIONS), 'errors': errors})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500
