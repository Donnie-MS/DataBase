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

SELECT * FROM  Patient;

INSERT INTO Patient(surName, firstName, DOB, sex, weight, height, vaccinated)
VALUES ('Masgo', 'Joao', '2000-04-15', 'M', 12.74, 51.00, 'Y');

INSERT INTO Patient(surName, firstName, DOB, sex, weight, height, vaccinated)
VALUES ('SMITH', 'DENIZ', '2018-12-31', "F", 21.40, 29.20, 'Y');