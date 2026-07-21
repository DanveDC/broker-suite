-- =====================================================================
-- catalogo_producto_seed.sql
--
-- Seed data migrated from the hardcoded JS catalogs `productosI` and
-- `productosN` in templates/public/Poliza/form_poliza.html.
--
-- Every (Company, base, Ramo, Subramo, Producto) leaf combination from
-- both JS objects is represented here as one row.
--
-- Company matching against the `compania` table (see
-- BD/Inserts base de datos aseguradora.sql) was done by exact name match
-- (case-insensitive, whitespace-trimmed). Two JS company names could NOT
-- be confidently matched to an existing `compania.Nombre` row:
--   - 'MERCANTIL PANAMÁ' (productosI)  -- distinct from 'MERCANTIL' (nacional)
--   - 'SEGUROS VENEZUELA' (productosN) -- no compania row at all
-- Their INSERT blocks below are commented out and flagged with TODO
-- comments. Everything else runs as-is.
--
-- Run BD/catalogo_producto_schema.sql before this file.
-- =====================================================================


-- ============================
-- productosI (internacional)
-- ============================

-- Company: MERCANTIL PANAMÁ (internacional) -- 3 leaf entries
-- TODO: no matching compania row for 'MERCANTIL PANAMÁ' -- insert it first or fix the name
-- INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL PANAMÁ'), 'internacional', 'Persona', 'SALUD', 'INTEGRAL'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL PANAMÁ'), 'internacional', 'Persona', 'SALUD', 'VITAL'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL PANAMÁ'), 'internacional', 'Persona', 'VIDA', 'VIDA A TERMINO');

-- Company: VUMI (internacional) -- 7 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'ACCESS VIP'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'ACCESS VIP LIGHT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'ABSOLUTE VIP'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'UNIVERSAL VIP'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'SPECIAL VIP'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'SENIOR VIP'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'VUMI'), 'internacional', 'Persona', 'SALUD', 'OPTIMUM VIP');

-- Company: LA REGIONAL (internacional) -- 16 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Persona', 'SALUD', 'MEDICARE CLASSIC'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'EMBARCACIONES', 'EMBARCACIONES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'INDUSTRIA Y COMERCIO', 'INDUSTRIA Y COMERCIO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Patrimonial', 'TRANSPORTE TERRESTRE', 'TRANSPORTE TERRESTRE OCASIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA REGIONAL'), 'internacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: CONTINENTAL (internacional) -- 8 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'ANUALES MULTIVIAJES', 'CORPORATIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'POR DÍAS', 'CONSUL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'POR DÍAS', 'GLOBAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'POR DÍAS', 'MAXIMUS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'POR DÍAS', 'SUPREME'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'POR DÍAS', 'TOTAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'LARGAS ESTADÍAS', 'LARGAS ESTADÍAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CONTINENTAL'), 'internacional', 'Viajes', 'ESTUDIANTES', 'ESTUDIANTES');

-- Company: AFIANAUCO (internacional) -- 4 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'AFIANAUCO'), 'internacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'AFIANAUCO'), 'internacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'AFIANAUCO'), 'internacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'AFIANAUCO'), 'internacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: AMERICAN FIDELITY (internacional) -- 1 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'AMERICAN FIDELITY'), 'internacional', 'Persona', 'VIDA', 'VIDA');

-- Company: PAN-AMERICAN (internacional) -- 1 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PAN-AMERICAN'), 'internacional', 'Persona', 'VIDA', 'VIDA');

-- ============================
-- productosN (nacional)
-- ============================

-- Company: MERCANTIL (nacional) -- 23 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'SALUD', '5K - 50K'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'SALUD', '100K - 200K'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'SALUD', 'EMERGENCIAS MÉDICAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'SALUD', 'SALUD COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'VIDA', 'DEL MAS ALLA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'VIDA', 'VIDA A TERMINO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Auto', 'CA/PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Auto', 'CA/PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Auto', 'RCV', 'RCV + GRUA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Auto', 'FLOTA DE VEHICULOS', 'FLOTA DE VEHICULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MERCANTIL'), 'nacional', 'Viaje', 'POR DIAS', 'POR DIAS');

-- Company: ESTAR SEGUROS (nacional) -- 26 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'SALUD', 'MEDICARE PLUS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'SALUD', 'AFFINITY'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'SALUD', 'ENFERMEDADES GRAVES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Persona', 'VIDA', 'VIDA TEMPORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'EMBARCACIONES', 'EMBARCACIONES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'INDUSTRIA Y COMERCIO', 'INDUSTRIA Y COMERCIO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Patrimonial', 'TRANSPORTE TERRESTRE', 'TRANSPORTE TERRESTRE OCASIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO LABORAL', 'FIEL CUMPLIMIENTO LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'ESTAR SEGUROS'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: LA INTERNACIONAL (nacional) -- 21 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Persona', 'SALUD', 'CLASICO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Persona', 'SALUD', 'AÑOS PLATEADOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Persona', 'SALUD', 'DIAMANTE Y ZAFIRO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'EMBARCACIONES', 'EMBARCACIONES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'INDUSTRIA Y COMERCIO', 'INDUSTRIA Y COMERCIO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'RCG', 'RCG VAYAS PUBLICITARIAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Patrimonial', 'TRANSPORTE TERRESTRE', 'TRANSPORTE TERRESTRE OCASIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'LA INTERNACIONAL'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: CARACAS (nacional) -- 23 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'SALUD', 'SALUD EN EL EXTERIOR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'SALUD', 'SALUD LOCAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Persona', 'AP', 'EMPLEADO SEGURO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'EMBARCACIONES', 'EMBARCACIONES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'INDUSTRIA Y COMERCIO', 'INDUSTRIA Y COMERCIO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Patrimonial', 'TRANSPORTE TERRESTRE', 'TRANSPORTE TERRESTRE OCASIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'CARACAS'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: banesco (nacional) -- 8 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'banesco'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS');

-- Company: UNIVERSITAS (nacional) -- 10 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Persona', 'SALUD', 'SALUD INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNIVERSITAS'), 'nacional', 'Mascotas', 'MASCOTAS', 'MASCOTAS PLUS');

-- Company: QUALITAS (nacional) -- 8 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Persona', 'SALUD', 'TU APOYO PREMIUM'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'QUALITAS'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: UNISEGUROS (nacional) -- 12 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'PLAN FAMILIAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Persona', 'FUNERARIO', 'FUNERARIO COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'UNISEGUROS'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: OCEANICA (nacional) -- 24 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'SALUD', 'HCM INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'SALUD', 'APOYO EN EMERGENCIAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'VIDA', 'Temporal'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Persona', 'VIDA', 'A termino'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'EMPRESAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'EMBARCACIONES', 'EMBARCACIONES'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'INDUSTRIA Y COMERCIO', 'INDUSTRIA Y COMERCIO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Patrimonial', 'TRANSPORTE TERRESTRE', 'TRANSPORTE TERRESTRE OCASIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'OCEANICA'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: PIRAMIDE (nacional) -- 9 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Persona', 'SALUD', 'HCM INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Persona', 'AP', 'AP INDIVIDUAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Persona', 'AP', 'AP COLECTIVO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Persona', 'AP', 'AP ESCOLAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Auto', 'CA / PT', 'CA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Auto', 'CA / PT', 'PT'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Auto', 'RCV', 'RCV'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Auto', 'RCV', 'RCV + GRÚA'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'PIRAMIDE'), 'nacional', 'Auto', 'FLOTA DE VEHÍCULOS', 'FLOTA DE VEHÍCULOS');

-- Company: REAL SEGUROS (nacional) -- 7 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Persona', 'SALUD', 'SALUD TRADICIONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Persona', 'SALUD', 'EMERGENCIAS MÉDICAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Patrimonial', 'COMBINADO EMPRESARIAL', 'COMBINADO EMPRESARIAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Patrimonial', 'COMBINADO RESIDENCIAL', 'HOGAR'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Patrimonial', 'RCG', 'RCG'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Patrimonial', 'RESPONSABILIDAD PATRONAL', 'RESPONSABILIDAD PATRONAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'REAL SEGUROS'), 'nacional', 'Patrimonial', 'RIESGOS DIVERSOS', 'RIESGOS DIVERSOS');

-- Company: MAPFRE (nacional) -- 5 leaf entries
INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MAPFRE'), 'nacional', 'Persona', 'SALUD', 'PROTECCIÓN SALUD'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MAPFRE'), 'nacional', 'Fianzas', 'FIANZAS', 'FIANZAS'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MAPFRE'), 'nacional', 'Fianzas', 'FIEL CUMPLIMIENTO', 'FIEL CUMPLIMIENTO'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MAPFRE'), 'nacional', 'Fianzas', 'LABORAL', 'LABORAL'),
((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'MAPFRE'), 'nacional', 'Fianzas', 'LICITACION', 'LICITACION');

-- Company: SEGUROS VENEZUELA (nacional) -- 18 leaf entries
-- TODO: no matching compania row for 'SEGUROS VENEZUELA' -- insert it first or fix the name
-- INSERT INTO `catalogo_producto` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`) VALUES
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'SALUD', 'ORO'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'SALUD', 'PLATA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'SALUD', 'BRONCE'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'VIDA', 'IMPULSO FAMILIAR'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'VIDA', 'PROTECCIÓN FAMILIAR'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'VIDA', 'AYUDA FAMILIAR'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'FUNERARIO', 'DIAMANTE'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'FUNERARIO', 'PLATINIUM'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'FUNERARIO', 'PLATA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN FEMENINA', 'ORQUIDEA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN FEMENINA', 'ROSA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN FEMENINA', 'MARGARITA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN MASCULINA', 'TIERRA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN MASCULINA', 'AGUA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Persona', 'PREVENCIÓN MASCULINA', 'AIRE'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Auto', 'COBERTURA AMPLIA', 'COBERTURA AMPLIA'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Auto', 'PERDIDA TOTAL', 'PERDIDA TOTAL'),
-- ((SELECT `Cod_compania` FROM `compania` WHERE `Nombre` = 'SEGUROS VENEZUELA'), 'nacional', 'Auto', 'RCV', 'RCV');
