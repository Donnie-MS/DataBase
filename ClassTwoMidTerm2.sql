CREATE TABLE IF NOT EXISTS Employee(
	`number` INT PRIMARY KEY,
    `name` VARCHAR(20) NOT NULL,
    salary INT NOT NULL,
    dateOfEntry DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Area(
	cod_area VARCHAR(5) PRIMARY KEY,
    `description` VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Specialization(
	cod_Spe INT PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(20)
);

SELECT `name`, `number` FROM Employee;
