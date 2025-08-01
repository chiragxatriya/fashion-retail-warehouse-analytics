# Data Dictionary for Fashion Retail Warehouse Analytics

---

## Schema: bronze (Raw Data Staging)

### Table: bronze.customers  
Stores raw customer data as imported from CSV.

| Column        | Data Type     | Nullable | Description                                    |
|---------------|---------------|----------|------------------------------------------------|
| Customer_ID   | INT           | Yes      | Unique customer identifier                      |
| Name          | NVARCHAR(50)  | Yes      | Customer full name                              |
| Email         | VARCHAR(MAX)  | Yes      | Customer email address                          |
| Telephone     | VARCHAR(50)   | Yes      | Customer phone number                           |
| City          | VARCHAR(50)   | Yes      | Customer city of residence                       |
| Country       | VARCHAR(50)   | Yes      | Customer country of residence                    |
| Gender        | VARCHAR(50)   | Yes      | Gender code (e.g., 'F', 'M', or others)         |
| Date_Of_Birth | VARCHAR(50)   | Yes      | Date of birth in string format (dd-mm-yyyy)    |
| Job_Title     | VARCHAR(MAX)  | Yes      | Customer's job title                            |

---

### Table: bronze.discounts  
Raw discounts data with dates as strings.

| Column       | Data Type     | Nullable | Description                                |
|--------------|---------------|----------|--------------------------------------------|
| Start        | VARCHAR(50)   | Yes      | Discount start date in string format        |
| End          | VARCHAR(50)   | Yes      | Discount end date in string format          |
| Discont      | DECIMAL(2,1)  | Yes      | Discount percentage or rate                  |
| Description  | VARCHAR(50)   | Yes      | Discount description                         |
| Category     | VARCHAR(50)   | Yes      | Associated product category                   |
| SubCategory  | VARCHAR(50)   | Yes      | Associated product sub-category               |

---

### Table: bronze.employees  
Raw employee data.

| Column     | Data Type    | Nullable | Description                                   |
|------------|--------------|----------|-----------------------------------------------|
| EmployeeID | INT          | Yes      | Unique employee identifier                    |
| StoreID    | INT          | Yes      | Store identifier where employee works        |
| Name       | VARCHAR(50)  | Yes      | Employee full name                            |
| Position   | VARCHAR(50)  | Yes      | Employee job position                         |

---

### Table: bronze.products  
Raw product data with multilingual descriptions.

| Column         | Data Type    | Nullable | Description                                  |
|----------------|--------------|----------|----------------------------------------------|
| ProductID      | INT          | Yes      | Unique product identifier                     |
| Category       | VARCHAR(50)  | Yes      | Product category                              |
| SubCategory    | VARCHAR(50)  | Yes      | Product sub-category                          |
| DescriptionPT  | VARCHAR(50)  | Yes      | Portuguese product description                 |
| DescriptionDE  | VARCHAR(50)  | Yes      | German product description                      |
| DescriptionFR  | VARCHAR(50)  | Yes      | French product description                      |
| DescriptionES  | VARCHAR(50)  | Yes      | Spanish product description                     |
| DescriptionEN  | VARCHAR(50)  | Yes      | English product description                     |
| DescriptionZH  | VARCHAR(50)  | Yes      | Chinese product description                     |
| Color          | VARCHAR(50)  | Yes      | Product color                                 |
| Sizes          | VARCHAR(50)  | Yes      | Available sizes (pipe-separated in raw data)  |
| ProductionCost | DECIMAL(5,3) | Yes      | Cost of production                            |

---

### Table: bronze.stores  
Raw store data.

| Column            | Data Type   | Nullable | Description                               |
|-------------------|-------------|----------|-------------------------------------------|
| StoreID           | INT         | Yes      | Unique store identifier                   |
| Country           | VARCHAR(50) | Yes      | Store country                             |
| City              | VARCHAR(50) | Yes      | City where store is located               |
| StoreName         | VARCHAR(50) | Yes      | Store name                               |
| NumberofEmployees | INT         | Yes      | Number of employees at the store         |
| ZIPCode           | VARCHAR(50) | Yes      | Postal code                              |
| Latitude          | FLOAT       | Yes      | Latitude for store location               |
| Longitude         | FLOAT       | Yes      | Longitude for store location              |

---

### Table: bronze.transactions  
Raw sales and return transactions.

| Column          | Data Type     | Nullable | Description                                |
|-----------------|---------------|----------|--------------------------------------------|
| InvoiceID       | VARCHAR(50)   | Yes      | Invoice identifier                         |
| Line            | INT           | Yes      | Line number within invoice                 |
| CustomerID      | INT           | Yes      | Customer identifier (FK to bronze.customers) |
| ProductID       | INT           | Yes      | Product identifier (FK to bronze.products)    |
| Size            | VARCHAR(50)   | Yes      | Size of product sold                        |
| Color           | VARCHAR(50)   | Yes      | Color of product sold                       |
| UnitPrice       | DECIMAL(6,2)  | Yes      | Unit price of product                       |
| Quantity        | INT           | Yes      | Quantity of items sold                      |
| Date            | VARCHAR(50)   | Yes      | Transaction date as string (dd-mm-yyyy)    |
| Discount        | DECIMAL(3,2)  | Yes      | Discount applied on the transaction line   |
| LineTotal       | FLOAT         | Yes      | Total amount for the line                   |
| StoreID         | INT           | Yes      | Store identifier (FK to bronze.stores)     |
| EmployeeID      | INT           | Yes      | Employee identifier (FK to bronze.employees)|
| Currency        | VARCHAR(50)   | Yes      | Currency code                              |
| CurrencySymbol  | VARCHAR(50)   | Yes      | Currency symbol                            |
| SKU             | VARCHAR(50)   | Yes      | Stock-keeping unit identifier              |
| TransactionType | VARCHAR(50)   | Yes      | Type of transaction ('Sale' or 'Return')  |
| PaymentMethod   | VARCHAR(50)   | Yes      | Payment method used                        |
| InvoiceTotal    | FLOAT         | Yes      | Total invoice amount                       |

---

## Schema: lookup (Lookup Dimension Tables)

### Table: lookup.gender  
Gender reference table.

| Column              | Data Type    | Nullable | Description                         |
|---------------------|--------------|----------|-------------------------------------|
| Gender_key          | INT          | No       | Surrogate primary key               |
| Gender              | VARCHAR(50)  | No       | Gender code (e.g., 'F', 'M')       |
| Gender_discripption  | VARCHAR(50)  | No       | Description ('Female', 'Male', 'n/a') |

---

### Table: lookup.location  
City and associated country.

| Column        | Data Type    | Nullable | Description                                |
|---------------|--------------|----------|--------------------------------------------|
| Location_key  | INT          | No       | Surrogate primary key                      |
| City          | NVARCHAR(50) | No       | City name                                 |
| Country_id    | INT          | No       | FK to lookup.country                       |

---

### Table: lookup.positions  
Employee job positions.

| Column        | Data Type    | Nullable | Description                                  |
|---------------|--------------|----------|----------------------------------------------|
| Position_key  | INT          | No       | Surrogate primary key                        |
| Position_name | NVARCHAR(50) | No       | Name of the position (e.g., Manager, Clerk) |

---

### Table: lookup.country  
Country reference table.

| Column      | Data Type    | Nullable | Description                                  |
|-------------|--------------|----------|----------------------------------------------|
| Country_key | INT          | No       | Surrogate primary key                        |
| Country     | NVARCHAR(50) | No       | Country name                                |

---

### Table: lookup.category  
Product categories.

| Column       | Data Type    | Nullable | Description                                  |
|--------------|--------------|----------|----------------------------------------------|
| Category_key | INT          | No       | Surrogate primary key                        |
| Category_name| NVARCHAR(50) | No       | Category name                              |

---

### Table: lookup.sub_category  
Product sub-categories.

| Column           | Data Type    | Nullable | Description                                  |
|------------------|--------------|----------|----------------------------------------------|
| Sub_Category_key | INT          | No       | Surrogate primary key                        |
| Sub_Category_name| NVARCHAR(50) | No       | Sub-category name                          |

---

### Table: lookup.color  
Product colors.

| Column      | Data Type   | Nullable | Description                                  |
|-------------|-------------|----------|----------------------------------------------|
| Color_key   | INT         | No       | Surrogate primary key                        |
| Color_name  | VARCHAR(50) | No       | Color description                          |

---

### Table: lookup.currency  
Currencies used.

| Column         | Data Type    | Nullable | Description                                  |
|----------------|--------------|----------|----------------------------------------------|
| Currency_key   | INT          | No       | Surrogate primary key                        |
| Currency       | VARCHAR(50)  | No       | Currency code (e.g., USD)                    |
| CurrencySymbol | NVARCHAR     | Yes      | Currency symbol (e.g., $)                    |

---

### Table: lookup.payment_method  
Payment methods.

| Column          | Data Type    | Nullable | Description                                  |
|-----------------|--------------|----------|----------------------------------------------|
| PaymentMethod_key| INT          | No       | Surrogate primary key                        |
| PaymentMethod   | VARCHAR(50)  | No       | Method of payment (e.g., Credit Card)       |

---

### Table: lookup.sizes  
Product sizes.

| Column      | Data Type    | Nullable | Description                                  |
|-------------|--------------|----------|----------------------------------------------|
| Size_key    | INT          | No       | Surrogate primary key                        |
| Size        | NVARCHAR(50) | No       | Size description (e.g., S, M, L)            |

---

## Schema: silver (Dimension and Fact Tables)

### Table: silver.dim_customers  
Cleaned and enriched customer dimension.

| Column         | Data Type     | Nullable | Description                                     |
|----------------|---------------|----------|------------------------------------------------|
| customer_key   | INT           | No       | Surrogate key                                 |
| Customer_ID    | INT           | No       | Original customer ID                          |
| Name           | NVARCHAR(50)  | Yes      | Customer name                                |
| Email          | NVARCHAR(MAX) | Yes      | Email address                                |
| Telephone      | NVARCHAR(50)  | Yes      | Contact number                               |
| location_key   | INT           | No       | FK to lookup.location                         |
| Gender_key     | INT           | No       | FK to lookup.gender                           |
| Date_Of_Birth  | DATE          | Yes      | Converted date of birth                       |
| Job_Title      | VARCHAR(MAX)  | Yes      | Job title                                   |

---

### Table: silver.dim_discounts  
Discount dimension table with category references.

| Column           | Data Type     | Nullable | Description                                     |
|------------------|---------------|----------|------------------------------------------------|
| discount_key     | INT           | No       | Surrogate key                                 |
| Start            | DATE          | Yes      | Discount start date                           |
| End              | DATE          | Yes      | Discount end date                             |
| Discont          | FLOAT         | Yes      | Discount percentage                           |
| Description      | NVARCHAR(255) | Yes      | Description of discount                       |
| Category_key     | INT           | Yes      | FK to lookup.category                         |
| Sub_Category_key | INT           | Yes      | FK to lookup.sub_category                     |

---

### Table: silver.dim_stores  
Store dimension with location and country keys.

| Column              | Data Type     | Nullable | Description                                     |
|---------------------|---------------|----------|------------------------------------------------|
| store_key           | INT           | No       | Surrogate key                                 |
| Store_ID            | INT           | No       | Original store ID                             |
| country_key         | INT           | No       | FK to lookup.country                          |
| Location_key        | INT           | No       | FK to lookup.location                         |
| Store_Name          | NVARCHAR(50)  | Yes      | Store name                                   |
| Number_of_Employees | INT           | Yes      | Number of employees                           |
| ZIP_Code            | NVARCHAR(50)  | Yes      | Postal code                                  |
| Latitude            | FLOAT         | Yes      | Geographic latitude                           |
| Longitude           | FLOAT         | Yes      | Geographic longitude                          |

---

### Table: silver.dim_employees  
Employee dimension around positions and stores.

| Column        | Data Type     | Nullable | Description                                     |
|---------------|---------------|----------|------------------------------------------------|
| employee_key  | INT           | No       | Surrogate key                                 |
| Employee_ID   | INT           | No       | Original employee ID                          |
| Store_key    | INT            | No       | FK to silver.dim_stores                       |
| Name         | NVARCHAR(50)  | Yes      | Employee name                                |
| Position_key | INT            | No       | FK to lookup.positions                        |

---

### Table: silver.dim_products  
Product dimension with category, color, and size info.

| Column           | Data Type     | Nullable | Description                                     |
|------------------|---------------|----------|------------------------------------------------|
| product_key      | INT           | No       | Surrogate key                                 |
| Product_ID       | INT           | No       | Original product ID                           |
| Category_key     | INT           | No       | FK to lookup.category                         |
| Sub_Category_key | INT           | No       | FK to lookup.sub_category                     |
| Description_EN   | NVARCHAR(MAX) | Yes      | English product description                    |
| Color_key       | INT           | Yes      | FK to lookup.color                            |
| Sizes           | VARCHAR(50)   | Yes      | Sizes (comma separated)                       |
| Production_Cost | DECIMAL(5,3)  | Yes      | Production cost                              |

---

### Table: silver.dim_date  
Date dimension with calendar attributes.

| Column         | Data Type     | Nullable | Description                                     |
|----------------|---------------|----------|------------------------------------------------|
| date_key       | INT           | No       | Date key formatted as YYYYMMDD                 |
| date           | DATE          | No       | Calendar date                                 |
| year           | INT           | No       | Year part                                     |
| quarter        | INT           | No       | Quarter (1-4)                                 |
| month          | INT           | No       | Month (1-12)                                  |
| month_name     | NVARCHAR(20)  | No       | Month name (e.g., January)                     |
| day_of_month   | INT           | No       | Day of the month                              |
| day_of_week    | INT           | No       | Day of week number (Sunday=1)                 |
| weekday_name   | NVARCHAR(20)  | No       | Weekday name (e.g., Monday)                    |
| is_weekend     | BIT           | No       | 1 if weekend, 0 if weekday                    |
| week_of_year   | INT           | No       | Week number of the year                        |
| day_of_year    | INT           | No       | Day of the year (1-366)                        |

---

### Table: silver.fact_sales_transactions  
Fact table for sales transactions.

| Column           | Data Type     | Nullable | Description                                     |
|------------------|---------------|----------|------------------------------------------------|
| sales_transaction_key | INT       | No       | Surrogate key                                 |
| InvoiceID        | NVARCHAR(100)| Yes      | Invoice number                               |
| date_key         | INT           | No       | FK to silver.dim_date                         |
| Line             | INT           | Yes      | Line number in invoice                        |
| Customer_key     | INT           | Yes      | FK to silver.dim_customers                    |
| Product_key      | INT           | Yes      | FK to silver.dim_products                      |
| Size_key         | INT           | Yes      | FK to lookup.sizes                            |
| Color_key        | INT           | Yes      | FK to lookup.color                            |
| Category_key     | INT           | Yes      | FK to lookup.category                         |
| Sub_Category_key | INT           | Yes      | FK to lookup.sub_category                     |
| Store_key        | INT           | Yes      | FK to silver.dim_stores                       |
| Employee_key     | INT           | Yes      | FK to silver.dim_employees                     |
| Currency_key     | INT           | Yes      | FK to lookup.currency                         |
| PaymentMethod_key| INT           | Yes      | FK to lookup.payment_method                    |
| UnitPrice        | FLOAT         | Yes      | Unit price                                   |
| Quantity         | INT           | Yes      | Quantity sold                                |
| Discount         | FLOAT         | Yes      | Discount applied                             |
| discount_key     | INT           | Yes      | FK to silver.dim_discounts                    |
| LineTotal        | FLOAT         | Yes      | Extended line total (UnitPrice * Quantity - Discount) |
| InvoiceTotal     | FLOAT         | Yes      | Total invoice amount                         |

---

### Table: silver.fact_sales_return_transactions  
Fact table for sales return transactions.

| Column                 | Data Type     | Nullable | Description                                     |
|------------------------|---------------|----------|------------------------------------------------|
| sales_return_transaction_key| INT       | No       | Surrogate key                                 |
| InvoiceID              | NVARCHAR(100)| Yes      | Return invoice number                          |
| sales_InvoiceID        | NVARCHAR(100)| Yes      | Original sale invoice number                    |
| date_key               | INT           | No       | FK to silver.dim_date                          |
| Line                   | INT           | Yes      | Line number in invoice                         |
| Product_key            | INT           | Yes      | FK to silver.dim_products                      |
| Currency_key           | INT           | Yes      | FK to lookup.currency                          |
| PaymentMethod_key      | INT           | Yes      | FK to lookup.payment_method                    |
| UnitPrice              | FLOAT         | Yes      | Return unit price                              |
| Quantity               | INT           | Yes      | Quantity returned                             |
| LineTotal              | FLOAT         | Yes      | Return line total                             |
| InvoiceTotal           | FLOAT         | Yes      | Return invoice total                          |

---

# Notes:

- Nullable columns: Because your scripts don't specify NOT NULL constraints for most columns, nullable is marked as Yes unless it is a surrogate primary key.
- Foreign keys are highlighted where available to show relationships.
- Dimensions tables mostly have surrogate keys (integer auto-increment) for joins and data integrity.
- Sizes are stored as comma-separated values in silver products dimension (transformed from pipe-delimited raw input).
- Dates in bronze layers are strings and converted to proper DATE type in the silver schema.
- Discounts sometimes relate to categories and subcategories, maintained in dimension tables.
- Fact tables distinguish sales and returns, enabling separate analyses.

---

*This Data Dictionary is intended to facilitate understanding of your retail sales data warehouse schemas, aiding developers and analysts in using and maintaining the system.*

---

If you'd like, I can provide this as an actual `.md` file content you can copy-paste directly, or package instructions on how to add it into your repo. Just let me know!
