-- use crud_python;

-- Crear la tabla Compañia
CREATE TABLE compania (
    Cod_compania INT auto_increment PRIMARY KEY,
    Nombre VARCHAR(100),
    rif varchar(25)
);
-- Crear la tabla Asegurado
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
    CI INT ,
    cod_ejecutivo int AUTO_INCREMENT primary key,
    Nombre VARCHAR(50),
    nombre2 varchar(50),
    Apellido VARCHAR(50), 
    Apellido2 varchar(50),
    Correo VARCHAR(100),
    Telefono VARCHAR(20),
    Tipo Varchar(20)
);
-- Crear la tabla Poliza
CREATE TABLE poliza (
    cod_poliza varchar(60),
    CI_asegurado INT,
    Fecha_emision DATE,
    Cod_compania INT,
    Tomador varchar(30),
    Tipo VARCHAR(20),
    Ramo VARCHAR(50)
    -- FOREIGN KEY (CI_asegurado) REFERENCES Asegurado(CI)
    -- FOREIGN KEY (Cod_compania) REFERENCES Compania(Cod_compania),
    -- primary key (cod_poliza, CI_asegurado, Fecha_emision,Cod_compañia)
);


CREATE TABLE renovacion (
    Cod_poliza varchar(60) ,
    Cod_renovacion int AUTO_INCREMENT primary key,
    Prima int,
    Frecuencia int,
    Fecha_contrato date,
    cobertura VARCHAR(50),
    Fecha_vencimiento date,
    comision float
    -- primary key (Cod_poliza,Cod_renovacion),
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);


CREATE TABLE pago (
    Cod_renovacion int,
    Cod_pago INT auto_increment PRIMARY KEY,
    moneda VARCHAR(100),
    fecha date,
    Metodo_pago VARCHAR(50),
    tasa float,
    monto float,
	pago_enviado tinyint DEFAULT NULL,
    comision_recibida tinyint DEFAULT NULL,
    bonificacion float DEFAULT NULL
    -- primary key (Cod_recibo,Cod_renovacion),
    -- FOREIGN KEY (Cod_renovacion) references Renovacion(Cod_renovacion)
);

-- Crear la tabla Beneficiario
CREATE TABLE Beneficiario (
    Cod_poliza varchar(60) PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Cedula VARCHAR(20),
    Parentesco VARCHAR(50)
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Persona
CREATE TABLE Persona (
    Cod_poliza varchar(60) PRIMARY KEY,
    Producto VARCHAR(50),
    Subramo VARCHAR (50)
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Auto
CREATE TABLE Auto (
    Cod_poliza varchar(60) PRIMARY KEY,
    modelo VARCHAR(50),
    Producto VARCHAR(50),
    placa VARCHAR(50),
    año VARCHAR(50),
    marca VARCHAR(50),
    Subramo VARCHAR (50)
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);



-- Crear la tabla Patrimonio
CREATE TABLE Patrimonio (
    Cod_poliza varchar(60) PRIMARY KEY,
    direccion VARCHAR(50),
    Producto VARCHAR(50),
    Subramo VARCHAR (50)
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Fianza
CREATE TABLE Fianza (
    Cod_poliza varchar(60) PRIMARY KEY,
    Producto VARCHAR(50),
    Subramo VARCHAR (50)
   -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Viaje
CREATE TABLE Viaje (
    Cod_poliza varchar(60) PRIMARY KEY,
    cod_pasaporte VARCHAR(50),
    Producto VARCHAR(50),
    Subramo VARCHAR (50)
   -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Reembolso
CREATE TABLE Reembolso (
    Cod_poliza varchar(60),
    cod_reembolso INT auto_increment PRIMARY KEY,
    Diagnostico VARCHAR(255),
    Estado VARCHAR(50),
    Fecha_ocurrencia DATE,
    Fecha_noti DATE,
    Fecha_max DATE,
    Moneda VARCHAR(20) check (Moneda in ("Dolares","Bolivares")),
    Monto_solicitado DECIMAL(10,2),
    Monto_pagado DECIMAL(10,2),
    Fecha_pago DATE,
    Correo VARCHAR(100),
    codigo_siniestro varchar(40),
    Observaciones TEXT
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla Carta_aval
CREATE TABLE Carta_aval (
    Cod_poliza varchar(60),
    Cod_CartaAval INT auto_increment PRIMARY KEY,
    Diagnostico VARCHAR(255),
    Procedimiento VARCHAR(255),
    Estado VARCHAR(50),
    Moneda VARCHAR(20) check (Moneda in ("Dolares","Bolivares")),
    Monto_solicitado DECIMAL(10,2),
    Monto_aprobado DECIMAL(10,2),
    Fecha_noti DATE,
    Fecha_apro DATE,
    Correo VARCHAR(100),
    codigo_siniestro varchar(40),
    Observaciones TEXT
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

-- Crear la tabla AutomovilSiniestro
CREATE TABLE AutomovilSiniestro (
    Cod_poliza varchar(60),
	Cod_siniestroA INT auto_increment PRIMARY KEY,
    Fecha_ocurrencia DATE,
    Fecha_noti DATE,
    Fecha_inspec DATE,
    Estado VARCHAR(50),
    Monto_orden DECIMAL(10,2),
    Correo VARCHAR(100),
    Descripcion TEXT,
    codigo_siniestro varchar(40)
    -- FOREIGN KEY (Cod_poliza) references Poliza(cod_poliza)
);

CREATE TABLE comision (
    Cod_pago INT,
    cod_ejecutivo INT,
    nro_recibo VARCHAR(50) UNIQUE,
    estado VARCHAR(50),
    bono FLOAT,
    tasa FLOAT,
    monto_bs FLOAT,
    cod_comision INT auto_increment PRIMARY KEY
);

CREATE TABLE nota_Auto (
  idnota_Auto int PRIMARY KEY AUTO_INCREMENT,
  Cod_Auto varchar(45) DEFAULT NULL,
  Observaciones varchar(150) DEFAULT NULL,
  titulo varchar(45) DEFAULT NULL
);

CREATE TABLE nota_cartaAval (
  idnota_cartaAval int PRIMARY KEY AUTO_INCREMENT,
  Cod_CartaAval varchar(45) DEFAULT NULL,
  Observaciones varchar(150) DEFAULT NULL,
  titulo varchar(45) DEFAULT NULL
);

CREATE TABLE nota_Reembolso (
  idnota_Reembolso int PRIMARY KEY AUTO_INCREMENT,
  Cod_Reembolso varchar(45) DEFAULT NULL,
  Observaciones varchar(150) DEFAULT NULL,
  titulo varchar(45) DEFAULT NULL
)



