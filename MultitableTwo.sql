USE multitabletwo;

CREATE TABLE Supplier(
	supplierID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    cuit VARCHAR(11) NOT NULL,
    ciudad VARCHAR(30) NOT NULL
);
CREATE TABLE Product(
	productID INT PRIMARY KEY AUTO_INCREMENT,
    `description` VARCHAR(30) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    supplierID_FK INT NOT NULL,
    FOREIGN KEY (supplierID_FK) REFERENCES Supplier(supplierID)
);

CREATE TABLE Client(
	clientID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE Seller(
	sellerID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    dni INT(15) NOT NULl,
    ciudad VARCHAR(20)
);

CREATE TABLE SALE(
	invoiceNumber INT PRIMARY KEY AUTO_INCREMENT,
	clientID_FK INT NOT NULL,
    `date` DATE NOT NULL,
    sellerID_FK INT NOT NULL,
    FOREIGN KEY (sellerID_FK) REFERENCES Seller(sellerID),
    FOREIGN KEY (clientID_FK) REFERENCES Client(clientID)
);