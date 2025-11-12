SHOW TABLES;

DESCRIBE walmart_sales;-- check column names and types

/* CREATE TABLE walmart_sales_clean AS SELECT CAST(Store AS SIGNED) AS Store,
    CASE
        WHEN Date LIKE '%/%/%' THEN STR_TO_DATE(Date, '%m/%d/%Y')
        WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
        ELSE NULL
    END AS Date,
    CAST(Weekly_Sales AS DECIMAL (15 , 2 )) AS Weekly_Sales,
    CAST(Holiday_Flag AS UNSIGNED) AS Holiday_Flag,
    CAST(Temperature AS DECIMAL (5 , 2 )) AS Temperature,
    CAST(Fuel_Price AS DECIMAL (5 , 2 )) AS Fuel_Price,
    CAST(CPI AS DECIMAL (10 , 6 )) AS CPI,
    CAST(Unemployment AS DECIMAL (5 , 2 )) AS Unemployment FROM
    walmart_sales;
    */

SELECT 
    Date
FROM
    walmart_sales_clean
LIMIT 10;
DESCRIBE walmart_sales_clean;

-- Summarize Data
SELECT 
    Store, SUM(Weekly_Sales) AS Total_Sales
FROM
    walmart_sales_clean
GROUP BY Store
ORDER BY Total_Sales DESC;

-- Total Sales by Date
SELECT 
    Date, SUM(Weekly_Sales) AS Total_Sales
FROM
    walmart_sales_clean
GROUP BY Date
ORDER BY Date;

-- Average sales: Holiday vs Non-Holiday
SELECT 
    Holiday_Flag, AVG(Weekly_Sales) AS Avg_Sales
FROM
    walmart_sales_clean
GROUP BY Holiday_Flag;

-- check if there's missing value
SELECT *
FROM walmart_sales_clean
WHERE Weekly_Sales IS NULL
   OR Temperature IS NULL
   OR Fuel_Price IS NULL;
   
   -- Best performing week per store
   SELECT Store, Date, Weekly_Sales
FROM walmart_sales_clean
WHERE (Store, Weekly_Sales) IN (
    SELECT Store, MAX(Weekly_Sales)
    FROM walmart_sales_clean
    GROUP BY Store
);

-- Month-level trend
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Weekly_Sales) AS Monthly_Sales
FROM walmart_sales_clean
GROUP BY Month
ORDER BY Month;

-- Store Performance
SELECT Store, SUM(Weekly_Sales) AS Total_Sales
FROM walmart_sales_clean
GROUP BY Store
ORDER BY Total_Sales DESC
LIMIT 5;

-- Temperature vs Weekly Sales. This is to know if weather affect sales
SELECT 
    CASE 
        WHEN Temperature < 40 THEN 'Cold'
        WHEN Temperature BETWEEN 40 AND 70 THEN 'Moderate'
        ELSE 'Hot'
    END AS Weather_Group,
    AVG(Weekly_Sales) AS Avg_Sales
FROM walmart_sales_clean
GROUP BY Weather_Group;

-- Highest sales during holiday weeks
SELECT Date, Weekly_Sales
FROM walmart_sales_clean
WHERE Holiday_Flag = 1
ORDER BY Weekly_Sales DESC
LIMIT 10;

-- Is unemployment related to low sales?
SELECT 
    Unemployment,
    AVG(Weekly_Sales) AS Avg_Sales
FROM walmart_sales_clean
GROUP BY Unemployment
ORDER BY Unemployment;

-- 


