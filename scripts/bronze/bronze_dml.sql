--inserting the data into bronze.transactions table
BULK INSERT bronze.transactions
FROM 'D:\Learning\Projects\global-fashion-retail-sales\raw-data\global-fashion-retail-sales\transactions.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    FORMAT = 'CSV'
);
