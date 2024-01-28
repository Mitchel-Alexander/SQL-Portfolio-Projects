-- Create database
CREATE DATABASE IF NOT EXISTS supermarket_sales;

USE supermarket_sales;

-- Create table
CREATE TABLE IF NOT EXISTS sales_data (
    Invoice_ID VARCHAR(50) PRIMARY KEY,
    Branch CHAR(1),
    City VARCHAR(50),
    Customer_type VARCHAR(50),
    Gender VARCHAR(10),
    Product_line VARCHAR(50),
    Unit_price DECIMAL(10, 2),
    Quantity INT,
    Tax_5_percent DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    Date DATE,
    Time TIME,
    Payment VARCHAR(50),
    cogs DECIMAL(10, 2),
    Gross_margin_percentage DECIMAL(10, 2),
    Gross_income DECIMAL(10, 2),
    Rating DECIMAL(10, 1)
);

-- Check successful data import 
SELECT * FROM sales_data;

-- ------------------- Exploratory Data Analysis ------------------- 

-- Sales Performance Analysis:

-- What are the total sales and average sales value per branch?
SELECT
	Branch, 
    SUM(Total) AS TotalSales, 
    AVG(Total) AS AverageSales
FROM
	supermarket_sales.sales_data
GROUP BY
	Branch; 

-- Which product line contributes the most to total revenue?
SELECT
	Product_line,
    SUM(Total) AS TotalRevenue
FROM 
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	TotalRevenue DESC;
    
-- Does this vary by branch or city?
SELECT
	Branch,
    City,
	Product_line,
    SUM(Total) As TotalRevenue
FROM
	supermarket_sales.sales_data
GROUP BY
	Branch, City, Product_line
ORDER BY
	Branch, City, TotalRevenue DESC;

-- How do sales differ by day of the week or time of day?
SELECT
	DAYOFWEEK(Date) AS DayOfWeek,
    DAYNAME(Date) As DayName, 
    SUM(Total) AS TotalSales, 
    AVG(Total) AS AverageSales
FROM
	supermarket_sales.sales_data
GROUP BY
	DayOfWeek, DayName
ORDER BY
	DayOfWeek;

SELECT
	HOUR(TIME) AS HourOfDay,
    SUM(Total) AS TotalSales, 
    AVG(Total) AS AverageSales
FROM
	supermarket_sales.sales_data
GROUP BY
	HourOfDay
ORDER BY
	HourOfDay;

-- Customer Behavior Insights:

-- What are the shopping patterns based on customer type (Member vs. Normal)?

-- Total and average sales by customer type.
SELECT
	Customer_type, 
    SUM(Total) AS TotalSales, 
    AVG(Total) AS AverageSales,
    AVG(Quantity) AS AverageQuantity
FROM
	supermarket_sales.sales_data
GROUP BY
	Customer_type;

-- Product line preferences by customer type. 
SELECT
	Customer_type, 
    Product_line, 
    SUM(Total) AS TotalSales, 
    AVG(Quantity) AS AverageQuantity
FROM
	supermarket_sales.sales_data
GROUP BY
	Customer_type, Product_line
ORDER BY
	Customer_type, TotalSales DESC;

-- Payment method preferences by customer type.
SELECT
	Customer_type, 
    Payment,
    COUNT(*) AS NumberOfTransactions, 
    SUM(Total) AS TotalSales
FROM 
	supermarket_sales.sales_data
GROUP BY
	Customer_type, Payment
ORDER BY
	Customer_type, TotalSales DESC;

-- Is there a gender difference in the types of products purchased or the amount spent?

-- Total and average sales by gender for each product line.
SELECT
	Gender, 
    Product_line, 
    SUM(Total) AS TotalSales,
    AVG(Total) AS AverageSales
FROM
	supermarket_sales.sales_data
GROUP BY
	Gender, Product_line
ORDER BY
	Gender, TotalSales DESC;

-- Quantity of products purchased by gender. 
SELECT
	Gender, 
    Product_line,
    SUM(Quantity) AS TotalQuantity
FROM
	supermarket_sales.sales_data
GROUP BY
	Gender, Product_line
ORDER BY
	GENDER, TotalQuantity DESC;

-- Frequency of purchase by gender. 
SELECT 
    Gender,
    Product_line,
    COUNT(*) AS NumberOfPurchases
FROM 
    supermarket_sales.sales_data
GROUP BY 
    Gender, Product_line
ORDER BY 
    Gender, NumberOfPurchases DESC;

-- What payment methods are most commonly used?
SELECT
	Payment, 
    COUNT(*) As NumberOfTransactions
FROM
	supermarket_sales.sales_data
GROUP BY
	Payment
ORDER BY
	NumberOfTransactions DESC;
    
-- Do these preferences differ by branch or product line?

-- Payment method preferences by branch.
SELECT
	Branch, 
    Payment,
    COUNT(*) AS NumberOfTransactions
FROM 
	supermarket_sales.sales_data
GROUP BY
	Branch, Payment
ORDER BY
	Branch, NumberOfTransactions DESC;

-- Payment method preferences by product line:
Select
	Product_line,
    Payment,
    COUNT(*) AS NumberOfTransactions
FROM supermarket_sales.sales_data
GROUP BY
	Product_line, Payment
ORDER BY
	Product_line, NumberOfTransactions DESC;

-- Product Analysis:

-- Which products have the highest and lowest sales volumes?

-- Product lines with the highest sales volumes.
SELECT
	Product_line,
    SUM(Quantity) AS TotalQuantitySold
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	TotalQuantitySold DESC;

-- Product lines withthe lowest sales volumes. 
SELECT
	Product_line, 
    SUM(Quantity) AS TotalQuantitySold
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	TotalQuantitySold ASC;

-- What is the average unit price of products sold?
-- How does it vary across different product lines?
SELECT
	Product_line, 
    AVG(Unit_price) AS AverageUnitPrice
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	AverageUnitPrice DESC;

-- Are there certain product lines that have particularly high or low ratings?

-- Average ratings for each product line.
SELECT 
    Product_line,
    AVG(Rating) AS AverageRating
FROM 
    supermarket_sales.sales_data
GROUP BY 
    Product_line
ORDER BY 
    AverageRating DESC;

-- Identifying the highest rated product lines. 
SELECT
	Product_line, 
    AVG(Rating) AS AverageRating
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	AverageRating DESC
LIMIT 5;

-- Identifying the lowest rated product lines.
SELECT
	Product_line,
    AVG(Rating) AS AverageRating
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	AverageRating ASC
LIMIT 5;

-- Profitability and Margin Analysis:

-- What is the gross income generated by each product line?
SELECT
	Product_line,
    SUM(gross_income) AS TotalGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	TotalGrossIncome DESC;

-- Which produce lines are the most profitable
SELECT
	Product_line, 
    SUM(gross_income) AS TotalGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line
ORDER BY
	TotalGrossIncome DESC;

-- How do gross margin percentages compare across different branches?
SELECT
	Branch,
    AVG(gross_margin_percentage) AS AverageGrossMarginPercentage
FROM
	supermarket_sales.sales_data
GROUP BY
	Branch
ORDER BY
	AverageGrossMarginPercentage DESC;

-- Analyze the correlation between gross income and other factors
-- like customer type, time of purchase, or payment method.

-- Gross income and customer type. 
SELECT
	Customer_type, 
    SUM(gross_income) AS TotalGrossIncome,
    AVG(gross_income) AS AverageGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	Customer_type;

-- Gross income by time of purchase.
SELECT
	HOUR(Time) AS HourOfDay, 
    SUM(gross_income) AS TotalGrossIncome, 
    AVG(gross_income) AS AverageGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	HourOfDay
ORDER BY
	HourOfDay;

-- Gross income and payment method.
SELECT
	Payment,
    SUM(gross_income) AS TotalGrossIncome,
    AVG(gross_income) AS AverageGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	Payment;

-- Relationship between customer ratings and gross income.
SELECT
	Product_line,
    AVG(Rating) AS AverageRating, 
    SUM(gross_income) AS TotalGrossIncome
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line;

-- Relationship between customer ratings and quantity of products solc.
SELECT
	Product_line,
    AVG(Rating) AS AverageRating,
    SUM(Quantity) AS TotalQuantitySold
FROM
	supermarket_sales.sales_data
GROUP BY
	Product_line;
    
-- Revenue and Profit Calculations:

-- Calculating COGS, VAT, Total (Gross Sales), and Gross Profit (Gross Income) 
-- for Each Transaction.
SELECT 
    Unit_price,
    Quantity,
    Unit_price * Quantity AS COGS, -- COGS Calculation
    (Unit_price * Quantity) * 0.05 AS VAT, -- VAT Calculation
    (Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05) AS Total, -- Total Calculation
    ((Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05)) - (Unit_price * Quantity) AS GrossProfit -- Gross Profit Calculation
FROM 
    supermarket_sales.sales_data;

-- Calculating Gross Margin Percentage
SELECT 
    SUM(((Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05)) - (Unit_price * Quantity)) / SUM((Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05)) AS GrossMarginPercentage
FROM 
    supermarket_sales.sales_data;

-- Breakdown by Product Line or Other Categories 
SELECT 
    Product_line,
    SUM(Unit_price * Quantity) AS TotalCOGS,
    SUM((Unit_price * Quantity) * 0.05) AS TotalVAT,
    SUM((Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05)) AS TotalRevenue,
    SUM(((Unit_price * Quantity) + ((Unit_price * Quantity) * 0.05)) - (Unit_price * Quantity)) AS TotalGrossProfit
FROM 
    supermarket_sales.sales_data
GROUP BY 
    Product_line;

	
    


    



    
    

    





    

    




    



 

    
    

    
    


    


    
    

    
    


    



    









