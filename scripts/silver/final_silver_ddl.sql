--CREATING lookup.gender TABLE
IF OBJECT_ID ('lookup.gender','U') IS NOT NULL
DROP TABLE lookup.gender;
CREATE TABLE lookup.gender
(
	Gender_key INT IDENTITY(1,1) PRIMARY KEY,
	Gender VARCHAR(50),
	Gender_discripption VARCHAR(50)
);
--CREATING TABLE lookup.location
IF OBJECT_ID('lookup.location','U') IS NOT NULL
DROP TABLE lookup.location
CREATE TABLE lookup.location
(
	Location_key INT IDENTITY(1,1) PRIMARY KEY,
	City NVARCHAR(50),
	Country_id INT
);
--CREATING TABLE silver.dim_customers
IF OBJECT_ID ('silver.dim_customers' , 'U') IS NOT NULL
DROP TABLE silver.dim_customers;
CREATE TABLE silver.dim_customers
(
	customer_key INT IDENTITY(1,1) PRIMARY KEY,
	Customer_ID INT,
	Name NVARCHAR(50),
	Email NVARCHAR(MAX),
	Telephone NVARCHAR(50),
	location_key INT,
	Gender_key INT,
	Date_Of_Birth DATE,
	Job_Title VARCHAR(MAX)
);
--Foreign Keys to silver.dim_customers
ALTER TABLE silver.dim_customers
ADD CONSTRAINT FK_customers_location
FOREIGN KEY (location_key)
REFERENCES lookup.location(location_key);
ALTER TABLE silver.dim_customers
ADD CONSTRAINT FK_customers_gender
FOREIGN KEY (Gender_key)
REFERENCES lookup.gender(gender_key);
--CREATING TABLE silver.dim_discounts
IF OBJECT_ID ('silver.dim_discounts' , 'U') IS NOT NULL
DROP TABLE silver.dim_discounts;
CREATE TABLE silver.dim_discounts
(
	discount_key INT IDENTITY(1,1) PRIMARY KEY,
	Start DATE,
	[End] DATE,
	Discont FLOAT,
	Description NVARCHAR(255),
	Category_key INT,
	Sub_Category_key INT
);
--Foreign Keys to silver.dim_discounts
ALTER TABLE silver.dim_discounts
ADD CONSTRAINT FK_discount_category
FOREIGN KEY (Category_key)
REFERENCES lookup.category(Category_key);

ALTER TABLE silver.dim_discounts
ADD CONSTRAINT FK_discount_subcategory
FOREIGN KEY (Sub_Category_key)
REFERENCES lookup.sub_category(Sub_Category_key);
--CREATING TABLE lookup.positions
IF OBJECT_ID ('lookup.positions','U') IS NOT NULL
DROP TABLE lookup.positions;
CREATE TABLE lookup.positions
(
	Position_key INT IDENTITY(1,1) PRIMARY KEY,
	Position_name NVARCHAR(50)
);
--CREATING TABLE lookup.country
IF OBJECT_ID('lookup.country','U') IS NOT NULL
DROP TABLE lookup.country
CREATE TABLE lookup.country
(
	Country_key INT IDENTITY (1,1) PRIMARY KEY,
	Country NVARCHAR(50)
);
--CREATING TABLE silver.dim_stores
IF OBJECT_ID ('silver.dim_stores' , 'U') IS NOT NULL
DROP TABLE silver.dim_stores;
CREATE TABLE silver.dim_stores
(
	store_key INT IDENTITY(1,1) PRIMARY KEY,
	Store_ID INT,
	country_key INT,
	Location_key INT,
	Store_Name NVARCHAR(50),
	Number_of_Employees INT,
	ZIP_Code NVARCHAR(50),
	Latitude FLOAT,
	Longitude FLOAT
);
--Foreign Keys to silver.dim_stores
ALTER TABLE silver.dim_stores
ADD CONSTRAINT FK_store_location
FOREIGN KEY (Location_key)
REFERENCES lookup.location(Location_key);
ALTER TABLE silver.dim_stores
ADD CONSTRAINT FK_store_country
FOREIGN KEY (country_key)
REFERENCES lookup.country(country_key);
--CREATING TABLE silver.dim_employees
IF OBJECT_ID ('silver.dim_employees' , 'U') IS NOT NULL
DROP TABLE silver.dim_employees;
CREATE TABLE silver.dim_employees
(
	employee_key INT IDENTITY(1,1) PRIMARY KEY,
	Employee_ID INT,
	Store_key INT,
	Name NVARCHAR(50),
	Position_key INT
);
--Foreign Keys to silver.dim_employees
ALTER TABLE silver.dim_employees
ADD CONSTRAINT FK_employee_store
FOREIGN KEY (Store_key)
REFERENCES silver.dim_stores(Store_key);
ALTER TABLE silver.dim_employees
ADD CONSTRAINT FK_employee_position
FOREIGN KEY (Position_key)
REFERENCES lookup.positions(Position_key);
--CREATING TABLE lookup.category
IF OBJECT_ID('lookup.category','U') IS NOT NULL
DROP TABLE lookup.category;
CREATE TABLE lookup.category
(
	Category_key INT IDENTITY(1,1) PRIMARY KEY,
	Category_name NVARCHAR(50)
);
--CREATING TABLE lookup.sub_category
IF OBJECT_ID('lookup.sub_category','U') IS NOT NULL
DROP TABLE lookup.sub_category;
CREATE TABLE lookup.sub_category
(
	Sub_Category_key INT IDENTITY(1,1) PRIMARY KEY,
	Sub_Category_name NVARCHAR(50)
)
--CREATING TABLE lookup.color
IF OBJECT_ID('lookup.color','U') IS NOT NULL
DROP TABLE lookup.color;
CREATE TABLE lookup.color
(
	Color_key INT IDENTITY(1,1) PRIMARY KEY,
	Color_name VARCHAR(50)
);
--CREATING TABLE silver.dim_products
IF OBJECT_ID ('silver.dim_products' , 'U') IS NOT NULL
DROP TABLE silver.dim_products;
CREATE TABLE silver.dim_products
(
	product_key INT IDENTITY(1,1) PRIMARY KEY,
	Product_ID INT,
	Category_key INT,
	Sub_Category_key INT,
	Description_EN NVARCHAR(MAX),
	Color_key INT,
	Sizes VARCHAR(50),
	Production_Cost DECIMAL (5,3)
);
--Foreign Keys to silver.dim_employees
ALTER TABLE silver.dim_products
ADD CONSTRAINT FK_product_category
FOREIGN KEY (Category_key)
REFERENCES lookup.category(Category_key);

ALTER TABLE silver.dim_products
ADD CONSTRAINT FK_product_sub_category
FOREIGN KEY (Sub_Category_key)
REFERENCES lookup.sub_category(Sub_Category_key);

ALTER TABLE silver.dim_products
ADD CONSTRAINT FK_product_color
FOREIGN KEY (Color_key)
REFERENCES lookup.color(Color_key);
--CREATING TABLE lookup.currency
IF OBJECT_ID ('lookup.currency', 'U') IS NOT NULL
DROP TABLE lookup.currency
CREATE TABLE lookup.currency
(
	Currency_key INT IDENTITY(1,1) PRIMARY KEY,
	Currency VARCHAR(50),
	CurrencySymbol NVARCHAR
);
--CREATING TABLE lookup.payment_method
IF OBJECT_ID ('lookup.payment_method','U') IS NOT NULL
DROP TABLE lookup.payment_method
CREATE TABLE lookup.payment_method
(
	PaymentMethod_key INT IDENTITY(1,1) PRIMARY KEY,
	PaymentMethod VARCHAR(50)
);
--CREATING TABLE lookup.sizes
IF OBJECT_ID ('lookup.sizes','U') IS NOT NULL
DROP TABLE lookup.sizes
CREATE TABLE lookup.sizes
(
	Size_key INT IDENTITY(1,1) PRIMARY KEY,
	Size NVARCHAR(50)
);
--CREATING TABLE silver.dim_date
CREATE TABLE silver.dim_date (
    date_key INT PRIMARY KEY,                -- Format: YYYYMMDD (e.g., 20230617)
    [date] DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    month_name NVARCHAR(20) NOT NULL,
    day_of_month INT NOT NULL,
    day_of_week INT NOT NULL,                -- Sunday=1, Saturday=7
    weekday_name NVARCHAR(20) NOT NULL,
    is_weekend BIT NOT NULL,
    week_of_year INT NOT NULL,
    day_of_year INT NOT NULL
);
--CREATING TABLE silver.fact_sales_transactions
IF OBJECT_ID ('silver.fact_sales_transactions' , 'U') IS NOT NULL
DROP TABLE silver.fact_sales_transactions;
CREATE TABLE silver.fact_sales_transactions
(
	sales_transaction_key INT IDENTITY(1,1) PRIMARY KEY,
	InvoiceID NVARCHAR(100),
	date_key INT,
	Line INT,
	Customer_key INT,
	Product_key INT,
	Size_key INT,
	Color_key INT,
	Category_key INT,
	Sub_Category_key INT,
	Store_key INT,
	Employee_key INT,
	Currency_key INT,
	PaymentMethod_key INT,
	UnitPrice FLOAT,
	Quantity INT,
	Discount FLOAT,
	discount_key INT,
	LineTotal FLOAT,
	InvoiceTotal FLOAT
);
--Foreign Keys to silver.fact_sales_transactions
ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_date
FOREIGN KEY (date_key)
REFERENCES silver.dim_date(date_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_discount
FOREIGN KEY (discount_key)
REFERENCES silver.[dim_discounts](discount_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_customer
FOREIGN KEY (Customer_key)
REFERENCES silver.dim_customers(Customer_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_product_sales
FOREIGN KEY (Product_key)
REFERENCES silver.dim_products(Product_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_product_size
FOREIGN KEY (Size_key)
REFERENCES lookup.sizes(Size_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_product_sold_color
FOREIGN KEY (Color_key)
REFERENCES lookup.color(Color_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_product_sold_category
FOREIGN KEY (Category_key)
REFERENCES lookup.category(Category_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_product_sold_sub_category
FOREIGN KEY (Sub_Category_key)
REFERENCES lookup.sub_category(Sub_Category_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_store
FOREIGN KEY (Store_key)
REFERENCES silver.dim_stores(Store_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_employee
FOREIGN KEY (Employee_key)
REFERENCES silver.dim_employees(Employee_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_currency
FOREIGN KEY (Currency_key)
REFERENCES lookup.currency(Currency_key);

ALTER TABLE silver.fact_sales_transactions
ADD CONSTRAINT FK_sales_PaymentMethod
FOREIGN KEY (PaymentMethod_key)
REFERENCES lookup.payment_method(PaymentMethod_key);
--CREATING TABLE silver.fact_sales_return_transactions
IF OBJECT_ID ('silver.fact_sales_return_transactions' , 'U') IS NOT NULL
DROP TABLE silver.fact_sales_return_transactions;
CREATE TABLE silver.fact_sales_return_transactions
(
	sales_return_transaction_key INT IDENTITY(1,1) PRIMARY KEY,
	InvoiceID NVARCHAR(100),
	sales_InvoiceID NVARCHAR(100),
	date_key INT,
	Line INT,
	Product_key INT,
	Currency_key INT,
	PaymentMethod_key INT,
	UnitPrice FLOAT,
	Quantity INT,
	LineTotal FLOAT,
	InvoiceTotal FLOAT
);
--Foreign Keys to silver.fact_sales_return_transactions
ALTER TABLE silver.fact_sales_return_transactions
ADD CONSTRAINT FK_sales_return_date
FOREIGN KEY (date_key)
REFERENCES silver.dim_date(date_key);

ALTER TABLE silver.fact_sales_return_transactions
ADD CONSTRAINT FK_product_sales_return
FOREIGN KEY (Product_key)
REFERENCES silver.dim_products(Product_key);

ALTER TABLE silver.fact_sales_return_transactions
ADD CONSTRAINT FK_sales_return_currency
FOREIGN KEY (Currency_key)
REFERENCES lookup.currency(Currency_key);

ALTER TABLE silver.fact_sales_return_transactions
ADD CONSTRAINT FK_sales_return_PaymentMethod
FOREIGN KEY (PaymentMethod_key)
REFERENCES lookup.payment_method(PaymentMethod_key);