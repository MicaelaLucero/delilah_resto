-- MySQL Script generated by MySQL Workbench
-- Thu Apr 16 16:53:37 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema delilah
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `delilah` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `delilah` ;

-- -----------------------------------------------------
-- Table `delilah`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`role` ;

CREATE TABLE IF NOT EXISTS `delilah`.`role` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`province` ;

CREATE TABLE IF NOT EXISTS `delilah`.`province` (
  `id_province` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id_province`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`city` ;

CREATE TABLE IF NOT EXISTS `delilah`.`city` (
  `id_city` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `id_province` INT NOT NULL,
  PRIMARY KEY (`id_city`),
  INDEX `fk_id_province_city_idx` (`id_province` ASC) ,
  CONSTRAINT `fk_id_province_city`
    FOREIGN KEY (`id_province`)
    REFERENCES `delilah`.`province` (`id_province`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`user` ;

CREATE TABLE IF NOT EXISTS `delilah`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `token` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `last_name` VARCHAR(60) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `id_role` INT NOT NULL,
  `id_city` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `id_role_idx` (`id_role` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_id_city_user_idx` (`id_city` ASC) ,
  CONSTRAINT `fk_id_role_user`
    FOREIGN KEY (`id_role`)
    REFERENCES `delilah`.`role` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_city_user`
    FOREIGN KEY (`id_city`)
    REFERENCES `delilah`.`city` (`id_city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`product` ;

CREATE TABLE IF NOT EXISTS `delilah`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`id_product`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`payment` ;

CREATE TABLE IF NOT EXISTS `delilah`.`payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_payment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`order_state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`order_state` ;

CREATE TABLE IF NOT EXISTS `delilah`.`order_state` (
  `id_state` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_state`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`orders` ;

CREATE TABLE IF NOT EXISTS `delilah`.`orders` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_payment` INT NOT NULL,
  `time` DATETIME NULL default current_timestamp,
  `id_state` INT NOT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `id_user_idx` (`id_user` ASC) ,
  INDEX `id_payment_idx` (`id_payment` ASC) ,
  INDEX `id_state_idx` (`id_state` ASC) ,
  CONSTRAINT `fk_id_user_order`
    FOREIGN KEY (`id_user`)
    REFERENCES `delilah`.`User` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_payment_order`
    FOREIGN KEY (`id_payment`)
    REFERENCES `delilah`.`payment` (`id_payment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_state_order`
    FOREIGN KEY (`id_state`)
    REFERENCES `delilah`.`order_state` (`id_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `delilah`.`order_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`order_detail` ;

CREATE TABLE IF NOT EXISTS `delilah`.`order_detail` (
  `id_order_detail` INT NOT NULL AUTO_INCREMENT,
  `id_product` INT NOT NULL,
  `quantity` INT NOT NULL,
  `subtotal` FLOAT NOT NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_order_detail`),
  INDEX `id_order_idx` (`id_order` ASC) ,
  INDEX `fk_id_product_detail_idx` (`id_product` ASC) ,
  CONSTRAINT `fk_id_product_detail`
    FOREIGN KEY (`id_product`)
    REFERENCES `delilah`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_order_detail`
    FOREIGN KEY (`id_order`)
    REFERENCES `delilah`.`orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `delilah`.`favorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delilah`.`favorite` ;

CREATE TABLE IF NOT EXISTS `delilah`.`favorite` (
  `id_favorite` INT NOT NULL AUTO_INCREMENT,
  `id_product` INT NOT NULL,
  `id_user` INT NOT NULL,
  INDEX `id_product_idx` (`id_product` ASC) ,
  INDEX `id_user_idx` (`id_user` ASC) ,
  PRIMARY KEY (`id_favorite`),
  CONSTRAINT `fk_id_product_favorite`
    FOREIGN KEY (`id_product`)
    REFERENCES `delilah`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_user_favorite`
    FOREIGN KEY (`id_user`)
    REFERENCES `delilah`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `delilah`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`role` (`id_role`, `description`) VALUES (1, 'administrador');
INSERT INTO `delilah`.`role` (`id_role`, `description`) VALUES (2, 'usuario');

COMMIT;
-- -----------------------------------------------------
-- Data for table `delilah`.`province`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`province` (`description`) VALUES ('Córdoba');
INSERT INTO `delilah`.`province` (`description`) VALUES ('Santa Fe');
INSERT INTO `delilah`.`province` (`description`) VALUES ('Buenos Aires');
INSERT INTO `delilah`.`province` (`description`) VALUES ('La Pampa');
COMMIT;
-- -----------------------------------------------------
-- Data for table `delilah`.`city`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`city` (`description`, `id_province`) VALUES ('Capital',1);
INSERT INTO `delilah`.`city` (`description`, `id_province`) VALUES ('Rosario',2);
INSERT INTO `delilah`.`city` (`description`, `id_province`) VALUES ('Ciudad Autónoma de Buenos Aires',3);
INSERT INTO `delilah`.`city` (`description`, `id_province`) VALUES ('Santa Rosa',4);
COMMIT;

-- -----------------------------------------------------
-- Data for table `delilah`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`user` (`id_user`, `username`,`email`,`token`,`password`, `name`, `last_name`, `address`, `phone`, `id_role`, `id_city`) VALUES (1, 'Agustina', 'agus@gmail.com', null, '123456', 'Agustina', 'Lucero', '25 de Mayo 1590', '3513245456', 1, 1);
INSERT INTO `delilah`.`user` (`id_user`, `username`,`email`,`token`,`password`, `name`, `last_name`, `address`, `phone`, `id_role`, `id_city`) VALUES (2, 'Leonardo', 'leo@gmail.com', null, '123456','Leonardo', 'Tulian', 'Colón 456', '1154354365', 2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `delilah`.`product`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`product` (`id_product`, `description`, `price`) VALUES (1, 'Bagel de salmón', 425);
INSERT INTO `delilah`.`product` (`id_product`, `description`, `price`) VALUES (2, 'Hamburguesa clásica', 350);
INSERT INTO `delilah`.`product` (`id_product`, `description`, `price`) VALUES (3, 'Sandwich veggie', 310);

COMMIT;


-- -----------------------------------------------------
-- Data for table `delilah`.`payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`payment` (`id_payment`, `description`) VALUES (1, 'efectivo');
INSERT INTO `delilah`.`payment` (`id_payment`, `description`) VALUES (2, 'tarjeta de débito');
INSERT INTO `delilah`.`payment` (`id_payment`, `description`) VALUES (3, 'tarjeta de crédito');

COMMIT;


-- -----------------------------------------------------
-- Data for table `delilah`.`order_state`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`order_state` (`id_state`, `description`) VALUES (1, 'nuevo');
INSERT INTO `delilah`.`order_state` (`id_state`, `description`) VALUES (2, 'confirmado');
INSERT INTO `delilah`.`order_state` (`id_state`, `description`) VALUES (3, 'preparando');
INSERT INTO `delilah`.`order_state` (`id_state`, `description`) VALUES (4, 'enviando');
INSERT INTO `delilah`.`order_state` (`id_state`, `description`) VALUES (5, 'entregado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `delilah`.`favorite`
-- -----------------------------------------------------
START TRANSACTION;
USE `delilah`;
INSERT INTO `delilah`.`favorite` (`id_favorite`, `id_product`, `id_user`) VALUES (1, 3, 2);

COMMIT;

