CREATE DATABASE IF NOT EXISTS Students;

DROP DATABASE IF EXISTS Students;

USE Students;

CREATE TABLE Award (
	awardId INT, 
    award CHAR(40));

CREATE TABLE PersonInCharge (
    personInChargeId INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100),
    DNI INT,
    EDAD INT DEFAULT 18
);

SELECT * FROM Award;
SELECT * FROM PersonInCharge

CREATE TABLE LineaEstrategica (
	LineaEstrategicaId INT,
    LineaEstrategica CHAR(40)
);

DROP TABLE LineaEstrategica;

ALTER TABLE PersonInCharge CHANGE `name` fullName VARCHAR(100) NOT NULL;
ALTER TABLE PersonIncharge ADD COLUMN address VARCHAR(100) NOT NULL;

CREATE TABLE Person(personId INT, typeOfDocument CHAR(03) PRIMARY KEY, DNI INT, `name` VARCHAR(100), EDAD INT DEFAULT(18));
