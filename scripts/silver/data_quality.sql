--checking duplicates
select 
	Customer_id,
	count(*)
from bronze.customers
group by Customer_id
having count(*) > 1
--checking trailing and leading spaces
select
	*
from bronze.customers
where trim(Job_Title) <> Job_Title
--data standardization of Gender column
select 
	CASE WHEN Gender = 'F' THEN 'Female'
		 WHEN Gender = 'M' THEN 'Male'
		 ELSE 'n/a'
	END AS Gender
from bronze.customers
-------------------bronze.discounts
SELECT *
FROM bronze.discounts
WHERE Description <> TRIM(Description)

SELECT
*
FROM bronze.transactions
WHERE 
TransactionType = 'Sale'
AND ABS(LineTotal - ((1-Discount)*(Quantity*UnitPrice)))>0.01