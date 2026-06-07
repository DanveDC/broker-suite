-- PostgreSQL schema for broker-suite
-- Generated from BD/Estructura base de datos 1.sql

-- Crear la tabla compania
CREATE TABLE compania (
    Cod_compania SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    rif VARCHAR(25)
);

-- Crear la tabla asegurado
CREATE TABLE asegurado (
    CI INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Tipo_CI VARCHAR(20),
    Correo VARCHAR(100),
    Fecha_nacimiento DATE,
    Telefono VARCHAR(20)
);

CREATE TABLE ejecutivo (
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

-- Crear la tabla poliza
CREATE TABLE poliza (
    cod_poliza VARCHAR(60),
    CI_asegurado INT,
    Fecha_emision DATE,
    Cod_compania INT,
    Tomador VARCHAR(30),
    Tipo VARCHAR(20),
    Ramo VARCHAR(50)
);

CREATE TABLE renovacion (
    Cod_poliza VARCHAR(60),
    Cod_renovacion SERIAL PRIMARY KEY,
    Prima INT,
    Frecuencia INT,
    Fecha_contrato DATE,
    cobertura VARCHAR(50),
    Fecha_vencimiento DATE,
    comision FLOAT
);

CREATE TABLE pago (
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

-- Crear la tabla Beneficiario
CREATE TABLE Beneficiario (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Cedula VARCHAR(20),
    Parentesco VARCHAR(50)
);

-- Crear la tabla Persona
CREATE TABLE Persona (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    Producto VARCHAR(50),
    Subramo VARCHAR(50)
);

-- Crear la tabla Auto
CREATE TABLE Auto (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    modelo VARCHAR(50),
    Producto VARCHAR(50),
    placa VARCHAR(50),
    año VARCHAR(50),
    marca VARCHAR(50),
    Subramo VARCHAR(50)
);

-- Crear la tabla Patrimonio
CREATE TABLE Patrimonio (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    direccion VARCHAR(50),
    Producto VARCHAR(50),
    Subramo VARCHAR(50)
);

-- Crear la tabla Fianza
CREATE TABLE Fianza (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    Producto VARCHAR(50),
    Subramo VARCHAR(50)
);

-- Crear la tabla Viaje
CREATE TABLE Viaje (
    Cod_poliza VARCHAR(60) PRIMARY KEY,
    cod_pasaporte VARCHAR(50),
    Producto VARCHAR(50),
    Subramo VARCHAR(50)
);

-- Crear la tabla Reembolso
CREATE TABLE Reembolso (
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

-- Crear la tabla Carta_aval
CREATE TABLE Carta_aval (
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

-- Crear la tabla AutomovilSiniestro
CREATE TABLE AutomovilSiniestro (
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

CREATE TABLE comision (
    Cod_pago INT,
    cod_ejecutivo INT,
    nro_recibo VARCHAR(50) UNIQUE,
    estado VARCHAR(50),
    bono FLOAT,
    tasa FLOAT,
    monto_bs FLOAT,
    cod_comision SERIAL PRIMARY KEY
);

CREATE TABLE nota_Auto (
    idnota_Auto SERIAL PRIMARY KEY,
    Cod_Auto VARCHAR(45) DEFAULT NULL,
    Observaciones VARCHAR(150) DEFAULT NULL,
    titulo VARCHAR(45) DEFAULT NULL
);

CREATE TABLE nota_cartaAval (
    idnota_cartaAval SERIAL PRIMARY KEY,
    Cod_CartaAval VARCHAR(45) DEFAULT NULL,
    Observaciones VARCHAR(150) DEFAULT NULL,
    titulo VARCHAR(45) DEFAULT NULL
);

CREATE TABLE nota_Reembolso (
    idnota_Reembolso SERIAL PRIMARY KEY,
    Cod_Reembolso VARCHAR(45) DEFAULT NULL,
    Observaciones VARCHAR(150) DEFAULT NULL,
    titulo VARCHAR(45) DEFAULT NULL
);

-- From BD/create_comisiones_config_table.sql
CREATE TABLE comisiones_config (
    id SERIAL PRIMARY KEY,
    compania VARCHAR(255) NOT NULL,
    ramo VARCHAR(255) NOT NULL,
    subramo VARCHAR(255),
    producto VARCHAR(255) NOT NULL,
    tipo_ejecutivo VARCHAR(255) NOT NULL,
    porcentajes VARCHAR(255) NOT NULL
);
