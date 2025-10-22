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