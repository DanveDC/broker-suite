-- Complete consolidated MySQL schema for Broker Suite
-- Run this on TiDB Serverless (or any MySQL 8+ server)

SET FOREIGN_KEY_CHECKS = 0;

-- ─── USERS & AUTH ─────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_surname` VARCHAR(100) NOT NULL,
  `email_user` VARCHAR(100) NOT NULL,
  `pass_user` TEXT NOT NULL,
  `permisos` VARCHAR(50) DEFAULT 'Operaciones',
  `foto` VARCHAR(255) DEFAULT NULL,
  `created_user` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_email_user` (`email_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Default admin user: email=dev@gmail.com  password=admin123 (change immediately)
INSERT IGNORE INTO `users` (`id`, `name_surname`, `email_user`, `pass_user`, `permisos`) VALUES
(1, 'Administrador', 'dev@gmail.com',
 'scrypt:32768:8:1$ZXqvqovbXYQZdrAB$66758083429739f4f8985992b22cb89fb58c04b99010858e7fb26f73078a23dd3e16019a17bf881108d582a91a635d2c21d26d80da1612c2d9c9bbb9b06452dc',
 'Administracion');

CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email_user` VARCHAR(100) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_token` (`token`),
  KEY `idx_email` (`email_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── CORE ENTITIES ────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `compania` (
  `Cod_compania` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) DEFAULT NULL,
  `rif` VARCHAR(25) DEFAULT NULL,
  PRIMARY KEY (`Cod_compania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `asegurado` (
  `CI` INT NOT NULL,
  `Nombre` VARCHAR(50) DEFAULT NULL,
  `Apellido` VARCHAR(50) DEFAULT NULL,
  `Tipo_CI` VARCHAR(20) DEFAULT NULL,
  `Correo` VARCHAR(100) DEFAULT NULL,
  `Fecha_nacimiento` DATE DEFAULT NULL,
  `Telefono` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`CI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ejecutivo` (
  `CI` INT DEFAULT NULL,
  `cod_ejecutivo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) DEFAULT NULL,
  `nombre2` VARCHAR(50) DEFAULT NULL,
  `Apellido` VARCHAR(50) DEFAULT NULL,
  `Apellido2` VARCHAR(50) DEFAULT NULL,
  `Correo` VARCHAR(100) DEFAULT NULL,
  `Telefono` VARCHAR(20) DEFAULT NULL,
  `Tipo` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`cod_ejecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── POLIZAS ──────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `poliza` (
  `cod_poliza` VARCHAR(60) NOT NULL,
  `CI_asegurado` INT DEFAULT NULL,
  `Fecha_emision` DATE DEFAULT NULL,
  `Cod_compania` INT DEFAULT NULL,
  `Tomador` VARCHAR(100) DEFAULT NULL,
  `Tipo` VARCHAR(20) DEFAULT NULL,
  `Ramo` VARCHAR(50) DEFAULT NULL,
  `cod_ejecutivo` INT DEFAULT NULL,
  PRIMARY KEY (`cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `renovacion` (
  `Cod_poliza` VARCHAR(60) DEFAULT NULL,
  `Cod_renovacion` INT NOT NULL AUTO_INCREMENT,
  `Prima` FLOAT DEFAULT NULL,
  `Frecuencia` INT DEFAULT NULL,
  `Fecha_contrato` DATE DEFAULT NULL,
  `cobertura` VARCHAR(50) DEFAULT NULL,
  `Fecha_vencimiento` DATE DEFAULT NULL,
  `comision` FLOAT DEFAULT NULL,
  `riesgo` VARCHAR(100) DEFAULT NULL,
  `estado` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_renovacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pago` (
  `Cod_renovacion` INT DEFAULT NULL,
  `Cod_pago` INT NOT NULL AUTO_INCREMENT,
  `Moneda` VARCHAR(100) DEFAULT NULL,
  `fecha` DATE DEFAULT NULL,
  `Metodo_pago` VARCHAR(50) DEFAULT NULL,
  `tasa` FLOAT DEFAULT NULL,
  `monto` FLOAT DEFAULT NULL,
  `fecha_pagada` DATE DEFAULT NULL,
  `estado` VARCHAR(50) DEFAULT NULL,
  `recibo` VARCHAR(100) DEFAULT NULL,
  `nro_cuota` INT DEFAULT NULL,
  `pago_enviado` TINYINT DEFAULT NULL,
  `comision_recibida` TINYINT DEFAULT NULL,
  `bonificacion` FLOAT DEFAULT NULL,
  PRIMARY KEY (`Cod_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Beneficiario` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `Nombre` VARCHAR(100) DEFAULT NULL,
  `Apellido` VARCHAR(100) DEFAULT NULL,
  `Cedula` VARCHAR(20) DEFAULT NULL,
  `Parentesco` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── RAMOS ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `Persona` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `Producto` VARCHAR(50) DEFAULT NULL,
  `Subramo` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Auto` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `modelo` VARCHAR(50) DEFAULT NULL,
  `Producto` VARCHAR(50) DEFAULT NULL,
  `placa` VARCHAR(50) DEFAULT NULL,
  `año` VARCHAR(50) DEFAULT NULL,
  `marca` VARCHAR(50) DEFAULT NULL,
  `Subramo` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Patrimonio` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `direccion` VARCHAR(100) DEFAULT NULL,
  `Producto` VARCHAR(50) DEFAULT NULL,
  `Subramo` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Fianza` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `Producto` VARCHAR(50) DEFAULT NULL,
  `Subramo` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Viaje` (
  `Cod_poliza` VARCHAR(60) NOT NULL,
  `cod_pasaporte` VARCHAR(50) DEFAULT NULL,
  `Producto` VARCHAR(50) DEFAULT NULL,
  `Subramo` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── SINIESTROS ───────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `Reembolso` (
  `Cod_poliza` VARCHAR(60) DEFAULT NULL,
  `cod_reembolso` INT NOT NULL AUTO_INCREMENT,
  `Diagnostico` VARCHAR(255) DEFAULT NULL,
  `Estado` VARCHAR(50) DEFAULT NULL,
  `Fecha_ocurrencia` DATE DEFAULT NULL,
  `Fecha_noti` DATE DEFAULT NULL,
  `Fecha_max` DATE DEFAULT NULL,
  `Moneda` VARCHAR(20) DEFAULT NULL,
  `Monto_solicitado` DECIMAL(10,2) DEFAULT NULL,
  `Monto_pagado` DECIMAL(10,2) DEFAULT NULL,
  `monto_dolares` DOUBLE DEFAULT NULL,
  `Fecha_pago` DATE DEFAULT NULL,
  `Correo` VARCHAR(100) DEFAULT NULL,
  `codigo_siniestro` VARCHAR(40) DEFAULT NULL,
  `Observaciones` TEXT DEFAULT NULL,
  PRIMARY KEY (`cod_reembolso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Carta_aval` (
  `Cod_poliza` VARCHAR(60) DEFAULT NULL,
  `Cod_CartaAval` INT NOT NULL AUTO_INCREMENT,
  `Diagnostico` VARCHAR(255) DEFAULT NULL,
  `Procedimiento` VARCHAR(255) DEFAULT NULL,
  `Estado` VARCHAR(50) DEFAULT NULL,
  `Moneda` VARCHAR(20) DEFAULT NULL,
  `Monto_solicitado` DECIMAL(10,2) DEFAULT NULL,
  `Monto_aprobado` DECIMAL(10,2) DEFAULT NULL,
  `Fecha_noti` DATE DEFAULT NULL,
  `Fecha_apro` DATE DEFAULT NULL,
  `Correo` VARCHAR(100) DEFAULT NULL,
  `codigo_siniestro` VARCHAR(40) DEFAULT NULL,
  `Observaciones` TEXT DEFAULT NULL,
  PRIMARY KEY (`Cod_CartaAval`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `AutomovilSiniestro` (
  `Cod_poliza` VARCHAR(60) DEFAULT NULL,
  `Cod_siniestroA` INT NOT NULL AUTO_INCREMENT,
  `Fecha_ocurrencia` DATE DEFAULT NULL,
  `Fecha_noti` DATE DEFAULT NULL,
  `Fecha_inspec` DATE DEFAULT NULL,
  `Estado` VARCHAR(50) DEFAULT NULL,
  `Monto_orden` DECIMAL(10,2) DEFAULT NULL,
  `Correo` VARCHAR(100) DEFAULT NULL,
  `Descripcion` TEXT DEFAULT NULL,
  `codigo_siniestro` VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (`Cod_siniestroA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── NOTAS ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `nota_Auto` (
  `idnota_Auto` INT NOT NULL AUTO_INCREMENT,
  `Cod_Auto` VARCHAR(45) DEFAULT NULL,
  `Observaciones` VARCHAR(500) DEFAULT NULL,
  `titulo` VARCHAR(100) DEFAULT NULL,
  `fecha` DATE DEFAULT NULL,
  PRIMARY KEY (`idnota_Auto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nota_cartaAval` (
  `idnota_cartaAval` INT NOT NULL AUTO_INCREMENT,
  `Cod_CartaAval` VARCHAR(45) DEFAULT NULL,
  `Observaciones` VARCHAR(500) DEFAULT NULL,
  `titulo` VARCHAR(100) DEFAULT NULL,
  `fecha` DATE DEFAULT NULL,
  PRIMARY KEY (`idnota_cartaAval`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nota_Reembolso` (
  `idnota_Reembolso` INT NOT NULL AUTO_INCREMENT,
  `Cod_Reembolso` VARCHAR(45) DEFAULT NULL,
  `Observaciones` VARCHAR(500) DEFAULT NULL,
  `titulo` VARCHAR(100) DEFAULT NULL,
  `fecha` DATE DEFAULT NULL,
  PRIMARY KEY (`idnota_Reembolso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ─── COMISIONES ───────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS `bloque_pago_comision` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_egreso` VARCHAR(100) DEFAULT NULL,
  `referencia_bancaria` VARCHAR(100) DEFAULT NULL,
  `fecha_movimiento` DATE DEFAULT NULL,
  `monto_total` FLOAT DEFAULT NULL,
  `compania` VARCHAR(100) DEFAULT NULL,
  `codigo_banco` VARCHAR(50) DEFAULT NULL,
  `fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `comision` (
  `cod_comision` INT NOT NULL AUTO_INCREMENT,
  `Cod_pago` INT DEFAULT NULL,
  `cod_ejecutivo` INT DEFAULT NULL,
  `cod_poliza` VARCHAR(60) DEFAULT NULL,
  `nro_recibo` VARCHAR(50) DEFAULT NULL,
  `Estado` VARCHAR(50) DEFAULT NULL,
  `bono` FLOAT DEFAULT NULL,
  `tasa` FLOAT DEFAULT NULL,
  `monto_bs` FLOAT DEFAULT NULL,
  `monto_d` FLOAT DEFAULT NULL,
  `monto_pago` FLOAT DEFAULT NULL,
  `monto_fraccion` FLOAT DEFAULT NULL,
  `moneda` VARCHAR(20) DEFAULT NULL,
  `id_bloque` INT DEFAULT NULL,
  `nro_recibo_externo` VARCHAR(100) DEFAULT NULL,
  `descripcion` VARCHAR(255) DEFAULT NULL,
  `comision_porcentaje` FLOAT DEFAULT NULL,
  PRIMARY KEY (`cod_comision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `comisiones_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `compania` VARCHAR(255) NOT NULL,
  `ramo` VARCHAR(255) NOT NULL,
  `subramo` VARCHAR(255) DEFAULT NULL,
  `producto` VARCHAR(255) NOT NULL,
  `tipo_ejecutivo` VARCHAR(255) NOT NULL,
  `porcentajes` VARCHAR(255) NOT NULL,
  `cod_ejecutivo` INT DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Índices secundarios sobre columnas de filtro/JOIN frecuente
-- (antes de esto, solo existían las PRIMARY KEY de cada tabla)
CREATE INDEX idx_poliza_ci_asegurado ON poliza (CI_asegurado);
CREATE INDEX idx_poliza_compania ON poliza (Cod_compania);
CREATE INDEX idx_poliza_ejecutivo ON poliza (cod_ejecutivo);
CREATE INDEX idx_renovacion_poliza ON renovacion (Cod_poliza);
CREATE INDEX idx_renovacion_estado ON renovacion (estado);
CREATE INDEX idx_comision_poliza ON comision (cod_poliza);
CREATE INDEX idx_comision_ejecutivo ON comision (cod_ejecutivo);

SET FOREIGN_KEY_CHECKS = 1;
