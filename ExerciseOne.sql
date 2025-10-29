CREATE DATABASE IF NOT EXISTS ejercicio1;
USE ejercicio1;
CREATE TABLE Patient(
	patientID INT PRIMARY KEY AUTO_INCREMENT, 
    surName VARCHAR(50) NOT NULL,
	firstName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL, 
    sex ENUM("F", "M") NOT NULL,
	weight DECIMAL(5, 2) NOT NULL,
    height DECIMAL(5, 2) NOT NULL,
    vaccinated ENUM("Y", "N") NOT NULL
);
ALTER TABLE Patient MODIFY COLUMN height DECIMAL(5, 2);
SELECT * FROM  Patient;

INSERT INTO Patient(surName, firstName, DOB, sex, weight, height, vaccinated)
VALUES 
	('Smith', 'Deniz', '2018-12-31', "F", 21.40, 29.20, 'Y'),
	("Agarwal", "Arjun", "2017-08-29", "M", 28.10, 34.20, "Y"),
    ("Adams", "Poppy", "2015-02-14", "F", 34.00, 39.20, "N"),
    ("Johson", "Tierra", "2019-08-15", "F", 14.60, 24.50, "Y"),
    ("Khouri", "Mohammed", "2014-03-30", "M", 41.50,  44.1, "Y"),
    ("JONES", "Ben", "2011-04-04", "M", 70.10, 52.20, "Y"),
    ("Kowalcykz", "Alexandra", "2019-08-27", "F", 15.20, 23.90, "Y");
    
UPDATE Patient SET vaccinated = "Y"
WHERE sex = "F" AND DOB BETWEEN "2015-01-01" AND "2019-12-31";

UPDATE Patient SET sex = "M"
WHERE patientID IN (1,3,7);

UPDATE Patient SET weight = weight + 2
WHERE height > 39.00;

DELETE FROM Patient
WHERE firstName LIKE '%am%';

DELETE FROM Patient
WHERE sex = "M" AND vaccinated = "N" AND DOB BETWEEN "2014-01-01" AND "2015-12-31";

TRUNCATE TABLE Patient;
DROP TABLE PATIENT;