-- MySQL Workbench Synchronization
-- Generated: 2018-04-28 19:29
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: jean72human

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `taeXchange` DEFAULT CHARACTER SET utf8 ;



##Creating users table
CREATE TABLE IF NOT EXISTS `taeXchange`.`Users` (
  `user_email` VARCHAR(30) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `phone number` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`user_email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


##Creating cryptocurrency table
CREATE TABLE IF NOT EXISTS `taeXchange`.`Cryptocurrency` (
  `crypto_name` VARCHAR(20) NOT NULL,
  `buying_rate` INT(11) NULL DEFAULT NULL,
  `selling_rate` INT(11) NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`crypto_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


##Create wallet table
CREATE TABLE IF NOT EXISTS `taeXchange`.`wallet` (
  `wallet_id` INT(11) NOT NULL,
  `amount` INT(11) NOT NULL,
  `user_email` VARCHAR(30) NOT NULL,
  `crypto_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`wallet_id`),
  INDEX `user_email_idx` (`user_email` ASC),
  INDEX `crupto_name_idx` (`crypto_name` ASC),
  CONSTRAINT `user_email`
    FOREIGN KEY (`user_email`)
    REFERENCES `taeXchange`.`Users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crupto_name`
    FOREIGN KEY (`crypto_name`)
    REFERENCES `taeXchange`.`Cryptocurrency` (`crypto_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



## Creating Account table
CREATE TABLE IF NOT EXISTS `taeXchange`.`Account` (
  `idAccount` INT(11) NOT NULL,
  `account_type` ENUM('bank', 'mobile-money') NOT NULL,
  `name_of_account` VARCHAR(45) NOT NULL,
  `users_email` VARCHAR(30) NOT NULL,
  `public_account_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAccount`),
  INDEX `users_email_idx` (`users_email` ASC),
  UNIQUE INDEX `account_type_UNIQUE` (`account_type` ASC),
  CONSTRAINT `users_email`
    FOREIGN KEY (`users_email`)
    REFERENCES `taeXchange`.`Users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



## Creating Advert table
CREATE TABLE IF NOT EXISTS `taeXchange`.`advert` (
  `idadvert` INT(11) NOT NULL,
  `user_email` VARCHAR(30) NOT NULL,
  `crypto_name` VARCHAR(20) NOT NULL,
  `rate` INT(11) NULL DEFAULT NULL,
  `type` ENUM('selling', 'buying') NOT NULL,
  `means_payment_id` INT(11) NOT NULL,
  `max_amount` INT(11) NOT NULL,
  `min_amount` INT(11) NOT NULL,
  PRIMARY KEY (`idadvert`),
  INDEX `user_email_idx` (`user_email` ASC),
  INDEX `crypto_name_idx` (`crypto_name` ASC),
  INDEX `means_payment_id_idx` (`means_payment_id` ASC),
  CONSTRAINT `user-email`
    FOREIGN KEY (`user_email`)
    REFERENCES `taeXchange`.`Users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crypto-name`
    FOREIGN KEY (`crypto_name`)
    REFERENCES `taeXchange`.`Cryptocurrency` (`crypto_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `means_payment_id`
    FOREIGN KEY (`means_payment_id`)
    REFERENCES `taeXchange`.`Account` (`idAccount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



##Creating Operation 
CREATE TABLE IF NOT EXISTS `taeXchange`.`Operation` (
  `idOperation` INT(11) NOT NULL,
  `idadvert` INT(11) NOT NULL,
  `respondent_email` VARCHAR(30) NOT NULL,
  `amount` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idOperation`),
  INDEX `responent_email_idx` (`respondent_email` ASC),
  INDEX `idadvert_idx` (`idadvert` ASC),
  CONSTRAINT `responent_email`
    FOREIGN KEY (`respondent_email`)
    REFERENCES `taeXchange`.`Users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idadvert`
    FOREIGN KEY (`idadvert`)
    REFERENCES `taeXchange`.`advert` (`idadvert`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;








-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`UsersWithAdvert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`UsersWithAdvert` (`user_email` INT, `user_name` INT, `phone number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`UsersSelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`UsersSelling` (`user_email` INT, `user_name` INT, `phone number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`UsersBuying`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`UsersBuying` (`user_email` INT, `user_name` INT, `phone number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`cryptoAdvertised`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`cryptoAdvertised` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`cryptoSelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`cryptoSelling` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`cryptoBuying`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`cryptoBuying` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `taeXchange`.`cryptoUsed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taeXchange`.`cryptoUsed` (`id` INT);


USE `taeXchange`;

-- -----------------------------------------------------
-- View `taeXchange`.`UsersWithAdvert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`UsersWithAdvert`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `UsersWithAdvert` AS
SELECT * from Users 
WHERE user_email 
in (SELECT user_email from advert);


-- -----------------------------------------------------
-- View `taeXchange`.`UsersSelling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`UsersSelling`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `UsersSelling` AS
SELECT * FROM users
WHERE user_email IN (SELECT * FROM advert WHERE type='selling');


USE `taeXchange`;

-- -----------------------------------------------------
-- View `taeXchange`.`UsersBuying`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`UsersBuying`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `UsersBuying` AS
SELECT * FROM users
WHERE user_email IN (SELECT * FROM advert WHERE type='buying');



-- -----------------------------------------------------
-- View `taeXchange`.`cryptoAdvertised`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`cryptoAdvertised`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `cryptoAdvertised` AS
SELECT * FROM cryptocurrency
WHERE crypto_name IN (SELECT crypto_name FROM advert);



-- -----------------------------------------------------
-- View `taeXchange`.`cryptoSelling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`cryptoSelling`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `cryptoSelling` AS
SELECT * FROM cryptocurrency
WHERE crypto_name IN (SELECT crypto_name FROM advert WHERE type='selling');



-- -----------------------------------------------------
-- View `taeXchange`.`cryptoBuying`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taexchange`.`cryptoBuying`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `cryptoBuying` AS
SELECT * FROM cryptocurrency
WHERE crypto_name IN (SELECT crypto_name FROM advert WHERE type='buying');



-- -----------------------------------------------------
-- View `taeXchange`.`cryptoUsed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `taeXchange`.`cryptoUsed`;
USE `taeXchange`;
CREATE  OR REPLACE VIEW `cryptoUsed` AS
SELECT * FROM cryptocurrency
WHERE crypto_name IN (SELECT crypto_name FROM wallet);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
