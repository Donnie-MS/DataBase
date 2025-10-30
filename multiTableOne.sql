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