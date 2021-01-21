-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema glovo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema glovo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `glovo` DEFAULT CHARACTER SET utf8 ;
USE `glovo` ;

-- -----------------------------------------------------
-- Table `glovo`.`continente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`continente` (
  `idcontinente` INT NOT NULL AUTO_INCREMENT,
  `ISO` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcontinente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`pais` (
  `idpais` INT NOT NULL AUTO_INCREMENT,
  `ISO3` VARCHAR(45) NOT NULL,
  `countryCode` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `continente_idcontinente` INT NOT NULL,
  PRIMARY KEY (`idpais`),
  INDEX `fk_pais_continente1_idx` (`continente_idcontinente` ASC) VISIBLE,
  CONSTRAINT `fk_pais_continente1`
    FOREIGN KEY (`continente_idcontinente`)
    REFERENCES `glovo`.`continente` (`idcontinente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`ciudad` (
  `idciudad` INT NOT NULL AUTO_INCREMENT,
  `cityCode` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `pais_idpais` INT NOT NULL,
  PRIMARY KEY (`idciudad`),
  INDEX `fk_ciudad_pais_idx` (`pais_idpais` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_pais`
    FOREIGN KEY (`pais_idpais`)
    REFERENCES `glovo`.`pais` (`idpais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`repartidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`repartidor` (
  `idrepartidor` INT NOT NULL AUTO_INCREMENT,
  `DPI` VARCHAR(45) NOT NULL,
  `NIT` VARCHAR(45) NOT NULL,
  `nombreApellido` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `cuentaBancaria` VARCHAR(45) NOT NULL,
  `licencia` VARCHAR(45) NULL,
  `ciudad_idciudad` INT NOT NULL,
  PRIMARY KEY (`idrepartidor`),
  INDEX `fk_repartidor_ciudad1_idx` (`ciudad_idciudad` ASC) VISIBLE,
  CONSTRAINT `fk_repartidor_ciudad1`
    FOREIGN KEY (`ciudad_idciudad`)
    REFERENCES `glovo`.`ciudad` (`idciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`tipoNegocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`tipoNegocio` (
  `idtipoNegocio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipoNegocio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`establecimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`establecimientos` (
  `idestablecimientos` INT NOT NULL AUTO_INCREMENT,
  `imagen` LONGBLOB NOT NULL,
  `codigoPostal` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `tipoNegocio_idtipoNegocio` INT NOT NULL,
  `ciudad_idciudad` INT NOT NULL,
  PRIMARY KEY (`idestablecimientos`),
  INDEX `fk_establecimientos_tipoNegocio1_idx` (`tipoNegocio_idtipoNegocio` ASC) VISIBLE,
  INDEX `fk_establecimientos_ciudad1_idx` (`ciudad_idciudad` ASC) VISIBLE,
  CONSTRAINT `fk_establecimientos_tipoNegocio1`
    FOREIGN KEY (`tipoNegocio_idtipoNegocio`)
    REFERENCES `glovo`.`tipoNegocio` (`idtipoNegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_establecimientos_ciudad1`
    FOREIGN KEY (`ciudad_idciudad`)
    REFERENCES `glovo`.`ciudad` (`idciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`producto` (
  `idcontenido` INT NOT NULL AUTO_INCREMENT,
  `imagen` LONGBLOB NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(8,2) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  `establecimientos_idestablecimientos` INT NOT NULL,
  PRIMARY KEY (`idcontenido`),
  INDEX `fk_producto_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_producto_establecimientos1_idx` (`establecimientos_idestablecimientos` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `glovo`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_establecimientos1`
    FOREIGN KEY (`establecimientos_idestablecimientos`)
    REFERENCES `glovo`.`establecimientos` (`idestablecimientos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`entrega` (
  `identrega` INT NOT NULL AUTO_INCREMENT,
  `codigoUnicoEntrega` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `tiempo` TIME NOT NULL,
  `entregado` BIT NOT NULL,
  `repartidor_idrepartidor` INT NOT NULL,
  PRIMARY KEY (`identrega`),
  INDEX `fk_entrega_repartidor1_idx` (`repartidor_idrepartidor` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_repartidor1`
    FOREIGN KEY (`repartidor_idrepartidor`)
    REFERENCES `glovo`.`repartidor` (`idrepartidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`detalle_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`detalle_entrega` (
  `iddetalle_entrega` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio` DECIMAL(8,2) NOT NULL,
  `entrega_identrega` INT NOT NULL,
  `producto_idcontenido` INT NOT NULL,
  PRIMARY KEY (`iddetalle_entrega`),
  INDEX `fk_detalle_entrega_producto1_idx` (`producto_idcontenido` ASC) VISIBLE,
  INDEX `fk_detalle_entrega_entrega1_idx` (`entrega_identrega` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_entrega_producto1`
    FOREIGN KEY (`producto_idcontenido`)
    REFERENCES `glovo`.`producto` (`idcontenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_entrega_entrega1`
    FOREIGN KEY (`entrega_identrega`)
    REFERENCES `glovo`.`entrega` (`identrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`modo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`modo_pago` (
  `idmodo_pago` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `otros_detalles` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmodo_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `glovo`.`transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glovo`.`transaccion` (
  `idtransaccion` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `total` DECIMAL(8,2) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `modo_pago_idmodo_pago` INT NOT NULL,
  `entrega_identrega` INT NOT NULL,
  PRIMARY KEY (`idtransaccion`),
  INDEX `fk_transaccion_modo_pago1_idx` (`modo_pago_idmodo_pago` ASC) VISIBLE,
  INDEX `fk_transaccion_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_transaccion_entrega1_idx` (`entrega_identrega` ASC) VISIBLE,
  CONSTRAINT `fk_transaccion_modo_pago1`
    FOREIGN KEY (`modo_pago_idmodo_pago`)
    REFERENCES `glovo`.`modo_pago` (`idmodo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaccion_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `glovo`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaccion_entrega1`
    FOREIGN KEY (`entrega_identrega`)
    REFERENCES `glovo`.`entrega` (`identrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
