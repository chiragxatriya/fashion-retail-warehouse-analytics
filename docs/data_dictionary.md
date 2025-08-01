# Data Dictionary for Fashion Retail Warehouse Analytics

---

## Schema: bronze (Raw Data Staging)

### Table: bronze.customers  
Stores raw customer data as imported from CSV.

| Column        | Data Type     | PK  | FK  | Nullable | Description                                    |
|---------------|---------------|-----|-----|----------|------------------------------------------------|
| Customer_ID   | INT           |     |     | Yes      | Unique customer identifier                      |
| Name          | NVARCHAR(50)  |     |     | Yes      | Customer full name                              |
| Email         | VARCHAR(MAX)  |     |     | Yes      | Customer email address                          |
| Telephone     | VARCHAR(50)   |     |     | Yes      | Customer phone number                           |
| City          | VARCHAR(50)   |     |     | Yes      | Customer city of residence                       |
| Country       | VARCHAR(50)   |     |     | Yes      | Customer country of residence                    |
| Gender        | VARCHAR(50)   |     |     | Yes      | Gender code (e.g., 'F', 'M', or others)         |
| Date_Of_Birth | VARCHAR(50)   |     |     | Yes      | Date of birth in string format (dd-mm-yyyy)    |
| Job_Title     | VARCHAR(MAX)  |     |     | Yes      | Customer's job title                            |

---

### Table: bronze.discounts  

| Column       | Data Type     | PK  | FK  | Nullable | Description                                |
|--------------|---------------|-----|-----|----------|--------------------------------------------|
| Start        | VARCHAR(50)   |     |     | Yes      | Discount start date in string format        |
| End          | VARCHAR(50)   |     |     | Yes      | Discount end date in string format          |
| Discont      | DECIMAL(2,1)  |     |     | Yes      | Discount percentage or rate                  |
| Description  | VARCHAR(50)   |     |     | Yes      | Discount description                         |
| Category     | VARCHAR(50)   |     |     | Yes      | Associated product category                   |
| SubCategory  | VARCHAR(50)   |     |     | Yes      | Associated product sub-category               |

---

### Table: bronze.employees  

| Column     | Data Type    | PK  | FK  | Nullable | Description                                   |
|------------|--------------|-----|-----|----------|-----------------------------------------------|
| EmployeeID | INT          |     |     | Yes      | Unique employee identifier                    |
| StoreID    | INT          |     |     | Yes      | Store identifier where employee works        |
| Name       | VARCHAR(50)  |     |     | Yes      | Employee full name                            |
| Position   | VARCHAR(50)  |     |     | Yes      | Employee job position                         |

---

### Table: bronze.products  

| Column         | Data Type    | PK  | FK  | Nullable | Description                                  |
|----------------|--------------|-----|-----|----------|----------------------------------------------|
| ProductID      | INT          |     |     | Yes      | Unique product identifier                     |
| Category       | VARCHAR(50)  |     |     | Yes      | Product category                              |
| SubCategory    | VARCHAR(50)  |     |     | Yes      | Product sub-category                          |
| DescriptionPT  | VARCHAR(50)  |     |     | Yes      | Portuguese product description                 |
| DescriptionDE  | VARCHAR(50)  |     |     | Yes      | German product description                      |
| DescriptionFR  | VARCHAR(50)  |     |     | Yes      | French product description                      |
| DescriptionES  | VARCHAR(50)  |     |     | Yes      | Spanish product description                     |
| DescriptionEN  | VARCHAR(50)  |     |     | Yes      | English product description                     |
| DescriptionZH  | VARCHAR(50)  |     |     | Yes      | Chinese product description                     |
| Color          | VARCHAR(50)  |     |     | Yes      | Product color                                 |
| Sizes          | VARCHAR(50)  |     |     | Yes      | Available sizes (pipe-separated in raw data)  |
| ProductionCost | DECIMAL(5,3) |     |     | Yes      | Cost of production                            |

---

### Table: bronze.stores  

| Column            | Data Type   | PK  | FK  | Nullable | Description                               |
|-------------------|-------------|-----|-----|----------|-------------------------------------------|
| StoreID           | INT         |     |     | Yes      | Unique store identifier                   |
| Country           | VARCHAR(50) |     |     | Yes      | Store country                             |
| City              | VARCHAR(50) |     |     | Yes      | City where store is located               |
| StoreName         | VARCHAR(50) |     |     | Yes      | Store name                               |
| NumberofEmployees | INT         |     |     | Yes      | Number of employees at the store         |
| ZIPCode           | VARCHAR(50) |     |     | Yes      | Postal code                              |
| Latitude          | FLOAT       |     |     | Yes      | Latitude for store location               |
| Longitude         | FLOAT       |     |     | Yes      | Longitude for store location              |

---

### Table: bronze.transactions  

| Column          | Data Type     | PK  | FK  | Nullable | Description                                |
|-----------------|---------------|-----|-----|----------|--------------------------------------------|
| InvoiceID       | VARCHAR(50)   |     |     | Yes      | Invoice identifier                         |
| Line            | INT           |     |     | Yes      | Line number within invoice                 |
| CustomerID      | INT           |     | Yes | Yes      | FK to bronze.customers                     |
| ProductID       | INT           |     | Yes | Yes      | FK to bronze.products                      |
| Size            | VARCHAR(50)   |     |     | Yes      | Size of product sold                       |
| Color           | VARCHAR(50)   |     |     | Yes      | Color of product sold                      |
| UnitPrice       | DECIMAL(6,2)  |     |     | Yes      | Unit price of product                      |
| Quantity        | INT           |     |     | Yes      | Quantity of items sold                     |
| Date            | VARCHAR(50)   |     |     | Yes      | Transaction date as string                 |
| Discount        | DECIMAL(3,2)  |     |     | Yes      | Discount applied on the transaction line  |
| LineTotal       | FLOAT         |     |     | Yes      | Total amount for the line                  |
| StoreID         | INT           |     | Yes | Yes      | FK to bronze.stores                        |
| EmployeeID      | INT           |     | Yes | Yes      | FK to bronze.employees                     |
| Currency        | VARCHAR(50)   |     |     | Yes      | Currency code                             |
| CurrencySymbol  | VARCHAR(50)   |     |     | Yes      | Currency symbol                           |
| SKU             | VARCHAR(50)   |     |     | Yes      | Stock-keeping unit identifier             |
| TransactionType | VARCHAR(50)   |     |     | Yes      | Type of transaction ('Sale' or 'Return') |
| PaymentMethod   | VARCHAR(50)   |     |     | Yes      | Payment method used                       |
| InvoiceTotal    | FLOAT         |     |     | Yes      | Total invoice amount                      |

---

## Schema: lookup (Lookup Dimension Tables)

### Table: lookup.gender  

| Column             | Data Type    | PK  | FK  | Nullable | Description                            |
|--------------------|--------------|-----|-----|----------|----------------------------------------|
| Gender_key         | INT          | PK  |     | No       | Surrogate primary key                  |
| Gender             | VARCHAR(50)  |     |     | No       | Gender code (e.g., 'F', 'M')          |
| Gender_discripption | VARCHAR(50)  |     |     | No       | Description ('Female', 'Male', 'n/a') |

---

### Table: lookup.location  

| Column        | Data Type     | PK  | FK  | Nullable | Description                                  |
|---------------|---------------|-----|-----|----------|----------------------------------------------|
| Location_key  | INT           | PK  |     | No       | Surrogate primary key                        |
| City          | NVARCHAR(50)  |     |     | No       | City name                                   |
| Country_id    | INT           |     | FK  | No       | FK to lookup.country.Country_key            |

---

### Table: lookup.positions  

| Column        | Data Type     | PK  | FK  | Nullable | Description                        |
|---------------|---------------|-----|-----|----------|------------------------------------|
| Position_key  | INT           | PK  |     | No       | Surrogate primary key              |
| Position_name | NVARCHAR(50)  |     |     | No       | Employee position description     |

---

### Table: lookup.country  

| Column      | Data Type    | PK  | FK  | Nullable | Description                     |
|-------------|--------------|-----|-----|----------|---------------------------------|
| Country_key | INT          | PK  |     | No       | Surrogate primary key          |
| Country     | NVARCHAR(50) |     |     | No       | Country name                   |

---

### Table: lookup.category  

| Column       | Data Type    | PK  | FK  | Nullable | Description                   |
|--------------|--------------|-----|-----|----------|-------------------------------|
| Category_key | INT          | PK  |     | No       | Surrogate primary key         |
| Category_name| NVARCHAR(50) |     |     | No       | Category name                |

---

### Table: lookup.sub_category  

| Column           | Data Type    | PK  | FK  | Nullable | Description                  |
|------------------|--------------|-----|-----|----------|------------------------------|
| Sub_Category_key | INT          | PK  |     | No       | Surrogate primary key        |
| Sub_Category_name| NVARCHAR(50) |     |     | No       | Sub-category name           |

---

### Table: lookup.color  

| Column      | Data Type    | PK  | FK  | Nullable | Description                    |
|-------------|--------------|-----|-----|----------|-------------------------------|
| Color_key   | INT          | PK  |     | No       | Surrogate primary key          |
| Color_name  | VARCHAR(50)  |     |     | No       | Color name                    |

---

### Table: lookup.currency  

| Column         | Data Type    | PK  | FK  | Nullable | Description                      |
|----------------|--------------|-----|-----|----------|----------------------------------|
| Currency_key   | INT          | PK  |     | No       | Surrogate primary key            |
| Currency       | VARCHAR(50)  |     |     | No       | Currency code (e.g., USD)        |
| CurrencySymbol | NVARCHAR     |     |     | Yes      | Currency symbol (e.g., $)        |

---

### Table: lookup.payment_method  

| Column           | Data Type    | PK  | FK  | Nullable | Description                      |
|------------------|--------------|-----|-----|----------|----------------------------------|
| PaymentMethod_key | INT          | PK  |     | No       | Surrogate primary key            |
| PaymentMethod    | VARCHAR(50)  |     |     | No       | Payment method description       |

---

### Table: lookup.sizes  

| Column    | Data Type    | PK  | FK  | Nullable | Description                   |
|-----------|--------------|-----|-----|----------|------------------------------|
| Size_key  | INT          | PK  |     | No       | Surrogate primary key        |
| Size      | NVARCHAR(50) |     |     | No       | Size description             |

---

## Schema: silver (Dimension and Fact Tables)

### Table: silver.dim_customers  

| Column         | Data Type     | PK  | FK  | Nullable | Description                       |
|----------------|---------------|-----|-----|----------|-----------------------------------|
| customer_key   | INT           | PK  |     | No       | Surrogate primary key            |
| Customer_ID    | INT           |     |     | No       | Customer natural ID             |
| Name           | NVARCHAR(50)  |     |     | Yes      | Customer full name             |
| Email          | NVARCHAR(MAX) |     |     | Yes      | Email address                  |
| Telephone      | NVARCHAR(50)  |     |     | Yes      | Phone contact                  |
| location_key   | INT           |     | FK  | No       | FK to lookup.location.Location_key |
| Gender_key     | INT           |     | FK  | No       | FK to lookup.gender.Gender_key |
| Date_Of_Birth  | DATE          |     |     | Yes      | Converted DOB as DATE          |
| Job_Title      | VARCHAR(MAX)  |     |     | Yes      | Customer occupation           |

---

### Table: silver.dim_discounts  

| Column           | Data Type     | PK  | FK  | Nullable | Description                                     |
|------------------|---------------|-----|-----|----------|------------------------------------------------|
| discount_key     | INT           | PK  |     | No       | Surrogate primary key                          |
| Start            | DATE          |     |     | Yes      | Discount start date                            |
| End              | DATE          |     |     | Yes      | Discount end date                              |
| Discont          | FLOAT         |     |     | Yes      | Discount percentage                            |
| Description      | NVARCHAR(255) |     |     | Yes      | Description of discount                        |
| Category_key     | INT           |     | FK  | Yes      | FK to lookup.category.Category_key             |
| Sub_Category_key | INT           |     | FK  | Yes      | FK to lookup.sub_category.Sub_Category_key     |

---

### Table: silver.dim_stores  

| Column              | Data Type     | PK  | FK  | Nullable | Description                                   |
|---------------------|---------------|-----|-----|----------|-----------------------------------------------|
| store_key           | INT           | PK  |     | No       | Surrogate primary key                         |
| Store_ID            | INT           |     |     | No       | Store natural ID                             |
| country_key         | INT           |     | FK  | No       | FK to lookup.country.Country_key              |
| Location_key        | INT           |     | FK  | No       | FK to lookup.location.Location_key            |
| Store_Name          | NVARCHAR(50)  |     |     | Yes      | Store name                                  |
| Number_of_Employees | INT           |     |     | Yes      | Number of employees                          |
| ZIP_Code            | NVARCHAR(50)  |     |     | Yes      | Postal code                                 |
| Latitude            | FLOAT         |     |     | Yes      | Latitude of store                            |
| Longitude           | FLOAT         |     |     | Yes      | Longitude of store                           |

---

### Table: silver.dim_employees  

| Column        | Data Type     | PK  | FK  | Nullable | Description                                |
|---------------|---------------|-----|-----|----------|--------------------------------------------|
| employee_key  | INT           | PK  |     | No       | Surrogate primary key                      |
| Employee_ID   | INT           |     |     | No       | Original employee ID                      |
| Store_key    | INT           |     | FK  | No       | FK to silver.dim_stores.store_key          |
| Name         | NVARCHAR(50)  |     |     | Yes      | Employee name                            |
| Position_key | INT           |     | FK  | No       | FK to lookup.positions.Position_key         |

---

### Table: silver.dim_products  

| Column           | Data Type     | PK  | FK  | Nullable | Description                                 |
|------------------|---------------|-----|-----|----------|---------------------------------------------|
| product_key      | INT           | PK  |     | No       | Surrogate primary key                      |
| Product_ID       | INT           |     |     | No       | Natural product ID                        |
| Category_key     | INT           |     | FK  | No       | FK to lookup.category.Category_key          |
| Sub_Category_key | INT           |     | FK  | No       | FK to lookup.sub_category.Sub_Category_key  |
| Description_EN   | NVARCHAR(MAX) |     |     | Yes      | English product description                |
| Color_key       | INT           |     | FK  | Yes      | FK to lookup.color.Color_key                 |
| Sizes           | VARCHAR(50)   |     |     | Yes      | Sizes available (comma separated)           |
| Production_Cost | DECIMAL(5,3)  |     |     | Yes      | Cost of production                         |

---

### Table: silver.dim_date  

| Column         | Data Type    | PK  | FK  | Nullable | Description                                |
|----------------|--------------|-----|-----|----------|-------------------------------------------|
| date_key       | INT          | PK  |     | No       | Date key formatted as YYYYMMDD            |
| date           | DATE         |     |     | No       | Calendar date                            |
| year           | INT          |     |     | No       | Year component                           |
| quarter        | INT          |     |     | No       | Quarter (1-4)                           |
| month          | INT          |     |     | No       | Month (1-12)                           |
| month_name     | NVARCHAR(20) |     |     | No       | Month name                              |
| day_of_month   | INT          |     |     | No       | Day of the month                       |
| day_of_week    | INT          |     |     | No       | Day of week (Sunday=1)                  |
| weekday_name   | NVARCHAR(20) |     |     | No       | Weekday name                           |
| is_weekend     | BIT          |     |     | No       | Weekend flag (1 = weekend)              |
| week_of_year   | INT          |     |     | No       | Week number                           |
| day_of_year    | INT          |     |     | No       | Day of the year                       |

---

### Table: silver.fact_sales_transactions  

| Column           | Data Type     | PK  | FK  | Nullable | Description                                |
|------------------|---------------|-----|-----|----------|--------------------------------------------|
| sales_transaction_key | INT      | PK  |     | No       | Surrogate primary key                      |
| InvoiceID        | NVARCHAR(100) |     |     | Yes      | Invoice number                            |
| date_key         | INT           |     | FK  | No       | FK to silver.dim_date.date_key              |
| Line             | INT           |     |     | Yes      | Line number in invoice                     |
| Customer_key     | INT           |     | FK  | Yes      | FK to silver.dim_customers.customer_key     |
| Product_key      | INT           |     | FK  | Yes      | FK to silver.dim_products.product_key       |
| Size_key         | INT           |     | FK  | Yes      | FK to lookup.sizes.Size_key                   |
| Color_key        | INT           |     | FK  | Yes      | FK to lookup.color.Color_key                   |
| Category_key     | INT           |     | FK  | Yes      | FK to lookup.category.Category_key             |
| Sub_Category_key | INT           |     | FK  | Yes      | FK to lookup.sub_category.Sub_Category_key     |
| Store_key        | INT           |     | FK  | Yes      | FK to silver.dim_stores.store_key               |
| Employee_key     | INT           |     | FK  | Yes      | FK to silver.dim_employees.employee_key          |
| Currency_key     | INT           |     | FK  | Yes      | FK to lookup.currency.Currency_key               |
| PaymentMethod_key| INT           |     | FK  | Yes      | FK to lookup.payment_method.PaymentMethod_key    |
| UnitPrice        | FLOAT         |     |     | Yes      | Unit price                                |
| Quantity         | INT           |     |     | Yes      | Quantity sold                            |
| Discount         | FLOAT         |     |     | Yes      | Discount applied                        |
| discount_key     | INT           |     | FK  | Yes      | FK to silver.dim_discounts.discount_key        |
| LineTotal        | FLOAT         |     |     | Yes      | Extended line total                      |
| InvoiceTotal     | FLOAT         |     |     | Yes      | Invoice total                           |

---

### Table: silver.fact_sales_return_transactions  

| Column                 | Data Type     | PK  | FK  | Nullable | Description                                |
|------------------------|---------------|-----|-----|----------|--------------------------------------------|
| sales_return_transaction_key | INT     | PK  |     | No       | Surrogate primary key                      |
| InvoiceID              | NVARCHAR(100) |     |     | Yes      | Return invoice number                     |
| sales_InvoiceID        | NVARCHAR(100) |     |     | Yes      | Original sale invoice number              |
| date_key               | INT           |     | FK  | No       | FK to silver.dim_date.date_key              |
| Line                   | INT           |     |     | Yes      | Line number in invoice                     |
| Product_key            | INT           |     | FK  | Yes      | FK to silver.dim_products.product_key       |
| Currency_key           | INT           |     | FK  | Yes      | FK to lookup.currency.Currency_key           |
| PaymentMethod_key      | INT           |     | FK  | Yes      | FK to lookup.payment_method.PaymentMethod_key|
| UnitPrice              | FLOAT         |     |     | Yes      | Return unit price                          |
| Quantity               | INT           |     |     | Yes      | Quantity returned                         |
| LineTotal              | FLOAT         |     |     | Yes      | Return line total                         |
| InvoiceTotal           | FLOAT         |     |     | Yes      | Return invoice total                      |

---

*This data dictionary reflects the primary and foreign key relationships in your database design to help clarify table joins and integrity constraints.*

