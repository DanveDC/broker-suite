import os
from dotenv import load_dotenv
from flask import Flask, jsonify

load_dotenv()

app = Flask(__name__)
application = app
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')


@app.route('/init-db')
def init_db():
    import pg8000.dbapi
    from urllib.parse import urlparse

    SCHEMA = """
    CREATE TABLE IF NOT EXISTS compania (
        Cod_compania SERIAL PRIMARY KEY,
        Nombre VARCHAR(100),
        rif VARCHAR(25)
    );
    CREATE TABLE IF NOT EXISTS asegurado (
        CI INT PRIMARY KEY,
        Nombre VARCHAR(50),
        Apellido VARCHAR(50),
        Tipo_CI VARCHAR(20),
        Correo VARCHAR(100),
        Fecha_nacimiento DATE,
        Telefono VARCHAR(20)
    );
    CREATE TABLE IF NOT EXISTS ejecutivo (
        CI INT,
        cod_ejecutivo SERIAL PRIMARY KEY,
        Nombre VARCHAR(50),
        nombre2 VARCHAR(50),
        Apellido VARCHAR(50),
        Apellido2 VARCHAR(50),
        Correo VARCHAR(100),
        Telefono VARCHAR(20),
        Tipo VARCHAR(20)
    );
    CREATE TABLE IF NOT EXISTS poliza (
        cod_poliza VARCHAR(60),
        CI_asegurado INT,
        Fecha_emision DATE,
        Cod_compania INT,
        Tomador VARCHAR(30),
        Tipo VARCHAR(20),
        Ramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS renovacion (
        Cod_poliza VARCHAR(60),
        Cod_renovacion SERIAL PRIMARY KEY,
        Prima INT,
        Frecuencia INT,
        Fecha_contrato DATE,
        cobertura VARCHAR(50),
        Fecha_vencimiento DATE,
        comision FLOAT
    );
    CREATE TABLE IF NOT EXISTS pago (
        Cod_renovacion INT,
        Cod_pago SERIAL PRIMARY KEY,
        moneda VARCHAR(100),
        fecha DATE,
        Metodo_pago VARCHAR(50),
        tasa FLOAT,
        monto FLOAT,
        pago_enviado SMALLINT DEFAULT NULL,
        comision_recibida SMALLINT DEFAULT NULL,
        bonificacion FLOAT DEFAULT NULL
    );
    CREATE TABLE IF NOT EXISTS Beneficiario (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        Nombre VARCHAR(100),
        Apellido VARCHAR(100),
        Cedula VARCHAR(20),
        Parentesco VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Persona (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        Producto VARCHAR(50),
        Subramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Auto (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        modelo VARCHAR(50),
        Producto VARCHAR(50),
        placa VARCHAR(50),
        año VARCHAR(50),
        marca VARCHAR(50),
        Subramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Patrimonio (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        direccion VARCHAR(50),
        Producto VARCHAR(50),
        Subramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Fianza (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        Producto VARCHAR(50),
        Subramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Viaje (
        Cod_poliza VARCHAR(60) PRIMARY KEY,
        cod_pasaporte VARCHAR(50),
        Producto VARCHAR(50),
        Subramo VARCHAR(50)
    );
    CREATE TABLE IF NOT EXISTS Reembolso (
        Cod_poliza VARCHAR(60),
        cod_reembolso SERIAL PRIMARY KEY,
        Diagnostico VARCHAR(255),
        Estado VARCHAR(50),
        Fecha_ocurrencia DATE,
        Fecha_noti DATE,
        Fecha_max DATE,
        Moneda VARCHAR(20) CHECK (Moneda IN ('Dolares', 'Bolivares')),
        Monto_solicitado DECIMAL(10,2),
        Monto_pagado DECIMAL(10,2),
        Fecha_pago DATE,
        Correo VARCHAR(100),
        codigo_siniestro VARCHAR(40),
        Observaciones TEXT
    );
    CREATE TABLE IF NOT EXISTS Carta_aval (
        Cod_poliza VARCHAR(60),
        Cod_CartaAval SERIAL PRIMARY KEY,
        Diagnostico VARCHAR(255),
        Procedimiento VARCHAR(255),
        Estado VARCHAR(50),
        Moneda VARCHAR(20) CHECK (Moneda IN ('Dolares', 'Bolivares')),
        Monto_solicitado DECIMAL(10,2),
        Monto_aprobado DECIMAL(10,2),
        Fecha_noti DATE,
        Fecha_apro DATE,
        Correo VARCHAR(100),
        codigo_siniestro VARCHAR(40),
        Observaciones TEXT
    );
    CREATE TABLE IF NOT EXISTS AutomovilSiniestro (
        Cod_poliza VARCHAR(60),
        Cod_siniestroA SERIAL PRIMARY KEY,
        Fecha_ocurrencia DATE,
        Fecha_noti DATE,
        Fecha_inspec DATE,
        Estado VARCHAR(50),
        Monto_orden DECIMAL(10,2),
        Correo VARCHAR(100),
        Descripcion TEXT,
        codigo_siniestro VARCHAR(40)
    );
    CREATE TABLE IF NOT EXISTS comision (
        Cod_pago INT,
        cod_ejecutivo INT,
        nro_recibo VARCHAR(50) UNIQUE,
        estado VARCHAR(50),
        bono FLOAT,
        tasa FLOAT,
        monto_bs FLOAT,
        cod_comision SERIAL PRIMARY KEY
    );
    CREATE TABLE IF NOT EXISTS nota_Auto (
        idnota_Auto SERIAL PRIMARY KEY,
        Cod_Auto VARCHAR(45) DEFAULT NULL,
        Observaciones VARCHAR(150) DEFAULT NULL,
        titulo VARCHAR(45) DEFAULT NULL
    );
    CREATE TABLE IF NOT EXISTS nota_cartaAval (
        idnota_cartaAval SERIAL PRIMARY KEY,
        Cod_CartaAval VARCHAR(45) DEFAULT NULL,
        Observaciones VARCHAR(150) DEFAULT NULL,
        titulo VARCHAR(45) DEFAULT NULL
    );
    CREATE TABLE IF NOT EXISTS nota_Reembolso (
        idnota_Reembolso SERIAL PRIMARY KEY,
        Cod_Reembolso VARCHAR(45) DEFAULT NULL,
        Observaciones VARCHAR(150) DEFAULT NULL,
        titulo VARCHAR(45) DEFAULT NULL
    );
    CREATE TABLE IF NOT EXISTS comisiones_config (
        id SERIAL PRIMARY KEY,
        compania VARCHAR(255) NOT NULL,
        ramo VARCHAR(255) NOT NULL,
        subramo VARCHAR(255),
        producto VARCHAR(255) NOT NULL,
        tipo_ejecutivo VARCHAR(255) NOT NULL,
        porcentajes VARCHAR(255) NOT NULL
    );
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name_surname VARCHAR(100) NOT NULL,
        email_user VARCHAR(100) UNIQUE NOT NULL,
        pass_user VARCHAR(255) NOT NULL,
        permisos VARCHAR(50) DEFAULT 'user'
    );
    CREATE TABLE IF NOT EXISTS password_resets (
        id SERIAL PRIMARY KEY,
        email_user VARCHAR(100) NOT NULL,
        token VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT NOW()
    );
    """

    try:
        import pg8000.dbapi, ssl
        from urllib.parse import urlparse

        database_url = os.environ.get('DATABASE_URL', '')
        if database_url.startswith('postgres://'):
            database_url = database_url.replace('postgres://', 'postgresql://', 1)
        parsed = urlparse(database_url)
        ssl_ctx = ssl.create_default_context()
        ssl_ctx.check_hostname = False
        ssl_ctx.verify_mode = ssl.CERT_NONE

        conn = pg8000.dbapi.connect(
            host=parsed.hostname,
            user=parsed.username,
            password=parsed.password,
            database=parsed.path.lstrip('/'),
            port=parsed.port or 5432,
            ssl_context=ssl_ctx
        )
        conn.autocommit = True
        cursor = conn.cursor()

        statements = [s.strip() for s in SCHEMA.split(';') if s.strip()]
        created = []
        for stmt in statements:
            cursor.execute(stmt)
            if 'CREATE TABLE' in stmt:
                table = stmt.split('EXISTS')[-1].split('(')[0].strip()
                created.append(table)

        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'tables_created': created})

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500
