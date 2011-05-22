SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `bestof` ;
CREATE SCHEMA IF NOT EXISTS `bestof` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `bestof` ;

-- -----------------------------------------------------
-- Table `bestof`.`venues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`venues` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`venues` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `foursquare_id` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`categories` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`categories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`dishes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`dishes` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`dishes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `category_id` INT UNSIGNED NOT NULL ,
  `name` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_dishes_categories1` (`category_id` ASC) ,
  CONSTRAINT `fk_dishes_categories1`
    FOREIGN KEY (`category_id` )
    REFERENCES `bestof`.`categories` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`users` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `facebook_id` INT NULL ,
  `last_login` DATETIME NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`rankings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`rankings` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`rankings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `user_id` INT UNSIGNED NULL ,
  `dish_id` INT UNSIGNED NULL ,
  `venue_id` INT UNSIGNED NULL ,
  `position` INT NULL ,
  `review` TEXT NULL ,
  `photo_url` VARCHAR(255) NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_rankings_users` (`user_id` ASC) ,
  INDEX `fk_rankings_dishes1` (`dish_id` ASC) ,
  INDEX `fk_rankings_venues1` (`venue_id` ASC) ,
  CONSTRAINT `fk_rankings_users`
    FOREIGN KEY (`user_id` )
    REFERENCES `bestof`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rankings_dishes1`
    FOREIGN KEY (`dish_id` )
    REFERENCES `bestof`.`dishes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rankings_venues1`
    FOREIGN KEY (`venue_id` )
    REFERENCES `bestof`.`venues` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`previous_rankings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`previous_rankings` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`previous_rankings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `user_id` INT UNSIGNED NULL ,
  `dish_id` INT UNSIGNED NULL ,
  `venue_id` INT UNSIGNED NULL ,
  `position` INT NULL ,
  `review` TEXT NULL ,
  `photo_url` VARCHAR(255) NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  `changed_at` DATETIME NULL COMMENT 'when did the position value change?' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_previous_rankings_users1` (`user_id` ASC) ,
  INDEX `fk_previous_rankings_dishes1` (`dish_id` ASC) ,
  INDEX `fk_previous_rankings_venues1` (`venue_id` ASC) ,
  CONSTRAINT `fk_previous_rankings_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `bestof`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_previous_rankings_dishes1`
    FOREIGN KEY (`dish_id` )
    REFERENCES `bestof`.`dishes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_previous_rankings_venues1`
    FOREIGN KEY (`venue_id` )
    REFERENCES `bestof`.`venues` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bestof`.`friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bestof`.`friends` ;

CREATE  TABLE IF NOT EXISTS `bestof`.`friends` (
  `user_id` INT UNSIGNED NOT NULL ,
  `friend_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`user_id`, `friend_id`) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
