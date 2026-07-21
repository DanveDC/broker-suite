-- =====================================================================
-- catalogo_producto_schema.sql
--
-- Table that replaces the hardcoded JS catalogs `productosI` and
-- `productosN` in templates/public/Poliza/form_poliza.html with a real,
-- CRUD-manageable product catalog: Company -> Ramo -> Subramo -> Producto.
--
-- Charset/collation matches the rest of BD/estructura base de datos.sql
-- (utf8mb4 / utf8mb4_0900_ai_ci is used by 22 of its 23 CREATE TABLE
-- statements, including `compania` itself).
-- =====================================================================

CREATE TABLE IF NOT EXISTS `catalogo_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Cod_compania` INT NOT NULL,
  `base` ENUM('nacional','internacional') NOT NULL,
  `Ramo` VARCHAR(50) NOT NULL,
  `Subramo` VARCHAR(100) NOT NULL,
  `Producto` VARCHAR(150) NOT NULL,
  -- `activo`: soft-delete / enable flag. Disabling or "deleting" a product
  -- from the catalog must set this to 0 instead of removing the row --
  -- historical policies reference Ramo/Subramo/Producto as free text and
  -- must not break if a product is later retired from the catalog.
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_catalogo_combo` (`Cod_compania`, `base`, `Ramo`, `Subramo`, `Producto`),
  CONSTRAINT `fk_catalogo_compania` FOREIGN KEY (`Cod_compania`) REFERENCES `compania` (`Cod_compania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
