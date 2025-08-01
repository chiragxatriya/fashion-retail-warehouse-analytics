/*
Using VARCHAR datatype for the Dates column because in the source date format is dd-mm-yyyy; Later, it will be coverted as DATE in silver layer
*/

--(1)Creating Table bronze.customers-------------------------------------------------------
IF OBJECT_ID ('bronze.customers' , 'U') IS NOT NULL
DROP TABLE bronze.customers;
CREATE TABLE bronze.customers 
(
	Customer_ID INT,
	Name NVARCHAR(50),
	Email VARCHAR(MAX),
	Telephone VARCHAR(50),
	City VARCHAR(50),
	Country VARCHAR(50),
	Gender VARCHAR(50),
	Date_Of_Birth VARCHAR(50),
	Job_Title VARCHAR(MAX)
);
--(2)Creating Table bronze.discounts-------------------------------------------------------
IF OBJECT_ID ('bronze.discounts' , 'U') IS NOT NULL
DROP TABLE bronze.discounts;
CREATE TABLE bronze.discounts
(
	Start VARCHAR(50),
	[End] VARCHAR(50),
	Discont DECIMAL(2,1),
	Description VARCHAR(50),
	Category VARCHAR(50),
	SubCategory VARCHAR(50)
);
--(3)Creating Table bronze.employees-------------------------------------------------------
IF OBJECT_ID ('bronze.employees' , 'U') IS NOT NULL
DROP TABLE bronze.employees;
CREATE TABLE bronze.employees
(
	EmployeeID INT,
	StoreID INT,
	Name VARCHAR(50),
	Position VARCHAR(50)
);
--(4)Creating Table bronze.products-------------------------------------------------------
IF OBJECT_ID ('bronze.products' , 'U') IS NOT NULL
DROP TABLE bronze.products;
CREATE TABLE bronze.products
(
	ProductID INT,
	Category VARCHAR(50),
	SubCategory VARCHAR(50),
	DescriptionPT VARCHAR(50),
	DescriptionDE VARCHAR(50),
	DescriptionFR VARCHAR(50),
	DescriptionES VARCHAR(50),
	DescriptionEN VARCHAR(50),
	DescriptionZH VARCHAR(50),
	Color VARCHAR(50),
	Sizes VARCHAR(50),
	ProductionCost DECIMAL (5,3)
);
--(5)Creating Table bronze.stores-------------------------------------------------------
IF OBJECT_ID ('bronze.stores' , 'U') IS NOT NULL
DROP TABLE bronze.stores;
CREATE TABLE bronze.stores
(
	StoreID INT,
	Country VARCHAR(50),
	City VARCHAR(50),
	StoreName VARCHAR(50),
	NumberofEmployees INT,
	ZIPCode VARCHAR(50),
	Latitude FLOAT,
	Longitude FLOAT
);
--(6)Creating Table bronze.transactions-------------------------------------------------------
IF OBJECT_ID ('bronze.transactions' , 'U') IS NOT NULL
DROP TABLE bronze.transactions;
CREATE TABLE bronze.transactions
(
	InvoiceID VARCHAR(50),
	Line INT,
	CustomerID INT,
	ProductID INT,
	Size VARCHAR(50),
	Color VARCHAR(50),
	UnitPrice DECIMAL (6,2),
	Quantity INT,
	[Date] VARCHAR(50),
	Discount DECIMAL(3,2),
	LineTotal FLOAT,
	StoreID INT,
	EmployeeID INT,
	Currency VARCHAR(50),
	CurrencySymbol VARCHAR(50),
	SKU VARCHAR(50),
	TransactionType VARCHAR(50),
	PaymentMethod VARCHAR(50),
	InvoiceTotal FLOAT
);