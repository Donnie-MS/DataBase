CREATE TABLE Warehouse(
	`Number` INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL,
    PersonInCharge VARCHAR(20) NOT NULL
);

CREATE TABLE Article(
	ArticleID INT PRIMARY KEY AUTO_INCREMENT,
    `Description` VARCHAR(20) NOT NULL,
    Price DOUBLE NOT NULL
);

CREATE TABLE Material(
	MaterialID INT PRIMARY KEY AUTO_INCREMENT,
    `Description` VARCHAR(20) NOT NULL
);

CREATE TABLE Supplier(
	SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL,
    address VARCHAR(40) NOT NULL,
    CityID_FK INT NOT NULL,
    FOREIGN KEY (CityID_FK) REFERENCES City(CityID)
);

CREATE TABLE City (
	CityID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL
);

CREATE TABLE Contains (
	ContainsID INT PRIMARY KEY AUTO_INCREMENT,
    Number_FK INT NOT NULL,
    ArticleID_FK INT NOT NULL,
    FOREIGN KEY (Number_FK) REFERENCES Warehouse(`Number`),
    FOREIGN KEY (ArticleID_FK) REFERENCES Article(ArticleID)
);

CREATE TABLE ComposedOf(
	CompositionID INT PRIMARY KEY AUTO_INCREMENT,
    ArticleID_FK INT NOT NULL,
    MaterialID_FK INT NOT NULL, 
    FOREIGN KEY (ArticleID_FK) REFERENCES Article(ArticleID),
    FOREIGN KEY (MaterialID_FK) REFERENCES Material(MaterialID)
);

CREATE TABLE ProvidedBy(
	ProvidedID INT PRIMARY KEY AUTO_INCREMENT,
    MaterialID_FK INT NOT NULL,
    SupplierID_FK INT NOT NULL,
    FOREIGN KEY (SupplierID_FK) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (MaterialID_FK) REFERENCES Material(MaterialID)
);

#I insert data

INSERT INTO Warehouse(`Name`, PersonInCharge)
VALUES ("La original", "Alfredo"),
('Galpon', 'Esteban'),
('Almacen de Don Juan', 'Juan'),
('La tiendita', 'Roberto');

INSERT INTO Article (`Description`, Price)
VALUES ('Bread', 130.70),
('Pastries', 300.00),
('Cheese Cake', 450.74),
('Pasta Frola', 278.50);

INSERT INTO Material (`Description`)
VALUES ('Oil'),
('Fluor'),
('yeast'),
('EGG'),
('Sugar'),
('Salt'),
('Water');

INSERT INTO City(`Name`) 
VALUES ('La plata'),
('Capital federal'),
('Ramos Mejia'),
('La Matanza');

INSERT INTO Supplier (`Name`, Address, CityID_FK)
VALUES ('Arcor', 'Ayacucho 1234', 1),
('Molinos', 'Yatay 465', 4),
('Ledesma', 'Mario BRAVO 987', 1),
('Marolio', 'Potosi 098', 2),
('Glaciar', 'Sarmiento 555', 3),
('Johnson', 'Potosi 123', 1);

