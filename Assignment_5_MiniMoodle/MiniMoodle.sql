CREATE SCHEMA IF NOT EXISTS `MiniMoodle` DEFAULT CHARACTER SET utf8 ;
USE `MiniMoodle` ;

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Course` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(50) NULL,
    `Code` VARCHAR(10) NOT NULL,
    `Password` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`ID`)
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Course_Code_Unique` ON `MiniMoodle`.`Course` (`Code` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Student` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `FName` VARCHAR(50) NULL,
    `LName` VARCHAR(50) NULL,
    `EMail` VARCHAR(100) NULL,
    `Code` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`ID`)
)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Student_Code_Unique` ON `MiniMoodle`.`Student` (`Code` ASC);
CREATE UNIQUE INDEX `Student_Email_Unique` ON `MiniMoodle`.`Student` (`EMail` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Learning` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `EnrolDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `Feedback` VARCHAR(200) NULL,
    `CourseID` INT NOT NULL,
    `StudentID` INT NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_Learning_Course`
		FOREIGN KEY (`CourseID`)
        REFERENCES `MiniMoodle`.`Course` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `FK_Learning_Student`
		FOREIGN KEY (`StudentID`)
        REFERENCES `MiniMoodle`.`Student` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE INDEX `FK_Learning_Course_idx` ON `MiniMoodle`.`Learning` (`CourseID` ASC);
CREATE INDEX `FK_Learning_Student_idx` ON `MiniMoodle`.`Learning` (`StudentID` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Teacher` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `FName` VARCHAR(50) NULL,
    `LName` VARCHAR(50) NULL,
    `EMail` VARCHAR(100) NULL,
    PRIMARY KEY (`ID`)
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Teacher_Email_Unique` ON `MiniMoodle`.`Teacher` (`EMail` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Teaches` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `CourseID` INT NOT NULL,
    `TeacherID` INT NOT NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_Teaches_Course`
		FOREIGN KEY (`CourseID`)
        REFERENCES `MiniMoodle`.`Course` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `FK_Teaches_Teacher`
		FOREIGN KEY (`TeacherID`)
        REFERENCES `MiniMoodle`.`Teacher` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE INDEX `FK_Teaches_Course_idx` ON `MiniMoodle`.`Teaches` (`CourseID` ASC);
CREATE INDEX `FK_Teaches_Teacher_idx` ON `MiniMoodle`.`Teaches` (`TeacherID` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Material` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(50) NULL,
    `Description` VARCHAR(200) NULL,
    `FileURL` VARCHAR(50) NULL,
    `CourseID` INT NOT NULL,
    CONSTRAINT `FK_Material_Course`
		FOREIGN KEY (`CourseID`)
        REFERENCES `MiniMoodle`.`Course` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY (`ID`)
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE INDEX `FK_Material_Course_idx` ON `MiniMoodle`.`Material` (`CourseID` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Assignment` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(50) NULL,
    `Description` VARCHAR(200) NULL,
    `FileURL` VARCHAR(50) NULL,
    `DueDate` TIMESTAMP NOT NULL,
    `CourseID` INT NOT NULL,
    CONSTRAINT `FK_Assignment_Course`
		FOREIGN KEY (`CourseID`)
        REFERENCES `MiniMoodle`.`Course` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    PRIMARY KEY (`ID`)
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE INDEX `FK_Assignment_Course_idx` ON `MiniMoodle`.`Assignment` (`CourseID` ASC);

CREATE TABLE IF NOT EXISTS `MiniMoodle`.`Submission` (
	`ID` INT NOT NULL AUTO_INCREMENT,
    `AssignmentID` INT NOT NULL,
    `StudentID` INT NOT NULL,
    `TimeSubmitted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `Grade` INT NOT NULL DEFAULT 0,
    `FileURL` VARCHAR(50) NULL,
    PRIMARY KEY (`ID`),
    CONSTRAINT `FK_Submission_Assignment`
		FOREIGN KEY (`AssignmentID`)
        REFERENCES `MiniMoodle`.`Assignment` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `FK_Submission_Student`
		FOREIGN KEY (`StudentID`)
        REFERENCES `MiniMoodle`.`Student` (`ID`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
COLLATE='utf8_unicode_ci'
ENGINE = InnoDB;

CREATE INDEX `FK_Submission_Assignment_idx` ON `MiniMoodle`.`Submission` (`AssignmentID` ASC);
CREATE INDEX `FK_Submission_Student_idx` ON `MiniMoodle`.`Submission` (`StudentID` ASC);

