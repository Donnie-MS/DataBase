CREATE DATABASE IF NOT EXISTS Students;

/*DROP DATABASE IF EXISTS Students;*/

USE Students;

CREATE TABLE Award (
	awardId INT, 
    award CHAR(40)
);

CREATE TABLE PersonInCharge (
    personInChargeId INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100),
    DNI INT,
    EDAD INT DEFAULT 18
);

SELECT * FROM Award;
SELECT * FROM PersonInCharge;

CREATE TABLE LineaEstrategica (
	LineaEstrategicaId INT,
    LineaEstrategica CHAR(40)
);

DROP TABLE LineaEstrategica;

ALTER TABLE PersonInCharge CHANGE `name` fullName VARCHAR(100) NOT NULL;
ALTER TABLE PersonIncharge ADD COLUMN address VARCHAR(100) NOT NULL;

CREATE TABLE Person(personId INT, typeOfDocument CHAR(03) PRIMARY KEY, DNI INT, `name` VARCHAR(100), EDAD INT DEFAULT(18));

INSERT INTO Award(awardId, award) VALUES (1, 'Ganador 2');
INSERT INTO Award (awardId) VALUES (1);
INSERT INTO Award (awardId, award) VALUES (2, "");
INSERT INTO Award (awardId, award) VALUES (3, "Premio Oscar");

SELECT * FROM Award WHERE award IS NULL;

ALTER TABLE Award CHANGE award award VARCHAR(40) NOT NULL;
/*DELETE FROM award WHERE award IS NULL AND award_id > 0;*/

DELETE FROM award WHERE award IS NULL;

INSERT INTO Award (awardId, award) VALUES (1, "oscar1"), (1, "oscar2"), (1, "oscar 8") ;

SELECT * FROM Award WHERE Award = "";

UPDATE Award SET award = "ganadorx" WHERE  award = "";