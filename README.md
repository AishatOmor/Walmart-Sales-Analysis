# Walmart-Sales-Analysis
Walmart Sales Analysis  This repository contains SQL queries to analyze Walmart sales data, including data cleaning, summarization, and exploratory analysis to uncover trends, store performance, and the impact of external factors such as holidays, weather, and unemployment.

# Dataset
The dataset is from Kaggle: Walmart Sales https://www.kaggle.com/datasets/mikhail1681/walmart-sales
.
# Steps to use the dataset:
- Download walmart_sales.csv from Kaggle.
- Load it into your MySQL database:

# Example: Load CSV into MySQL
- LOAD DATA INFILE '/path/to/walmart_sales.csv'
- INTO TABLE walmart_sales
- FIELDS TERMINATED BY ',' 
- ENCLOSED BY '"'
- LINES TERMINATED BY '\n'
- IGNORE 1 ROWS;

# Data Cleaning
- Check existing tables
- SHOW TABLES;

- Check column names and types
- DESCRIBE walmart_sales;

- Create a cleaned version of the dataset
/* 
- CREATE TABLE walmart_sales_clean AS 
- SELECT 
 -    CAST(Store AS SIGNED) AS Store,
 -    CASE
    -     WHEN Date LIKE '%/%/%' THEN STR_TO_DATE(Date, '%m/%d/%Y')
     -    WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
     -    ELSE NULL
  -   END AS Date,
  -   CAST(Weekly_Sales AS DECIMAL(15,2)) AS Weekly_Sales,
  -   CAST(Holiday_Flag AS UNSIGNED) AS Holiday_Flag,
    - CAST(Temperature AS DECIMAL(5,2)) AS Temperature,
   -  CAST(Fuel_Price AS DECIMAL(5,2)) AS Fuel_Price,
   -  CAST(CPI AS DECIMAL(10,6)) AS CPI,
   -  CAST(Unemployment AS DECIMAL(5,2)) AS Unemployment 
- FROM walmart_sales;
*/

# Basic Exploration
-  Preview the cleaned data
- SELECT Date
- FROM walmart_sales_clean
- LIMIT 10;

- Check the structure
- DESCRIBE walmart_sales_clean;

# Sales Summary
- Total sales by store
- SELECT Store, SUM(Weekly_Sales) AS Total_Sales
- FROM walmart_sales_clean
- GROUP BY Store
- ORDER BY Total_Sales DESC;

# Total sales by date
- SELECT Date, SUM(Weekly_Sales) AS Total_Sales
- FROM walmart_sales_clean
- GROUP BY Date
- ORDER BY Date;

# Average sales: Holiday vs Non-Holiday
- SELECT Holiday_Flag, AVG(Weekly_Sales) AS Avg_Sales
- FROM walmart_sales_clean
- GROUP BY Holiday_Flag;

# Data Quality Check
- Check for missing values
- SELECT *
- FROM walmart_sales_clean
- WHERE Weekly_Sales IS NULL
 -   OR Temperature IS NULL
  -  OR Fuel_Price IS NULL;

# Performance Analysis
## Best performing week per store
- SELECT Store, Date, Weekly_Sales
- FROM walmart_sales_clean
- WHERE (Store, Weekly_Sales) IN (
 -    SELECT Store, MAX(Weekly_Sales)
 -    FROM walmart_sales_clean
  -   GROUP BY Store
);

#  Month-level sales trend
- SELECT DATE_FORMAT(Date, '%Y-%m') AS Month,
-        SUM(Weekly_Sales) AS Monthly_Sales
- FROM walmart_sales_clean
- GROUP BY Month
- ORDER BY Month;

# Top 5 stores by total sales
- SELECT Store, SUM(Weekly_Sales) AS Total_Sales
- FROM walmart_sales_clean
- GROUP BY Store
- ORDER BY Total_Sales DESC
- LIMIT 5;

# Exploratory Analysis
## Weekly sales by weather group
- SELECT CASE 
  -          WHEN Temperature < 40 THEN 'Cold'
   -         WHEN Temperature BETWEEN 40 AND 70 THEN 'Moderate'
   -         ELSE 'Hot'
   -     END AS Weather_Group,
   -     AVG(Weekly_Sales) AS Avg_Sales
- FROM walmart_sales_clean
   GROUP BY Weather_Group;

# Highest sales during holiday weeks
- SELECT Date, Weekly_Sales
- FROM walmart_sales_clean
- WHERE Holiday_Flag = 1
- ORDER BY Weekly_Sales DESC
- LIMIT 10;

# Relation between unemployment and sales
- SELECT Unemployment,
   -     AVG(Weekly_Sales) AS Avg_Sales
- FROM walmart_sales_clean
- GROUP BY Unemployment <img width="1056" height="549" alt="image" src="https://github.com/user-attachments/assets/b4eb685d-b821-4650-99eb-fde9fb8db408" />

<img width="877" height="604" alt="image" src="https://github.com/user-attachments/assets/e1e140ba-11aa-4321-be31-349d44c9e4c7" />
<img width="662" height="604" alt="image" src="https://github.com/user-attachments/assets/ffdfa37b-57c8-45d4-9323-25267ad90ea7" />
<img width="792" height="605" alt="image" src="https://github.com/user-attachments/assets/ccbf106d-9167-4e97-93d1-996a8348c64e" />




ORDER BY Unemployment;

Notes
