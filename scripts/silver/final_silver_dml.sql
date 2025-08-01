--INSERTING THE DATA INTO lookup.gender table
INSERT INTO lookup.gender
(
	Gender,
	Gender_discripption
)
SELECT DISTINCT
	Gender,
	CASE WHEN Gender = 'F' THEN 'Female'
		 WHEN Gender = 'M' THEN 'Male'
		 ELSE 'n/a'
	END AS Gender_discripption
FROM bronze.customers
GROUP BY Gender
--INSERTING DATA INTO lookup.Location TABLE
TRUNCATE TABLE lookup.location
INSERT INTO lookup.location
(
	City,
	Country_id
)
SELECT DISTINCT
	T.City,
	C.Country_id
FROM
(
SELECT DISTINCT
	City,
	Country
FROM bronze.customers
UNION
SELECT DISTINCT
	City,
	Country
FROM bronze.stores
)T
LEFT JOIN silver.country C ON C.Country = T.Country
--INSERTING THE DATA INTO silver.dim_customers table
TRUNCATE TABLE silver.dim_customers
INSERT INTO silver.dim_customers
(
	Customer_ID,
	Name,
	Email,
	Telephone,
	location_key,
	Gender_key,
	Date_Of_Birth,
	Job_Title
)
SELECT DISTINCT
	C.Customer_ID,
	C.Name,
	C.Email,
	C.Telephone,
	L.Location_key,
	G.Gender_key,
	C.Date_Of_Birth,
	C.Job_Title
FROM bronze.customers C
LEFT JOIN lookup.gender G ON G.Gender = C.Gender
LEFT JOIN lookup.location L ON L.City = C.City;
--INSERTING THE DATA INTO silver.dim_discounts table
TRUNCATE TABLE silver.dim_discounts;
INSERT INTO silver.dim_discounts
(
	Start,
	[End],
	Discont,
	Description,
	Category_key,
	Sub_Category_key
)
SELECT 
	D.Start,
	D.[End],
	D.Discont,
	D.Description,
	C.Category_key,
	SC.Sub_Category_key
FROM bronze.discounts D
LEFT JOIN lookup.category C ON C.Category_name = D.Category
LEFT JOIN lookup.sub_category SC ON SC.Sub_Category_name = D.Sub_Category;
--INSERTING THE DATA INTO lookup.positions table
TRUNCATE TABLE lookup.positions;
INSERT INTO lookup.positions
(
	Position_name
)
SELECT DISTINCT 
	Position
FROM bronze.employees
ORDER BY Position;
--INSERTING THE DATA INTO lookup.country table
TRUNCATE TABLE lookup.country
INSERT INTO lookup.country
(
	Country
)
SELECT DISTINCT
	Country
FROM bronze.stores
ORDER BY Country
--INSERTING DATA INTO silver.dim_stores TABLE
TRUNCATE TABLE silver.dim_stores;
INSERT INTO silver.dim_stores
(
	Store_ID,
	country_key,
	Location_key,
	Store_Name,
	Number_of_Employees,
	ZIP_Code,
	Latitude,
	Longitude
)
SELECT 
	S.Store_ID,
	C.country_key,
	L.Location_key,
	S.Store_Name,
	S.Number_of_Employees,
	S.ZIP_Code,
	S.Latitude,
	S.Longitude
FROM bronze.stores S
LEFT JOIN lookup.location L ON L.City = S.City
LEFT JOIN lookup.country C ON C.Country = S.Country
ORDER BY S.Store_Name
--INSERTING THE DATA INTO silver.dim_employees table
TRUNCATE TABLE silver.dim_employees;
INSERT INTO silver.dim_employees
(
	Employee_ID,
	Store_key,
	Name,
	Position_key
)
SELECT
	E.Employee_ID,
	S.Store_key,
	E.Name,
	P.Position_key
FROM bronze.employees E
LEFT JOIN lookup.positions P ON E.Position = P.Position_name
LEFT JOIN silver.dim_stores S ON S.Store_ID = E.Store_ID;
--INSERTING DATA INTO lookup.category TABLE
TRUNCATE TABLE lookup.category;
INSERT INTO lookup.category
(
	Category_name
)
SELECT DISTINCT
	Category
FROM bronze.products
ORDER BY Category;
--INSERTING DATA INTO lookup.sub_category TABLE
TRUNCATE TABLE lookup.sub_category;
INSERT INTO lookup.sub_category
(
	Sub_Category_name
)
SELECT DISTINCT
	Sub_Category
FROM bronze.products
ORDER BY Sub_Category;
--INSERTING DATA INTO lookup.color TABLE
TRUNCATE TABLE lookup.color;
INSERT INTO lookup.color
(
	Color_name
)
SELECT DISTINCT
	Color
FROM bronze.products
WHERE Color IS NOT NULL
ORDER BY Color;
--INSERTING DATA INTO silver.dim_products TABLE
TRUNCATE TABLE silver.dim_products;
INSERT INTO silver.dim_products
(
	Product_ID,
	Category_key,
	Sub_Category_key,
	Description_EN,
	Color_key,
	Sizes,
	Production_Cost
)
SELECT 
	P.Product_ID,
	C.Category_key,
	S.Sub_Category_key,
	P.Description_EN,
	C2.Color_key,
	REPLACE(P.Sizes,'|',','),
	P.Production_Cost
FROM bronze.products P
LEFT JOIN lookup.category C ON C.Category_name = P.Category
LEFT JOIN lookup.sub_category S ON S.Sub_Category_name = P.Sub_Category
LEFT JOIN lookup.color C2 ON C2.Color_name = P.Color
--INSERTING DATA INTO lookup.currency TABLE
TRUNCATE TABLE lookup.currency;
INSERT INTO lookup.currency
(
	Currency,
	CurrencySymbol
)
SELECT DISTINCT
	Currency,
	CurrencySymbol
FROM bronze.transactions
ORDER BY Currency
--INSERTING DATA INTO lookup.payment_method TABLE
TRUNCATE TABLE lookup.payment_method;
INSERT INTO lookup.payment_method
(
	PaymentMethod
)
SELECT DISTINCT  
	PaymentMethod
FROM bronze.transactions
ORDER BY PaymentMethod;
--INSERTING DATA INTO lookup.sizes TABLE
INSERT INTO lookup.sizes
(
	Size
)
SELECT DISTINCT  
	Size
FROM bronze.transactions
WHERE Size IS NOT NULL
ORDER BY Size;
--INSERTING DATA INTO silver.dim_date TABLE
WITH DateSequence AS (
    SELECT CAST('2023-01-01' AS DATE) AS [date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [date])
    FROM DateSequence
    WHERE [date] < '2025-04-30'
)
INSERT INTO silver.dim_date (
    date_key, [date], year, quarter, month, month_name,
    day_of_month, day_of_week, weekday_name, is_weekend,
    week_of_year, day_of_year
)
SELECT
    CAST(CONVERT(CHAR(8), [date], 112) AS INT) AS date_key,
    [date],
    DATEPART(YEAR, [date]) AS year,
    DATEPART(QUARTER, [date]) AS quarter,
    DATEPART(MONTH, [date]) AS month,
    DATENAME(MONTH, [date]) AS month_name,
    DATEPART(DAY, [date]) AS day_of_month,
    DATEPART(WEEKDAY, [date]) AS day_of_week,
    DATENAME(WEEKDAY, [date]) AS weekday_name,
    CASE WHEN DATEPART(WEEKDAY, [date]) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend,
    DATEPART(WEEK, [date]) AS week_of_year,
    DATEPART(DAYOFYEAR, [date]) AS day_of_year
FROM DateSequence
OPTION (MAXRECURSION 10000);
--INSERTING DATA INTO silver.fact_sales_transactions TABLE
TRUNCATE TABLE silver.fact_sales_transactions;
INSERT INTO silver.fact_sales_transactions
(
	InvoiceID,
	date_key,
	Line,
	Customer_key,
	Product_key,
	Size_key,
	Color_key,
	Category_key,
	Sub_Category_key,
	Store_key,
	Employee_key,
	Currency_key,
	PaymentMethod_key,
	UnitPrice,
	Quantity,
	Discount,
	discount_key,
	LineTotal,
	InvoiceTotal
)
SELECT
	T.InvoiceID,
	DD.date_key,
	T.Line,
	CU.Customer_key,
	PR.Product_key,
	S.Size_key,
	C.Color_key,
	P.Category_key,
	P.Sub_Category_key,
	ST.Store_key,
	E.Employee_key,
	C2.Currency_key,
	PM.PaymentMethod_key,
	T.UnitPrice,
	T.Quantity,
	T.Discount,
	D.discount_key,
	T.LineTotal,
	InvoiceTotal
FROM bronze.transactions T
LEFT JOIN silver.dim_date DD ON DD.[date] = CAST(T.Date AS DATE)
LEFT JOIN silver.dim_customers CU ON CU.Customer_ID = T.CustomerID
LEFT JOIN silver.dim_products PR ON PR.Product_ID = T.ProductID
LEFT JOIN lookup.color C ON C.Color_name = T.Color
LEFT JOIN lookup.currency C2 ON C2.Currency = T.Currency
LEFT JOIN silver.dim_products P ON P.Product_ID = T.ProductID
LEFT JOIN lookup.payment_method PM ON PM.PaymentMethod = T.PaymentMethod
LEFT JOIN lookup.sizes S ON S.Size = T.Size
LEFT JOIN silver.dim_stores ST ON ST.Store_ID = T.StoreID
LEFT JOIN silver.dim_employees E ON E.Employee_ID = T.EmployeeID
LEFT JOIN silver.dim_discounts D ON 
			(T.Discount = 0 AND D.Discont = 0)
			OR
			(T.Discount > 0 AND T.Date BETWEEN D.Start AND D.[End] AND
			(
				(D.Category_key = P.Category_key AND D.Sub_Category_key = P.Sub_Category_key)
				OR (D.Sub_Category_key IS NULL AND D.Sub_Category_key IS NULL)
			))
WHERE TransactionType = 'Sale'
--INSERTING DATA INTO silver.fact_sales_return_transactions TABLE
TRUNCATE TABLE silver.fact_sales_return_transactions;
INSERT INTO silver.fact_sales_return_transactions
(
	InvoiceID,
	sales_InvoiceID,
	date_key,
	Line,
	Product_key,
	Currency_key,
	PaymentMethod_key,
	UnitPrice,
	Quantity,
	LineTotal,
	InvoiceTotal
)
SELECT
	T.InvoiceID,
	REPLACE(T.InvoiceID,'RET','INV') AS sales_InvoiceID,
	DD.date_key,
	T.Line,
	PR.Product_key,
	C2.Currency_key,
	PM.PaymentMethod_key,
	T.UnitPrice,
	T.Quantity,
	T.LineTotal,
	T.InvoiceTotal
FROM bronze.transactions T
LEFT JOIN silver.dim_date DD ON DD.[date] = CAST(T.Date AS DATE)
LEFT JOIN silver.dim_products PR ON PR.Product_ID = T.ProductID
LEFT JOIN lookup.currency C2 ON C2.Currency = T.Currency
LEFT JOIN lookup.payment_method PM ON PM.PaymentMethod = T.PaymentMethod
WHERE TransactionType = 'Return'