USE multiTableOne;

CREATE TABLE Warehouse(
	`number` INT PRIMARY KEY AUTO_INCREMENT,
    personInCharge VARCHAR(20) NOT NULL
);

CREATE TABLE Article(
	articleID INT PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(30) NOT NULL,
    price INT NOT NULL
);

CREATE TABLE Material(
	materialID INT PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(30) NOT NULL
);
CREATE TABLE City (
    cityID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE Supplier (
    supplierID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    cityID_FK INT NOT NULL,
    FOREIGN KEY (cityID_FK) REFERENCES City(cityID)
);

CREATE TABLE Contain (
	containID INT PRIMARY KEY AUTO_INCREMENT,
    number_FK INT NOT NULL,
    FOREIGN KEY (number_FK) REFERENCES Warehouse(`number`),
    articleID_FK INT NOT NULL,
    FOREIGN KEY (articleID_FK) REFERENCES Article(articleID)
);

CREATE TABLE ComposedOf (
	compositionID INT PRIMARY KEY AUTO_INCREMENT,
    articleID_FK INT NOT NULL,
    FOREIGN KEY (articleID_FK) REFERENCES Article(articleID),
    materialID_FK INT NOT NULL,
    FOREIGN KEY (materialID_FK) REFERENCES Material(materialID)
);

CREATE TABLE ProvidedBy (
	providedID INT PRIMARY KEY AUTO_INCREMENT,
    materialID_FK INT NOT NULL,
    FOREIGN KEY (materialID_FK) REFERENCES Material(materialID),
    supplierID_FK INT NOT NULL,
    FOREIGN KEY (supplierID_FK) REFERENCES Supplier(supplierID)
);

DROP TABLE Warehouse;
DROP TABLE ProvidedBy;
DROP TABLE ComposedOf;
DROP TABLE Contain;
DROP TABLE Supplier;
DROP TABLE Material;
DROP TABLE City;
DROP TABLE Article;

/*INSERTAR DATOS*/
SELECT * FROM Warehouse;
SELECT * FROM Article;
SELECT * FROM Contain;

INSERT INTO Warehouse (personInCharge)
VALUES ('Alfredo'), ('Esteban'), ('Juan'), ('Roberto');

INSERT INTO Article (`description`, price) 
VALUES  ("Bread", 130.70), ("Pastries", 300.00), ("Chesse cake", 450.87), ("Pasta Frola", 278.90);

INSERT INTO Material (`description`)
VALUES ("Oil"), ("Flour"), ("Yeast"), ("egg"), ("sugar"), ("salt"), ("water");

INSERT INTO City(`name`)
VALUES ("La plata"), ("Capital FEDERAL"), ("Ramos Mejia"), ("La matanza");

INSERT INTO Supplier(`name`, address, cityID_FK) 
VALUES ("Arcor", "Ayacucho 1234", 1),
 ("Molinos", "Yatay 456", 4),
 ("Ledesma", "Mario Bravo 987", 1),
 ("Marolio", "Potosi 098", 2),
 ("Glaciar", "Sarmiento 555", 3);

INSERT INTO Contain(number_FK, articleID_FK) 
VALUES (1, 1), (1, 2), (1,3), (1,4),
(2, 3), (2, 4),
(3, 1), (4, 2);

INSERT INTO ComposedOf(articleID_FK, materialID_FK)
VALUES (1, 2), (1, 3),
(2, 2), (2, 5), (2, 7), 
(3, 1), (3, 2), (3, 6),
(4, 7);

INSERT INTO ProvidedBy(materialID_FK, supplierID_FK)
VALUES (2, 3), (3, 5), (4, 4), (5, 2), (6, 2), (7,5);

SELECT s.`name` AS Supplier, c.`name` AS City FROM Supplier s
JOIN City c ON c.cityID = s.cityID_FK;
/*
FROM City c
JOIN Supplier s ON s.cityID_FK = c.cityID;
*/