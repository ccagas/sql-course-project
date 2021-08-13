
--1. Construct a picture (Entity Relationship Diagram) of your sample database like you did previously. Outline a brief summary of the database, 
--which describes the purpose of your database, and the business rules you followed for your database.
--2. Your database should consist of three to five tables. If in normalization you find you have too many tables you need to decide what data 
--you will not be tracking for now and adjust your rules accordingly. Each table has a primary key and at least three of the tables should have 
--a foreign key. Abide by the relational entity rules. Each primary/foreign key relationship is to have a name. Assign the delete value to each 
--relationship.
--3. Create two indexes other than the primary/foreign key indexes for the database, you should have foreign key indexes as well. 
--Show your create statements, for all the indexes (including the foreign key indexes).
--4. Add a minimum of three rows of data for each table using insert statements. Modify the data with three update or delete statements. 
--Print out a select * from each table which shows the before and after result sets.
--5. Create one views and one stored procedure for the database. Outline the purpose. Show your create statements, and a sample result set, 
--using the view.
--6. Create one stored procedure with transaction error handling. Outline the purpose. Show your create statements, and a sample result set, 
--after the procedure is run.

--Notes:

--Presentation & professionalism will be considered.

--You must provide a script in notepad for your database with all (ALL) SQL statements on it. This is what I will use to recreate your database 
--tables, queries, etc

--USE master;

--GO

--DROP DATABASE IF EXISTS ProjectDemo;

--GO

--CREATE DATABASE ProjectDemo;
--GO

--USE ProjectDemo;
--GO

--CREATE TABLE Customer (
--	CustomerID	int IDENTITY (1,1) NOT NULL,
--	FirstName	nvarchar(50) NOT NULL,
--	LastName 	nvarchar(50) NOT NULL,
--	StreetAddress	nvarchar(100) NULL,
--	City		nvarchar(50) NULL,
--	State		nvarchar(50) NULL,
--	PostalCode	nvarchar(10) NULL,
--	PhoneNumber	nvarchar(50) NULL,
--	Email		nvarchar(50) NULL
--CONSTRAINT PKcustomer PRIMARY KEY (CustomerID)
--);

--GO

--CREATE TABLE Supplier (
--	SupplierID	int IDENTITY (1,1),
--	SuppName	nvarchar(100) NOT NULL,
--	ContactName	nvarchar(100) NULL,
--	StreetAddress	nvarchar(100) NOT NULL,
--	City		nvarchar(50) NOT NULL,
--	State		nvarchar(50) NOT NULL,
--	PostalCode	nvarchar(10) NOT NULL,
--	PhoneNumber	nvarchar(50) NOT NULL,
--	Email		nvarchar(50) NULL
--CONSTRAINT PKsupplier PRIMARY KEY (SupplierID)
--);

--GO

--CREATE TABLE Product (
--	ProductID	int IDENTITY (1,1),
--	ProductName	nvarchar(100) NOT NULL,
--	Category	nvarchar(50),
--	ProdType	nvarchar(50),
--	Description	nvarchar(200),
--	ProductQty	int,
--	Price		money,
--	SupplierID	int NOT NULL
--CONSTRAINT PKproduct PRIMARY KEY (ProductID),
--CONSTRAINT FKsupplier FOREIGN KEY (SupplierID)
--REFERENCES Supplier ON DELETE CASCADE
--);

--GO

--CREATE TABLE SalesOrder (
--	OrderID		int IDENTITY (1,1),
--	OrderDate	date NOT NULL DEFAULT (GETDATE()),
--	OrderQty	int,
--	UnitPrice	money,
--	TotalPrice	AS OrderQty * UnitPrice,
--	ProductID	int NOT NULL,
--	CustomerID	int NOT NULL,
--CONSTRAINT PKsalesorder PRIMARY KEY (OrderID),
--CONSTRAINT FKproduct FOREIGN KEY (ProductID)
--REFERENCES Product ON DELETE CASCADE,
--CONSTRAINT FKcustomer FOREIGN KEY (CustomerID)
--REFERENCES Customer ON DELETE CASCADE
--);

--GO

--CREATE NONCLUSTERED INDEX ix_cust_name
--ON Customer(LastName, FirstName);

--GO

CREATE UNIQUE NONCLUSTERED INDEX ix_prod_name
ON Product (ProductName ASC);

GO

INSERT INTO Customer (FirstName, LastName, StreetAddress, City, State, PostalCode, PhoneNumber, Email)
VALUES 	('Cally', 'Reynolds', '556 Lakewood Park', 'Bismarck', 'North Dakota', 58505, '(901) 166-8355', 'penatibus.et@lectusa.com'),
	('Sydney', 'Bartlett', '4829 Badeau Parkway', 'Chattanooga', 'Tennesee', 37405, '(982) 231-7357', 'nibh@ultricesposuere.edu'),
	('Hunter', 'Newton', '2 Rockefeller Avenue', 'Waco', 'Texas', 76796, '(831) 996-1240', 'quam.quis.diam@facilisisfacilisis.org'),
	('Brooke', 'Perkins', '6371 Crescent Road', 'Dallas', 'Texas', 75358, '(340) 732-9367', 'sit@vitaealiquetnec.net'),
	('Nolan', 'Slater', '87 Brentwood Park', 'Reno', 'Nevada', 89595, '(540) 487-5928', 'sociis@natoque.penatibus@pedeCras.co.uk');

GO

INSERT INTO Supplier (SuppName, ContactName, StreetAddress, City, State, PostalCode, PhoneNumber, Email)
VALUES 	('Edgepulse', 'Gerlad Martinez', '900 Butternut Avenue', 'Albany', 'New York', 12242, '(991) 321-6632', 'gmartinez0@hostgator.com'),
	('Jabbersphere', 'Victor Harrison', '684 Express Avenue', 'Houston', 'Texas', 77070, '(404) 940-2991', 'vharrison1@geocities.com'),
	('Quaxo', 'Jimmy Ford', '7 Sheridan Plaza', 'Lubbock', 'Texas', 79491, '(960) 473-6813', 'jford2@nyu.edu'),
	('Osiris', 'Shanuka Rishi', '518 Agnes Street', 'Metairie', 'Los Angeles', 70033, '(204) 133-4567', 'Srishi@shaw.ca'),
	('Mithra', 'Issha Christi', '467 Pacific Avenue', 'Charlottesville', 'Virginia', 22903, '(416) 571-6168', 'IsshaC@brandon.mb.ca');

GO

INSERT INTO Product (ProductName, Category, ProdType, Description, ProductQty, Price, SupplierID)
VALUES 	('Garlic Shrimp', 'Seafood', 'Crustacean', 'Jumbo butterflied shrimp marinated with savoury garlic and herbs.', 10, 11.59, 1),
	('Bacon Wrapped Chicken', 'Butcher', 'Chicken', 'Portions of boneless, skinless chicken breasts seasoned and wrapped with a slice of bacon. 4 pieces.', 5, 12.59, 2),
	('Beef Wellington', 'Butcher', 'Beef', 'Seasoned filet of beef tenderloin, liver pate, mushroom sauce, and enveloped in a puff pastry.', 20, 8.99, 2),
	('Grilled Carrots', 'Frozen Vegetables', 'Vegetable', 'Grilled carrots seasoned with extra virgin olive oil, garlic, and ginger.', 12, 4.99, 5),
	('Cheesy Garlic Melt Pizza', 'Prepared Meals', 'Pizza', 'Hand-stretched crust topped with garlic spread and three-cheese blend of mozzarella, cheddar and parmesan.', 10, 6.89, 4),
	('Chicken Lasagna', 'Prepared Meals', 'Lasagna', 'Chunks of chicken breast in ricotta cheese, cream, broccoli, onions and carrots.', 15, 12.49, 3);


SELECT *
FROM Product



INSERT INTO SalesOrder (OrderQty, ProductID, CustomerID, UnitPrice)
VALUES	(2, 1, 5 (SELECT Price FROM Product WHERE ProductID = 1)),
		(1, 1, 3 (SELECT Price FROM Product),
		(5, 11.59