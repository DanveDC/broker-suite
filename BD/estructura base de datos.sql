CREATE DATABASE  IF NOT EXISTS `cabal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cabal`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: cabal
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asegurado`
--

DROP TABLE IF EXISTS `asegurado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asegurado` (
  `CI` int NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Nombre2` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Apellido2` varchar(50) DEFAULT NULL,
  `Tipo_CI` varchar(20) DEFAULT NULL,
  `Correo` varchar(200) DEFAULT NULL,
  `Fecha_nacimiento` date DEFAULT NULL,
  `Telefono` varchar(40) DEFAULT NULL,
  `Ejecutivo` varchar(45) DEFAULT NULL,
  `profesion` varchar(45) DEFAULT NULL,
  `localidad` varchar(45) DEFAULT NULL,
  `canal` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_asegurado_ai` AFTER INSERT ON `asegurado` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'asegurado',
        'INSERT',
        NEW.CI,
        USER(),
        NOW(),
        JSON_OBJECT(
            'CI', NEW.CI, 'Nombre', NEW.Nombre, 'Nombre2', NEW.Nombre2, 'Apellido', NEW.Apellido,
            'Apellido2', NEW.Apellido2, 'Tipo_CI', NEW.Tipo_CI, 'Correo', NEW.Correo,
            'Fecha_nacimiento', NEW.Fecha_nacimiento, 'Telefono', NEW.Telefono,
            'Ejecutivo', NEW.Ejecutivo, 'profesion', NEW.profesion,
            'localidad', NEW.localidad, 'canal', NEW.canal
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_asegurado_au` AFTER UPDATE ON `asegurado` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'asegurado',
        'UPDATE',
        NEW.CI,
        USER(),
        NOW(),
        JSON_OBJECT(
            'CI', OLD.CI, 'Nombre', OLD.Nombre, 'Nombre2', OLD.Nombre2, 'Apellido', OLD.Apellido,
            'Apellido2', OLD.Apellido2, 'Tipo_CI', OLD.Tipo_CI, 'Correo', OLD.Correo,
            'Fecha_nacimiento', OLD.Fecha_nacimiento, 'Telefono', OLD.Telefono,
            'Ejecutivo', OLD.Ejecutivo, 'profesion', OLD.profesion,
            'localidad', OLD.localidad, 'canal', OLD.canal
        ),
        JSON_OBJECT(
            'CI', NEW.CI, 'Nombre', NEW.Nombre, 'Nombre2', NEW.Nombre2, 'Apellido', NEW.Apellido,
            'Apellido2', NEW.Apellido2, 'Tipo_CI', NEW.Tipo_CI, 'Correo', NEW.Correo,
            'Fecha_nacimiento', NEW.Fecha_nacimiento, 'Telefono', NEW.Telefono,
            'Ejecutivo', NEW.Ejecutivo, 'profesion', NEW.profesion,
            'localidad', NEW.localidad, 'canal', NEW.canal
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_asegurado_ad` AFTER DELETE ON `asegurado` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'asegurado',
        'DELETE',
        OLD.CI,
        USER(),
        NOW(),
        JSON_OBJECT(
            'CI', OLD.CI, 'Nombre', OLD.Nombre, 'Nombre2', OLD.Nombre2, 'Apellido', OLD.Apellido,
            'Apellido2', OLD.Apellido2, 'Tipo_CI', OLD.Tipo_CI, 'Correo', OLD.Correo,
            'Fecha_nacimiento', OLD.Fecha_nacimiento, 'Telefono', OLD.Telefono,
            'Ejecutivo', OLD.Ejecutivo, 'profesion', OLD.profesion,
            'localidad', OLD.localidad, 'canal', OLD.canal
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auto`
--

DROP TABLE IF EXISTS `auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto` (
  `Cod_poliza` varchar(50) NOT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `año` varchar(50) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `Subramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_auto_ai` AFTER INSERT ON `auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'auto',
        'INSERT',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'modelo', NEW.modelo, 'Producto', NEW.Producto,
            'placa', NEW.placa, 'año', NEW.año, 'marca', NEW.marca, 'Subramo', NEW.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_auto_au` AFTER UPDATE ON `auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'auto',
        'UPDATE',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'modelo', OLD.modelo, 'Producto', OLD.Producto,
            'placa', OLD.placa, 'año', OLD.año, 'marca', OLD.marca, 'Subramo', OLD.Subramo
        ),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'modelo', NEW.modelo, 'Producto', NEW.Producto,
            'placa', NEW.placa, 'año', NEW.año, 'marca', NEW.marca, 'Subramo', NEW.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_auto_ad` AFTER DELETE ON `auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'auto',
        'DELETE',
        OLD.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'modelo', OLD.modelo, 'Producto', OLD.Producto,
            'placa', OLD.placa, 'año', OLD.año, 'marca', OLD.marca, 'Subramo', OLD.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `automovilsiniestro`
--

DROP TABLE IF EXISTS `automovilsiniestro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automovilsiniestro` (
  `Cod_poliza` varchar(50) DEFAULT NULL,
  `Cod_siniestroA` int NOT NULL AUTO_INCREMENT,
  `Fecha_ocurrencia` date DEFAULT NULL,
  `Fecha_noti` date DEFAULT NULL,
  `Fecha_inspec` date DEFAULT NULL,
  `Estado` varchar(50) DEFAULT NULL,
  `Monto_orden` decimal(10,2) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Descripcion` text,
  `codigo_siniestro` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`Cod_siniestroA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_automovilsiniestro_ai` AFTER INSERT ON `automovilsiniestro` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'automovilsiniestro',
        'INSERT',
        NEW.Cod_siniestroA,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_siniestroA', NEW.Cod_siniestroA, 'Cod_poliza', NEW.Cod_poliza, 'Fecha_ocurrencia', NEW.Fecha_ocurrencia,
            'Fecha_noti', NEW.Fecha_noti, 'Fecha_inspec', NEW.Fecha_inspec, 'Estado', NEW.Estado,
            'Monto_orden', NEW.Monto_orden, 'Correo', NEW.Correo, 'Descripcion', NEW.Descripcion,
            'codigo_siniestro', NEW.codigo_siniestro
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_automovilsiniestro_au` AFTER UPDATE ON `automovilsiniestro` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'automovilsiniestro',
        'UPDATE',
        NEW.Cod_siniestroA,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_siniestroA', OLD.Cod_siniestroA, 'Cod_poliza', OLD.Cod_poliza, 'Fecha_ocurrencia', OLD.Fecha_ocurrencia,
            'Fecha_noti', OLD.Fecha_noti, 'Fecha_inspec', OLD.Fecha_inspec, 'Estado', OLD.Estado,
            'Monto_orden', OLD.Monto_orden, 'Correo', OLD.Correo, 'Descripcion', OLD.Descripcion,
            'codigo_siniestro', OLD.codigo_siniestro
        ),
        JSON_OBJECT(
            'Cod_siniestroA', NEW.Cod_siniestroA, 'Cod_poliza', NEW.Cod_poliza, 'Fecha_ocurrencia', NEW.Fecha_ocurrencia,
            'Fecha_noti', NEW.Fecha_noti, 'Fecha_inspec', NEW.Fecha_inspec, 'Estado', NEW.Estado,
            'Monto_orden', NEW.Monto_orden, 'Correo', NEW.Correo, 'Descripcion', NEW.Descripcion,
            'codigo_siniestro', NEW.codigo_siniestro
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_automovilsiniestro_ad` AFTER DELETE ON `automovilsiniestro` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'automovilsiniestro',
        'DELETE',
        OLD.Cod_siniestroA,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_siniestroA', OLD.Cod_siniestroA, 'Cod_poliza', OLD.Cod_poliza, 'Fecha_ocurrencia', OLD.Fecha_ocurrencia,
            'Fecha_noti', OLD.Fecha_noti, 'Fecha_inspec', OLD.Fecha_inspec, 'Estado', OLD.Estado,
            'Monto_orden', OLD.Monto_orden, 'Correo', OLD.Correo, 'Descripcion', OLD.Descripcion,
            'codigo_siniestro', OLD.codigo_siniestro
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `beneficiario`
--

DROP TABLE IF EXISTS `beneficiario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiario` (
  `Cod_poliza` varchar(50) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Apellido` varchar(100) DEFAULT NULL,
  `Cedula` varchar(20) DEFAULT NULL,
  `Parentesco` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_beneficiario_ai` AFTER INSERT ON `beneficiario` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'beneficiario',
        'INSERT',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'Nombre', NEW.Nombre, 'Apellido', NEW.Apellido,
            'Cedula', NEW.Cedula, 'Parentesco', NEW.Parentesco
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_beneficiario_au` AFTER UPDATE ON `beneficiario` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'beneficiario',
        'UPDATE',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'Nombre', OLD.Nombre, 'Apellido', OLD.Apellido,
            'Cedula', OLD.Cedula, 'Parentesco', OLD.Parentesco
        ),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'Nombre', NEW.Nombre, 'Apellido', NEW.Apellido,
            'Cedula', NEW.Cedula, 'Parentesco', NEW.Parentesco
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_beneficiario_ad` AFTER DELETE ON `beneficiario` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'beneficiario',
        'DELETE',
        OLD.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'Nombre', OLD.Nombre, 'Apellido', OLD.Apellido,
            'Cedula', OLD.Cedula, 'Parentesco', OLD.Parentesco
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `id_bitacora` int NOT NULL AUTO_INCREMENT,
  `tabla` varchar(64) NOT NULL COMMENT 'Nombre de la tabla afectada',
  `operacion` enum('INSERT','UPDATE','DELETE') NOT NULL COMMENT 'Tipo de operación DML',
  `registro_id` varchar(255) DEFAULT NULL COMMENT 'Valor de la clave primaria del registro afectado',
  `usuario` varchar(255) DEFAULT NULL COMMENT 'Usuario que realizó la operación',
  `fecha_hora` datetime NOT NULL COMMENT 'Fecha y hora de la operación',
  `valores_antiguos` json DEFAULT NULL COMMENT 'Datos del registro antes de la operación (UPDATE/DELETE)',
  `valores_nuevos` json DEFAULT NULL COMMENT 'Datos del registro después de la operación (INSERT/UPDATE)',
  PRIMARY KEY (`id_bitacora`),
  KEY `idx_tabla_id` (`tabla`,`registro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6402 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carta_aval`
--

DROP TABLE IF EXISTS `carta_aval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carta_aval` (
  `Cod_poliza` varchar(50) DEFAULT NULL,
  `Cod_CartaAval` int NOT NULL AUTO_INCREMENT,
  `Diagnostico` varchar(255) DEFAULT NULL,
  `Estado` varchar(50) DEFAULT NULL,
  `Moneda` varchar(20) DEFAULT NULL,
  `Monto_solicitado` decimal(10,2) DEFAULT NULL,
  `Monto_aprobado` decimal(10,2) DEFAULT NULL,
  `Fecha_noti` date DEFAULT NULL,
  `Fecha_apro` date DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `codigo_siniestro` varchar(65) DEFAULT NULL,
  `Tipo_Atencion` varchar(65) DEFAULT NULL,
  `Monto_aprobadoD` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Cod_CartaAval`),
  CONSTRAINT `carta_aval_chk_1` CHECK ((`Moneda` in (_utf8mb4'Dolares',_utf8mb4'Bolivares')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_carta_aval_ai` AFTER INSERT ON `carta_aval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'carta_aval',
        'INSERT',
        NEW.Cod_CartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_CartaAval', NEW.Cod_CartaAval, 'Cod_poliza', NEW.Cod_poliza, 'Diagnostico', NEW.Diagnostico,
            'Estado', NEW.Estado, 'Moneda', NEW.Moneda, 'Monto_solicitado', NEW.Monto_solicitado,
            'Monto_aprobado', NEW.Monto_aprobado, 'Fecha_noti', NEW.Fecha_noti, 'Fecha_apro', NEW.Fecha_apro,
            'Correo', NEW.Correo, 'codigo_siniestro', NEW.codigo_siniestro,
            'Tipo_Atencion', NEW.Tipo_Atencion, 'Monto_aprobadoD', NEW.Monto_aprobadoD
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_carta_aval_au` AFTER UPDATE ON `carta_aval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'carta_aval',
        'UPDATE',
        NEW.Cod_CartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_CartaAval', OLD.Cod_CartaAval, 'Cod_poliza', OLD.Cod_poliza, 'Diagnostico', OLD.Diagnostico,
            'Estado', OLD.Estado, 'Moneda', OLD.Moneda, 'Monto_solicitado', OLD.Monto_solicitado,
            'Monto_aprobado', OLD.Monto_aprobado, 'Fecha_noti', OLD.Fecha_noti, 'Fecha_apro', OLD.Fecha_apro,
            'Correo', OLD.Correo, 'codigo_siniestro', OLD.codigo_siniestro,
            'Tipo_Atencion', OLD.Tipo_Atencion, 'Monto_aprobadoD', OLD.Monto_aprobadoD
        ),
        JSON_OBJECT(
            'Cod_CartaAval', NEW.Cod_CartaAval, 'Cod_poliza', NEW.Cod_poliza, 'Diagnostico', NEW.Diagnostico,
            'Estado', NEW.Estado, 'Moneda', NEW.Moneda, 'Monto_solicitado', NEW.Monto_solicitado,
            'Monto_aprobado', NEW.Monto_aprobado, 'Fecha_noti', NEW.Fecha_noti, 'Fecha_apro', NEW.Fecha_apro,
            'Correo', NEW.Correo, 'codigo_siniestro', NEW.codigo_siniestro,
            'Tipo_Atencion', NEW.Tipo_Atencion, 'Monto_aprobadoD', NEW.Monto_aprobadoD
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_carta_aval_ad` AFTER DELETE ON `carta_aval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'carta_aval',
        'DELETE',
        OLD.Cod_CartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_CartaAval', OLD.Cod_CartaAval, 'Cod_poliza', OLD.Cod_poliza, 'Diagnostico', OLD.Diagnostico,
            'Estado', OLD.Estado, 'Moneda', OLD.Moneda, 'Monto_solicitado', OLD.Monto_solicitado,
            'Monto_aprobado', OLD.Monto_aprobado, 'Fecha_noti', OLD.Fecha_noti, 'Fecha_apro', OLD.Fecha_apro,
            'Correo', OLD.Correo, 'codigo_siniestro', OLD.codigo_siniestro,
            'Tipo_Atencion', OLD.Tipo_Atencion, 'Monto_aprobadoD', OLD.Monto_aprobadoD
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `comision`
--

DROP TABLE IF EXISTS `comision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comision` (
  `Cod_pago` int DEFAULT NULL,
  `cod_ejecutivo` int DEFAULT NULL,
  `cod_comision` int NOT NULL AUTO_INCREMENT,
  `Estado` varchar(45) DEFAULT NULL,
  `bono` float DEFAULT NULL,
  `tasa` float DEFAULT NULL,
  `monto_bs` float DEFAULT NULL,
  PRIMARY KEY (`cod_comision`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_comision_ai` AFTER INSERT ON `comision` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'comision',
        'INSERT',
        NEW.cod_comision,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_comision', NEW.cod_comision, 'Cod_pago', NEW.Cod_pago, 'cod_ejecutivo', NEW.cod_ejecutivo,
            'Estado', NEW.Estado, 'bono', NEW.bono, 'tasa', NEW.tasa, 'monto_bs', NEW.monto_bs
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_comision_au` AFTER UPDATE ON `comision` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'comision',
        'UPDATE',
        NEW.cod_comision,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_comision', OLD.cod_comision, 'Cod_pago', OLD.Cod_pago, 'cod_ejecutivo', OLD.cod_ejecutivo,
            'Estado', OLD.Estado, 'bono', OLD.bono, 'tasa', OLD.tasa, 'monto_bs', OLD.monto_bs
        ),
        JSON_OBJECT(
            'cod_comision', NEW.cod_comision, 'Cod_pago', NEW.Cod_pago, 'cod_ejecutivo', NEW.cod_ejecutivo,
            'Estado', NEW.Estado, 'bono', NEW.bono, 'tasa', NEW.tasa, 'monto_bs', NEW.monto_bs
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_comision_ad` AFTER DELETE ON `comision` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'comision',
        'DELETE',
        OLD.cod_comision,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_comision', OLD.cod_comision, 'Cod_pago', OLD.Cod_pago, 'cod_ejecutivo', OLD.cod_ejecutivo,
            'Estado', OLD.Estado, 'bono', OLD.bono, 'tasa', OLD.tasa, 'monto_bs', OLD.monto_bs
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `comisiones_config`
--

DROP TABLE IF EXISTS `comisiones_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comisiones_config` (
  `compania` varchar(50) DEFAULT NULL,
  `ramo` varchar(45) DEFAULT NULL,
  `subramo` varchar(45) DEFAULT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `tipo_ejecutivo` varchar(45) DEFAULT NULL,
  `porcentajes` varchar(45) DEFAULT NULL,
  `comisiones_configcol` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`comisiones_configcol`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comisiones_ejecutivos`
--

DROP TABLE IF EXISTS `comisiones_ejecutivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comisiones_ejecutivos` (
  `idcomisiones_ejecutivos` int NOT NULL AUTO_INCREMENT,
  `cod_ejecutivo` varchar(45) DEFAULT NULL,
  `comision_bono` double DEFAULT NULL,
  `compania` varchar(45) DEFAULT NULL,
  `ramo` varchar(45) DEFAULT NULL,
  `subramo` varchar(45) DEFAULT NULL,
  `producto` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`idcomisiones_ejecutivos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_com_ejec_ai` AFTER INSERT ON `comisiones_ejecutivos` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'comisiones_ejecutivos',
        'INSERT',
        NEW.idcomisiones_ejecutivos,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idcomisiones_ejecutivos', NEW.idcomisiones_ejecutivos, 'cod_ejecutivo', NEW.cod_ejecutivo,
            'comision_bono', NEW.comision_bono, 'compania', NEW.compania, 'ramo', NEW.ramo,
            'subramo', NEW.subramo, 'producto', NEW.producto
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_com_ejec_au` AFTER UPDATE ON `comisiones_ejecutivos` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'comisiones_ejecutivos',
        'UPDATE',
        NEW.idcomisiones_ejecutivos,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idcomisiones_ejecutivos', OLD.idcomisiones_ejecutivos, 'cod_ejecutivo', OLD.cod_ejecutivo,
            'comision_bono', OLD.comision_bono, 'compania', OLD.compania, 'ramo', OLD.ramo,
            'subramo', OLD.subramo, 'producto', OLD.producto
        ),
        JSON_OBJECT(
            'idcomisiones_ejecutivos', NEW.idcomisiones_ejecutivos, 'cod_ejecutivo', NEW.cod_ejecutivo,
            'comision_bono', NEW.comision_bono, 'compania', NEW.compania, 'ramo', NEW.ramo,
            'subramo', NEW.subramo, 'producto', NEW.producto
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_com_ejec_ad` AFTER DELETE ON `comisiones_ejecutivos` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'comisiones_ejecutivos',
        'DELETE',
        OLD.idcomisiones_ejecutivos,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idcomisiones_ejecutivos', OLD.idcomisiones_ejecutivos, 'cod_ejecutivo', OLD.cod_ejecutivo,
            'comision_bono', OLD.comision_bono, 'compania', OLD.compania, 'ramo', OLD.ramo,
            'subramo', OLD.subramo, 'producto', OLD.producto
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `compania`
--

DROP TABLE IF EXISTS `compania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compania` (
  `Cod_compania` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) DEFAULT NULL,
  `rif` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`Cod_compania`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_compania_ai` AFTER INSERT ON `compania` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'compania',
        'INSERT',
        NEW.Cod_compania,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_compania', NEW.Cod_compania, 'Nombre', NEW.Nombre, 'rif', NEW.rif
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_compania_au` AFTER UPDATE ON `compania` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'compania',
        'UPDATE',
        NEW.Cod_compania,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_compania', OLD.Cod_compania, 'Nombre', OLD.Nombre, 'rif', OLD.rif
        ),
        JSON_OBJECT(
            'Cod_compania', NEW.Cod_compania, 'Nombre', NEW.Nombre, 'rif', NEW.rif
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_compania_ad` AFTER DELETE ON `compania` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'compania',
        'DELETE',
        OLD.Cod_compania,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_compania', OLD.Cod_compania, 'Nombre', OLD.Nombre, 'rif', OLD.rif
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ejecutivo`
--

DROP TABLE IF EXISTS `ejecutivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ejecutivo` (
  `CI` int DEFAULT NULL,
  `cod_ejecutivo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `nombre2` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Apellido2` varchar(50) DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Tipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cod_ejecutivo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ejecutivo_ai` AFTER INSERT ON `ejecutivo` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'ejecutivo',
        'INSERT',
        NEW.cod_ejecutivo,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_ejecutivo', NEW.cod_ejecutivo, 'CI', NEW.CI, 'Nombre', NEW.Nombre,
            'nombre2', NEW.nombre2, 'Apellido', NEW.Apellido, 'Apellido2', NEW.Apellido2,
            'Correo', NEW.Correo, 'Telefono', NEW.Telefono, 'Tipo', NEW.Tipo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ejecutivo_au` AFTER UPDATE ON `ejecutivo` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'ejecutivo',
        'UPDATE',
        NEW.cod_ejecutivo,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_ejecutivo', OLD.cod_ejecutivo, 'CI', OLD.CI, 'Nombre', OLD.Nombre,
            'nombre2', OLD.nombre2, 'Apellido', OLD.Apellido, 'Apellido2', OLD.Apellido2,
            'Correo', OLD.Correo, 'Telefono', OLD.Telefono, 'Tipo', OLD.Tipo
        ),
        JSON_OBJECT(
            'cod_ejecutivo', NEW.cod_ejecutivo, 'CI', NEW.CI, 'Nombre', NEW.Nombre,
            'nombre2', NEW.nombre2, 'Apellido', NEW.Apellido, 'Apellido2', NEW.Apellido2,
            'Correo', NEW.Correo, 'Telefono', NEW.Telefono, 'Tipo', NEW.Tipo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ejecutivo_ad` AFTER DELETE ON `ejecutivo` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'ejecutivo',
        'DELETE',
        OLD.cod_ejecutivo,
        USER(),
        NOW(),
        JSON_OBJECT(
            'cod_ejecutivo', OLD.cod_ejecutivo, 'CI', OLD.CI, 'Nombre', OLD.Nombre,
            'nombre2', OLD.nombre2, 'Apellido', OLD.Apellido, 'Apellido2', OLD.Apellido2,
            'Correo', OLD.Correo, 'Telefono', OLD.Telefono, 'Tipo', OLD.Tipo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `fianza`
--

DROP TABLE IF EXISTS `fianza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fianza` (
  `Cod_poliza` varchar(50) NOT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `Subramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_fianza_ai` AFTER INSERT ON `fianza` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'fianza',
        'INSERT',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'Producto', NEW.Producto, 'Subramo', NEW.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_fianza_au` AFTER UPDATE ON `fianza` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'fianza',
        'UPDATE',
        NEW.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'Producto', OLD.Producto, 'Subramo', OLD.Subramo
        ),
        JSON_OBJECT(
            'Cod_poliza', NEW.Cod_poliza, 'Producto', NEW.Producto, 'Subramo', NEW.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_fianza_ad` AFTER DELETE ON `fianza` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'fianza',
        'DELETE',
        OLD.Cod_poliza,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_poliza', OLD.Cod_poliza, 'Producto', OLD.Producto, 'Subramo', OLD.Subramo
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nota_auto`
--

DROP TABLE IF EXISTS `nota_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_auto` (
  `idnota_Auto` int NOT NULL AUTO_INCREMENT,
  `Cod_Auto` varchar(45) DEFAULT NULL,
  `Observaciones` varchar(150) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idnota_Auto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_auto_ai` AFTER INSERT ON `nota_auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'nota_auto',
        'INSERT',
        NEW.idnota_Auto,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Auto', NEW.idnota_Auto, 'Cod_Auto', NEW.Cod_Auto, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_auto_au` AFTER UPDATE ON `nota_auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'nota_auto',
        'UPDATE',
        NEW.idnota_Auto,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Auto', OLD.idnota_Auto, 'Cod_Auto', OLD.Cod_Auto, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        ),
        JSON_OBJECT(
            'idnota_Auto', NEW.idnota_Auto, 'Cod_Auto', NEW.Cod_Auto, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_auto_ad` AFTER DELETE ON `nota_auto` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'nota_auto',
        'DELETE',
        OLD.idnota_Auto,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Auto', OLD.idnota_Auto, 'Cod_Auto', OLD.Cod_Auto, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nota_cartaaval`
--

DROP TABLE IF EXISTS `nota_cartaaval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_cartaaval` (
  `idnota_cartaAval` int NOT NULL AUTO_INCREMENT,
  `Cod_CartaAval` varchar(45) DEFAULT NULL,
  `Observaciones` varchar(150) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idnota_cartaAval`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_cartaaval_ai` AFTER INSERT ON `nota_cartaaval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'nota_cartaaval',
        'INSERT',
        NEW.idnota_cartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_cartaAval', NEW.idnota_cartaAval, 'Cod_CartaAval', NEW.Cod_CartaAval, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_cartaaval_au` AFTER UPDATE ON `nota_cartaaval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'nota_cartaaval',
        'UPDATE',
        NEW.idnota_cartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_cartaAval', OLD.idnota_cartaAval, 'Cod_CartaAval', OLD.Cod_CartaAval, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        ),
        JSON_OBJECT(
            'idnota_cartaAval', NEW.idnota_cartaAval, 'Cod_CartaAval', NEW.Cod_CartaAval, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_cartaaval_ad` AFTER DELETE ON `nota_cartaaval` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'nota_cartaaval',
        'DELETE',
        OLD.idnota_cartaAval,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_cartaAval', OLD.idnota_cartaAval, 'Cod_CartaAval', OLD.Cod_CartaAval, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nota_reembolso`
--

DROP TABLE IF EXISTS `nota_reembolso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_reembolso` (
  `idnota_Reembolso` int NOT NULL AUTO_INCREMENT,
  `Cod_Reembolso` varchar(45) DEFAULT NULL,
  `Observaciones` varchar(150) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idnota_Reembolso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_reembolso_ai` AFTER INSERT ON `nota_reembolso` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'nota_reembolso',
        'INSERT',
        NEW.idnota_Reembolso,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Reembolso', NEW.idnota_Reembolso, 'Cod_Reembolso', NEW.Cod_Reembolso, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_reembolso_au` AFTER UPDATE ON `nota_reembolso` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'nota_reembolso',
        'UPDATE',
        NEW.idnota_Reembolso,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Reembolso', OLD.idnota_Reembolso, 'Cod_Reembolso', OLD.Cod_Reembolso, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        ),
        JSON_OBJECT(
            'idnota_Reembolso', NEW.idnota_Reembolso, 'Cod_Reembolso', NEW.Cod_Reembolso, 'Observaciones', NEW.Observaciones,
            'titulo', NEW.titulo, 'fecha', NEW.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_nota_reembolso_ad` AFTER DELETE ON `nota_reembolso` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'nota_reembolso',
        'DELETE',
        OLD.idnota_Reembolso,
        USER(),
        NOW(),
        JSON_OBJECT(
            'idnota_Reembolso', OLD.idnota_Reembolso, 'Cod_Reembolso', OLD.Cod_Reembolso, 'Observaciones', OLD.Observaciones,
            'titulo', OLD.titulo, 'fecha', OLD.fecha
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pago` (
  `Cod_renovacion` int DEFAULT NULL,
  `Cod_pago` int NOT NULL AUTO_INCREMENT,
  `moneda` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `Metodo_pago` varchar(50) DEFAULT NULL,
  `tasa` float DEFAULT NULL,
  `monto` float DEFAULT NULL,
  `bonificacion` float DEFAULT NULL,
  `fecha_pagada` date DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `procesado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Cod_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=4934 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pago_ai` AFTER INSERT ON `pago` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_nuevos)
    VALUES (
        'pago',
        'INSERT',
        NEW.Cod_pago,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_pago', NEW.Cod_pago, 'Cod_renovacion', NEW.Cod_renovacion, 'moneda', NEW.moneda,
            'fecha', NEW.fecha, 'Metodo_pago', NEW.Metodo_pago, 'tasa', NEW.tasa,
            'monto', NEW.monto, 'bonificacion', NEW.bonificacion, 'fecha_pagada', NEW.fecha_pagada,
            'estado', NEW.estado, 'procesado', NEW.procesado
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pago_au` AFTER UPDATE ON `pago` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos, valores_nuevos)
    VALUES (
        'pago',
        'UPDATE',
        NEW.Cod_pago,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_pago', OLD.Cod_pago, 'Cod_renovacion', OLD.Cod_renovacion, 'moneda', OLD.moneda,
            'fecha', OLD.fecha, 'Metodo_pago', OLD.Metodo_pago, 'tasa', OLD.tasa,
            'monto', OLD.monto, 'bonificacion', OLD.bonificacion, 'fecha_pagada', OLD.fecha_pagada,
            'estado', OLD.estado, 'procesado', OLD.procesado
        ),
        JSON_OBJECT(
            'Cod_pago', NEW.Cod_pago, 'Cod_renovacion', NEW.Cod_renovacion, 'moneda', NEW.moneda,
            'fecha', NEW.fecha, 'Metodo_pago', NEW.Metodo_pago, 'tasa', NEW.tasa,
            'monto', NEW.monto, 'bonificacion', NEW.bonificacion, 'fecha_pagada', NEW.fecha_pagada,
            'estado', NEW.estado, 'procesado', NEW.procesado
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_pago_ad` AFTER DELETE ON `pago` FOR EACH ROW BEGIN
    INSERT INTO bitacora (tabla, operacion, registro_id, usuario, fecha_hora, valores_antiguos)
    VALUES (
        'pago',
        'DELETE',
        OLD.Cod_pago,
        USER(),
        NOW(),
        JSON_OBJECT(
            'Cod_pago', OLD.Cod_pago, 'Cod_renovacion', OLD.Cod_renovacion, 'moneda', OLD.moneda,
            'fecha', OLD.fecha, 'Metodo_pago', OLD.Metodo_pago, 'tasa', OLD.tasa,
            'monto', OLD.monto, 'bonificacion', OLD.bonificacion, 'fecha_pagada', OLD.fecha_pagada,
            'estado', OLD.estado, 'procesado', OLD.procesado
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patrimonio`
--

DROP TABLE IF EXISTS `patrimonio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrimonio` (
  `Cod_poliza` varchar(50) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `Subramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `Cod_poliza` varchar(50) NOT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `Subramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poliza`
--

DROP TABLE IF EXISTS `poliza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poliza` (
  `cod_poliza` varchar(50) NOT NULL,
  `CI_asegurado` int DEFAULT NULL,
  `Fecha_emision` date DEFAULT NULL,
  `Cod_compania` int DEFAULT NULL,
  `Tomador` varchar(80) DEFAULT NULL,
  `Ramo` varchar(50) DEFAULT NULL,
  `Tipo_venta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reembolso`
--

DROP TABLE IF EXISTS `reembolso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reembolso` (
  `Cod_poliza` varchar(50) DEFAULT NULL,
  `cod_reembolso` int NOT NULL AUTO_INCREMENT,
  `Diagnostico` varchar(255) DEFAULT NULL,
  `Estado` varchar(50) DEFAULT NULL,
  `Fecha_ocurrencia` date DEFAULT NULL,
  `Fecha_noti` date DEFAULT NULL,
  `Fecha_max` date DEFAULT NULL,
  `Moneda` varchar(20) DEFAULT NULL,
  `Monto_solicitado` decimal(10,2) DEFAULT NULL,
  `Monto_pagado` decimal(10,2) DEFAULT NULL,
  `Fecha_pago` date DEFAULT NULL,
  `Correo` varchar(100) DEFAULT NULL,
  `codigo_siniestro` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`cod_reembolso`),
  CONSTRAINT `reembolso_chk_1` CHECK ((`Moneda` in (_utf8mb4'Dolares',_utf8mb4'Bolivares')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `renovacion`
--

DROP TABLE IF EXISTS `renovacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `renovacion` (
  `Cod_poliza` varchar(50) DEFAULT NULL,
  `Cod_renovacion` int NOT NULL AUTO_INCREMENT,
  `Prima` float DEFAULT NULL,
  `Frecuencia` int DEFAULT NULL,
  `Fecha_contrato` date DEFAULT NULL,
  `cobertura` varchar(50) DEFAULT NULL,
  `Fecha_vencimiento` date DEFAULT NULL,
  `comision` float DEFAULT NULL,
  `riesgo` float DEFAULT NULL,
  `Estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Cod_renovacion`)
) ENGINE=InnoDB AUTO_INCREMENT=1314 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_surname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_user` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `permisos` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viaje` (
  `Cod_poliza` varchar(50) NOT NULL,
  `cod_pasaporte` varchar(50) DEFAULT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `Subramo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Cod_poliza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'cabal'
--

--
-- Dumping routines for database 'cabal'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-16  0:12:00
