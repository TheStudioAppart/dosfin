-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TheStudioAppart
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TheStudioAppart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TheStudioAppart` DEFAULT CHARACTER SET utf8 ;
USE `TheStudioAppart` ;

-- -----------------------------------------------------
-- Table `TheStudioAppart`.`TS_GROUP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`TS_GROUP` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`TS_GROUP` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(45) NOT NULL,
  `Label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `CODE_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_Address` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_Address` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Longitude` DOUBLE NULL,
  `Latitude` DOUBLE NULL,
  `CodePostal` VARCHAR(45) NULL,
  `Rue` VARCHAR(45) NULL,
  `NumRue` VARCHAR(45) NULL,
  `Ville` VARCHAR(45) NULL,
  `Pays` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`TC_USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`TC_USER` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`TC_USER` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Login` VARCHAR(200) NULL,
  `Password` VARCHAR(200) NULL,
  `Has_Access` TINYINT NULL DEFAULT 0,
  `GroupId` INT NULL,
  `AddressId` INT NULL,
  `Nom` VARCHAR(100) NULL,
  `Prenom` VARCHAR(100) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Login_UNIQUE` (`Login` ASC),
  INDEX `groupUser_idx` (`GroupId` ASC),
  INDEX `AddressUser_idx` (`AddressId` ASC),
  CONSTRAINT `groupUser`
    FOREIGN KEY (`GroupId`)
    REFERENCES `TheStudioAppart`.`TS_GROUP` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AddressUser`
    FOREIGN KEY (`AddressId`)
    REFERENCES `TheStudioAppart`.`T_Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`TS_TypeEvent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`TS_TypeEvent` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`TS_TypeEvent` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(45) NOT NULL,
  `Label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`TS_EventStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`TS_EventStatus` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`TS_EventStatus` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(45) NULL,
  `Label` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Code_UNIQUE` (`Code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_CTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_CTT` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_CTT` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(300) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_Event` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_Event` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `DateDebut` DATETIME NOT NULL,
  `DateFin` DATETIME NOT NULL,
  `TypeEventId` INT NULL,
  `IsPublic` TINYINT NOT NULL DEFAULT 0,
  `AddressId` INT NOT NULL,
  `Titre` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(300) NULL,
  `StatusId` INT NOT NULL,
  `CTTId` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `typeEvent_idx` (`TypeEventId` ASC),
  INDEX `statusEvent_idx` (`StatusId` ASC),
  INDEX `addressEvent_idx` (`AddressId` ASC),
  INDEX `CttEvent_idx` (`CTTId` ASC),
  CONSTRAINT `typeEvent`
    FOREIGN KEY (`TypeEventId`)
    REFERENCES `TheStudioAppart`.`TS_TypeEvent` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `statusEvent`
    FOREIGN KEY (`StatusId`)
    REFERENCES `TheStudioAppart`.`TS_EventStatus` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `addressEvent`
    FOREIGN KEY (`AddressId`)
    REFERENCES `TheStudioAppart`.`T_Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CttEvent`
    FOREIGN KEY (`CTTId`)
    REFERENCES `TheStudioAppart`.`T_CTT` (`Id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_UserInvited`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_UserInvited` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_UserInvited` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `EventId` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `eventInvited_idx` (`EventId` ASC),
  INDEX `userInvited_idx` (`UserId` ASC),
  CONSTRAINT `eventInvited`
    FOREIGN KEY (`EventId`)
    REFERENCES `TheStudioAppart`.`T_Event` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `userInvited`
    FOREIGN KEY (`UserId`)
    REFERENCES `TheStudioAppart`.`TC_USER` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_EventParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_EventParticipant` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_EventParticipant` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `EventId` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `eventParticipantevent_idx` (`EventId` ASC),
  INDEX `eventParticipantUser_idx` (`UserId` ASC),
  CONSTRAINT `eventParticipantevent`
    FOREIGN KEY (`EventId`)
    REFERENCES `TheStudioAppart`.`T_Event` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `eventParticipantUser`
    FOREIGN KEY (`UserId`)
    REFERENCES `TheStudioAppart`.`TC_USER` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_CTTParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_CTTParticipant` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_CTTParticipant` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `CTTId` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `eventParticipantUser_idx` (`UserId` ASC),
  INDEX `cttParticipantctt_idx` (`CTTId` ASC),
  CONSTRAINT `cttParticipantctt`
    FOREIGN KEY (`CTTId`)
    REFERENCES `TheStudioAppart`.`T_CTT` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `cttParticipantUse`
    FOREIGN KEY (`UserId`)
    REFERENCES `TheStudioAppart`.`TC_USER` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_ListAchat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_ListAchat` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_ListAchat` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `CttId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `cttList_idx` (`CttId` ASC),
  CONSTRAINT `cttList`
    FOREIGN KEY (`CttId`)
    REFERENCES `TheStudioAppart`.`T_CTT` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_Produit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_Produit` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_Produit` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(45) NOT NULL,
  `Label` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_ListAchatItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_ListAchatItem` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_ListAchatItem` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `ListAchatId` INT NOT NULL,
  `ProduitId` INT NULL,
  `Quantite` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `ListAchat_idx` (`ListAchatId` ASC),
  INDEX `produit_idx` (`ProduitId` ASC),
  CONSTRAINT `ListAchat`
    FOREIGN KEY (`ListAchatId`)
    REFERENCES `TheStudioAppart`.`T_ListAchat` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `produit`
    FOREIGN KEY (`ProduitId`)
    REFERENCES `TheStudioAppart`.`T_Produit` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_Depense`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_Depense` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_Depense` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Montant` DOUBLE NOT NULL,
  `CttId` INT NULL,
  `AchaItemId` INT NULL,
  `ListAchatId` INT NULL,
  `AcheteurId` INT NULL,
  
  PRIMARY KEY (`Id`),
  INDEX `cttdepense_idx` (`CttId` ASC),
  INDEX `listachatitem_idx` (`AchaItemId` ASC),
  INDEX `listachat_idx` (`ListAchatId` ASC),
  INDEX `acheteur_idx` (`AcheteurId` ASC),
  CONSTRAINT `cttdepense`
    FOREIGN KEY (`CttId`)
    REFERENCES `TheStudioAppart`.`T_CTT` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `listachatitem`
    FOREIGN KEY (`AchaItemId`)
    REFERENCES `TheStudioAppart`.`T_ListAchatItem` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `listachatdepense`
    FOREIGN KEY (`ListAchatId`)
    REFERENCES `TheStudioAppart`.`T_ListAchat` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `acheteur`
    FOREIGN KEY (`AcheteurId`)
    REFERENCES `TheStudioAppart`.`T_CTTParticipant` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_DepenseParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_DepenseParticipant` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_DepenseParticipant` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `DepenseId` INT NOT NULL,
  `ParticipantId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `depenseparticipant_idx` (`ParticipantId` ASC),
  INDEX `depensedepense_idx` (`DepenseId` ASC),
  CONSTRAINT `depenseparticipant`
    FOREIGN KEY (`ParticipantId`)
    REFERENCES `TheStudioAppart`.`T_CTTParticipant` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `depensedepense`
    FOREIGN KEY (`DepenseId`)
    REFERENCES `TheStudioAppart`.`T_Depense` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`T_StockItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`T_StockItem` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`T_StockItem` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Quantite` INT NOT NULL,
  `ProduitId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `stockitemproduit_idx` (`ProduitId` ASC),
  CONSTRAINT `stockitemproduit`
    FOREIGN KEY (`ProduitId`)
    REFERENCES `TheStudioAppart`.`T_Produit` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TheStudioAppart`.`TS_Stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TheStudioAppart`.`TS_Stock` ;

CREATE TABLE IF NOT EXISTS `TheStudioAppart`.`TS_Stock` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL,
  `StockId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Stock_idx` (`StockId` ASC),
  CONSTRAINT `Stock`
    FOREIGN KEY (`StockId`)
    REFERENCES `TheStudioAppart`.`TS_Stock` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
