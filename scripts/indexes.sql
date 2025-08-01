
CREATE nonclustered INDEX Idx_category_name on lookup.category (Category_name)

CREATE nonclustered INDEX Idx_color_name on lookup.color ([Color_name])

CREATE nonclustered INDEX Idx_country_name on [lookup].[country] ([Country])

CREATE nonclustered INDEX Idx_city on [lookup].[location] ([City])

CREATE nonclustered INDEX Idx_payment_method on [lookup].[payment_method] ([PaymentMethod])

CREATE nonclustered INDEX Idx_subcategory on [lookup].[sub_category] ([Sub_Category_name])

CREATE nonclustered INDEX Idx_customer_name on [silver].[dim_customers] ([Customer_ID],[Name])

CREATE nonclustered INDEX Idx_customer_location on [silver].[dim_customers] ([location_key])

CREATE nonclustered INDEX Idx_customer_gender on [silver].[dim_customers] ([Gender_key])

CREATE nonclustered INDEX Idx_dimdate on [silver].[dim_date] ([date])

CREATE nonclustered INDEX Idx_dimyear on [silver].[dim_date] ([year])

CREATE nonclustered INDEX Idx_discount_category on [silver].[dim_discounts] ([Category_key])

CREATE nonclustered INDEX Idx_discount on [silver].[dim_discounts] ([Discont])

CREATE nonclustered INDEX Idx_employee on [silver].[dim_employees] ([Store_key])

CREATE nonclustered INDEX Idx_employee_name on [silver].[dim_employees] ([Name])

CREATE nonclustered INDEX Idx_products_category on [silver].[dim_products] ([Category_key])

CREATE nonclustered INDEX Idx_products_subcategory on [silver].[dim_products] ([Sub_Category_key])

CREATE nonclustered INDEX Idx_products_color on [silver].[dim_products] ([Color_key])

CREATE nonclustered INDEX Idx_store_country on [silver].[dim_stores] ([country_key])

CREATE nonclustered INDEX Idx_store_location on [silver].[dim_stores] ([Location_key])

CREATE nonclustered INDEX Idx_store_name on [silver].[dim_stores] ([Store_Name])

CREATE nonclustered INDEX Idx_sales_return_date on [silver].[fact_sales_return_transactions] ([date_key])

CREATE nonclustered INDEX Idx_sales_return_product on [silver].[fact_sales_return_transactions] ([Product_key])

CREATE nonclustered INDEX Idx_sales_return_currency on [silver].[fact_sales_return_transactions] ([Currency_key])

CREATE nonclustered INDEX Idx_sales_return_paymentmethod on [silver].[fact_sales_return_transactions] ([PaymentMethod_key])

CREATE nonclustered INDEX Idx_sales_return_filters on [silver].[fact_sales_return_transactions] ([date_key],[Product_key])
INCLUDE ([UnitPrice],[Quantity],[LineTotal],[InvoiceTotal])

CREATE nonclustered INDEX Idx_sales_date on [silver].[fact_sales_transactions] ([date_key])

CREATE nonclustered INDEX Idx_sales_customer on [silver].[fact_sales_transactions] ([Customer_key])

CREATE nonclustered INDEX Idx_sales_product on [silver].[fact_sales_transactions] ([Product_key])

CREATE nonclustered INDEX Idx_sales_size on [silver].[fact_sales_transactions] ([Size_key])

CREATE nonclustered INDEX Idx_sales_color on [silver].[fact_sales_transactions] ([Color_key])

CREATE nonclustered INDEX Idx_sales_category on [silver].[fact_sales_transactions] ([Category_key])

CREATE nonclustered INDEX Idx_sales_subcategory on [silver].[fact_sales_transactions] ([Sub_Category_key])

CREATE nonclustered INDEX Idx_sales_store on [silver].[fact_sales_transactions] ([Store_key])

CREATE nonclustered INDEX Idx_sales_employee on [silver].[fact_sales_transactions] ([Employee_key])

CREATE nonclustered INDEX Idx_sales_currency on [silver].[fact_sales_transactions] ([Currency_key])

CREATE nonclustered INDEX Idx_sales_paymentmethod on [silver].[fact_sales_transactions] ([PaymentMethod_key])

CREATE nonclustered INDEX Idx_sales_discount on [silver].[fact_sales_transactions] ([discount_key])

CREATE nonclustered INDEX Idx_sales_filters on [silver].[fact_sales_transactions] ([date_key],[Product_key],[Store_key])
INCLUDE ([UnitPrice],[Quantity],[Discount],[LineTotal],[InvoiceTotal])

CREATE nonclustered INDEX [Idx_customer_composite] on [silver].[dim_customers] ([customer_key]) INCLUDE ([Name],[Date_Of_Birth],[Job_Title])

CREATE nonclustered INDEX [Idx_location_composite] on [lookup].[location] ([Location_key]) INCLUDE ([City])
