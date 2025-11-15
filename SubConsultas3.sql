USE subConsultas3;
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
CREATE TABLE City (
	CityID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL
);

CREATE TABLE Supplier(
	SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(20) NOT NULL,
    address VARCHAR(40) NOT NULL,
    CityID_FK INT NOT NULL,
    FOREIGN KEY (CityID_FK) REFERENCES City(CityID)
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

INSERT INTO Contains(Number_FK, ArticleID_FK)
VALUES (001, 001),
(001, 002),
(001, 003),
(001, 004),
(002, 003),
(002, 004),
(003, 001),
(004, 002);

INSERT INTO ComposedOf (ArticleID_FK, MaterialID_FK)
VALUES (001, 001),
(001, 002),
(001, 003),
(002, 002),
(002, 005),
(002, 007),
(003, 001),
(003, 002),
(003, 006),
(004, 007);

INSERT INTO ProvidedBy(MaterialID_FK, SupplierID_FK)
VALUES (001, 1),
(002, 3),
(003, 5),
(004, 4),
(005, 2),
(006, 2),
(007, 5),
(005, 5);

SELECT * FROM Supplier;
SELECT S.Name FROM Supplier AS S
WHERE NOT EXISTS (SELECT 1 
FROM ProvidedBy AS P
WHERE P.SupplierID_FK = S.SupplierID
);
/* No funcioan si hay un null
SELECT Name FROM Supplier 
WHERE SupplierID NOT IN (
	SELECT SupplierID_FK FROM ProvidedBy
);
*/
/*
SELECT S.Name FROM Supplier AS S
LEFT JOIN ProvidedBy AS P ON S.SupplierID = P.SupplierID_FK
WHERE P.SupplierID_FK IS NULL;
*/

/*
#1) Listar los nombres de aquellos proveedores que no proveen
ningún material.
*/
SELECT S.Name FROM Supplier S
WHERE NOT EXISTS(
	SELECT 1 FROM ProvidedBy P
    WHERE S.SupplierID = P.SupplierID_FK
);

SELECT S.Name FROM Supplier S
WHERE S.SupplierID NOT IN (
	SELECT P.SupplierID_FK FROM ProvidedBy P
);
/*
#2) Listar los códigos y descripción de los materiales que provea
el proveedor 2 y no los provea el proveedor 5
*/
SELECT M.MaterialID, M.Description FROM Material M
JOIN ProvidedBy P ON M.MaterialID = P.MaterialID_FK
WHERE P.SupplierID_FK = 2 AND M.MaterialID NOT IN(
	SELECT P.MaterialID_FK FROM ProvidedBy P
    WHERE P.SupplierID_FK = 5
);

SELECT M.MaterialID, M.Description FROM Material M
JOIN ProvidedBy P ON M.MaterialID = P.MaterialID_FK
WHERE P.SupplierID_FK = 2 AND NOT EXISTS(
	SELECT 1 
    FROM ProvidedBy P
    WHERE P.MaterialID_Fk = M.MaterialID
    AND P.SupplierID_FK = 5
    /*se INICIALIZA OTRO PROVIDED PARA QUE NO MODIFIQUES EL DE AFUERAr*/
);

/*
#3) Listar número y nombre de almacenes que contienen los
artículos de descripción ‘Pan’ y los de descripción ‘Facturas’
(ambos)
*/

SELECT W.Number, W.Name FROM Warehouse W
WHERE EXISTS (
	SELECT 1 FROM Contains C
    WHERE W.Number = C.Number_FK AND
    EXISTS (
		SELECT 1 FROM Article A
        WHERE A.ArticleID = C.ArticleID_FK
        AND A.Description LIKE 'Bread'
    )
)
AND EXISTS(
	SELECT 1 FROM Contains C
    WHERE W.Number = C.Number_FK AND
    EXISTS (
		SELECT 1 FROM Article A
        WHERE A.ArticleID = C.ArticleID_FK
        AND A.Description LIKE 'Pastries'
    )
);

SELECT W.Number, W.Name FROM Warehouse W
WHERE W.Number IN (
	SELECT C.Number_FK FROM Contains C
    JOIN Article A ON A.ArticleID = C.ArticleID_FK
    WHERE A.Description LIKE 'Bread'
)
AND W.Number IN (
	SELECT C.Number_FK FROM Contains C
    JOIN Article A ON A.ArticleID = C.ArticleID_FK
    WHERE A.Description LIKE 'Pastries'
);
/*
#4) Listar la descripción de artículos compuestos por todos los
materiales
*/

/*
#5) Hallar los códigos y nombres de los proveedores que proveen
al menos un material que se usa en algún artículo cuyo precio es
mayor a $300
*/

/*
#6) Listar la descripción de los artículos de mayor precio
*/
/*
CONSULTAS 
#1) Listar nombre de todos los proveedores y de su ciudad  
*/

SELECT S.Name, C.Name FROM Supplier S
JOIN City C ON S.CityID_FK = C.CityID;

SELECT S.Name, C.Name From Supplier S, City C
WHERE S.CityID_FK = C.CityID;

/*
#2)Listar los nombres de los proveedores de la ciudad de La Plata  
*/
SELECT S.Name 
FROM Supplier S 
JOIN City C ON S.CityID_FK = C.CityID
WHERE C.Name LIKE '%La Plata%';

SELECT S.Name FROM Supplier S, City C
WHERE S.CityID_FK = C.CityID AND C.Name LIKE '%La Plata%';

SELECT S.Name FROM Supplier S
WHERE EXISTS (
	SELECT 1 FROM City C
    WHERE C.CityID = S.CityID_FK
    AND C.Name LIKE '%La plata%'
);

SELECT S.Name 
FROM Supplier S
WHERE S.CityID_FK IN (
	SELECT C.CityID FROM City C
    WHERE C.Name LIKE '%La Plata%'
);
/*
#3) Listar los números de almacenes que almacenan el artículo de 
descripción que empiece con P 
*/

SELECT C.Number_FK FROM Contains C
JOIN Article A ON A.ArticleID = C.ArticleID_FK
WHERE A.Description LIKE 'P%';

SELECT C.Number_FK FROM Contains C, Article A
WHERE A.ArticleID = C.ArticleID_FK AND A.Description LIKE 'P%';

SELECT C.Number_FK FROM Contains C
WHERE EXISTS(
	SELECT 1 FROM Article A
	WHERE A.ArticleID = C.ArticleID_FK
    AND A.Description LIKE 'P%'
);

SELECT C.Number_FK FROM Contains C
WHERE C.ArticleID_Fk IN (
	SELECT A.ArticleID FROM Article A
    WHERE A.Description LIKE 'P%'
);

/*
#4) Listar los números de almacenes y su responsable que almacenan el 
artículo de descripción que empiece con P 
*/

SELECT W.Number, W.PersonInCharge FROM Warehouse W
JOIN Contains C ON W.Number = C.Number_FK
JOIN Article A ON C.ArticleID_FK = A.ArticleID
WHERE A.Description LIKE 'P%';

SELECT W.Number, W.PersonInCharge FROM Warehouse W
WHERE EXISTS(
	SELECT 1 FROM Contains C
    WHERE W.Number = C.Number_FK
    AND EXISTS (
		SELECT 1 FROM Article A 
        WHERE A.ArticleID = C.ArticleID_FK
        AND A.Description LIKE 'P%'
    )
) ;

SELECT W.Number, W.PersonInCharge FROM Warehouse W
WHERE W.Number IN (
	SELECT C.Number_Fk FROM Contains C
    WHERE C.ArticleID_FK IN(
		SELECT A.ArticleID FROM Article A
        WHERE A.Description LIKE 'P%'
    )
);
/*
#5) Listar los materiales (código y descripción) provistos por proveedores 
de la ciudad de Ramos Mejía 
*/

SELECT M.MaterialID, M.Description 
FROM Material M 
JOIN ProvidedBy P ON M.MaterialID = P.MaterialID_FK
JOIN Supplier S ON P.SupplierID_FK = S.SupplierID
JOIN City C ON S.CityID_FK = C.CityID
WHERE C.Name LIKE '%ramos mejia%';

SELECT  M.MaterialID, M.Description 
FROM Material M
WHERE EXISTS(
	SELECT 1 FROM ProvidedBy P
    WHERE P.MaterialID_FK = M.MaterialID
    AND
    EXISTS(
		SELECT 1 FROM Supplier S
        WHERE S.SupplierID = P.SupplierID_FK
        AND
        EXISTS (
			SELECT 1 FROM City C
            WHERE C.CityID = S.CityID_FK
            AND C.Name LIKE '%ramos mejia%'
        )
    )
);

SELECT M.MaterialID, M.Description FROM Material M
WHERE M.MaterialID IN ( 
	SELECT P.MaterialID_FK FROM ProvidedBy P
    WHERE P.SupplierID_FK IN (
		SELECT S.SupplierID FROM Supplier S
        WHERE S.CityID_FK IN (
			SELECT C.CityID FROM City C
            WHERE C.Name LIKE '%Ramos mejia%'
        )
    )
);
/*
#6) Listar los nombres de los proveedores que proveen materiales para 
artículos ubicados en almacenes que Roberto tiene a su cargo
*/

SELECT S.Name 
FROM Supplier S 
JOIN ProvidedBy P ON S.SupplierID = P.SupplierID_FK
JOIN ComposedOf Com ON P.MaterialID_FK = Com.MaterialID_FK
JOIN Contains C ON C.ArticleID_FK = Com.ArticleID_FK
JOIN Warehouse W ON W.Number = C.Number_FK
WHERE W.PersonInCharge LIKE '%Roberto%';



SELECT S.Name FROM Supplier S
WHERE EXISTS(
	SELECT 1 FROM ProvidedBy P
    WHERE S.SupplierID = P.SupplierID_FK
    AND EXISTS(
		SELECT 1 FROM ComposedOf Com
        WHERE Com.MaterialID_FK = P.MaterialID_FK
        AND EXISTS (
			SELECT 1 FROM Contains C
            WHERE C.ArticleID_FK  = Com.ArticleID_FK
            AND EXISTS (
				SELECT 1 FROM Warehouse W
                WHERE W.Number = C.Number_FK
                AND W.PersonInCharge LIKE '%rOBERTO%'
            )
        )
    )
);

SELECT DISTINCT S.Name From Supplier S
WHERE S.SupplierID IN (
	SELECT P.SupplierID_FK FROM ProvidedBy P
    WHERE P.MaterialID_FK IN(
		SELECT Com.MaterialID_FK FROM ComposedOf Com
        WHERE Com.ArticleID_FK IN (
			SELECT C.ArticleID_FK FROM Contains C
            WHERE C.Number_FK IN (
				SELECT W.Number FROM Warehouse W
                WHERE W.PersonInCharge LIKE '%ROBERto%'
            )
        )
    )
);