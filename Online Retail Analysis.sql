
													-- Data Understanding 

/*Finding the location for mySQL private files */
SHOW VARIABLES LIKE 'secure_file_priv';

/* Created a staging table after viewing data types on Excel */
CREATE TABLE online_retail_staging(
	InvoiceNo VARCHAR(20),
	StockCode VARCHAR(20),
	Description TEXT,
	Quantity INT,
	InvoiceDate VARCHAR(25),
	UnitPrice DECIMAL(10,2),
	CustomerID VARCHAR(20),
	Country VARCHAR(100)
);

/* Loaded staging table into mySWL private file */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OnlineRetail.csv'
INTO TABLE online_retail_staging
CHARACTER SET latin1 -- permitted use of characters otherwise viewed as invalid
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

/* Count if total rows of staging table*/
SELECT 
	COUNT(*) 
FROM online_retail_staging AS count;

/* Final table creation */
CREATE TABLE online_retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT NULL,
    Country VARCHAR(100)
);

/*Inserting cleaned data into final table */
INSERT INTO online_retail
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'), -- convert string to date
    UnitPrice,
    NULLIF(CustomerID, ''), -- null in empty rows
    Country
FROM online_retail_staging;

/* Cross-check count of final table */
SELECT 
	COUNT(*) 
FROM online_retail AS count_of_rows;

SELECT *
FROM online_retail
LIMIT 50;

SELECT
	MIN(Quantity) As MinimumQuantity,
    MAX(Quantity) As MaximumQuantity
FROM online_retail;

/* Number of Individual Countries*/
SELECT 
	COUNT(*),
	Country
FROM online_retail
GROUP BY country;  -- 495478 count for UK, 8557 for France

											-- Data Preparation

/* Filter out UK*/
CREATE TABLE online_retail_UK AS
SELECT *
FROM online_retail
WHERE Country = "United Kingdom";

/* Filter out France */
CREATE TABLE online_retail_Fr AS
SELECT *
FROM online_retail
WHERE Country = "France";

SELECT *
FROM online_retail_Fr
LIMIT 50;

SELECT 
	COUNT(*),
    InvoiceNo
FROM online_retail_Fr
GROUP BY InvoiceNo;

DELETE FROM online_retail_Fr
WHERE InvoiceNo LIKE 'C%'; -- filters out rows with values starting with cache index

SELECT
	MIN(Quantity) As MinimumQuantity,
    MAX(Quantity) As MaximumQuantity
FROM online_retail_Fr; -- quantities of only sold (non-returned)

SELECT 
	COUNT(*) AS TotalCount
FROM online_retail_fr;

/* Add Revenue column */
ALTER TABLE online_retail_Fr
ADD COLUMN Revenue DECIMAL(10,2) 
AS (Quantity * UnitPrice); -- Creating a calculated field


							-- Descriptive Analytics
                            
/* Top 10 Bestselling Products*/
SELECT
	Description AS ProductName,
    SUM(Quantity) AS TotalQuantitySold
FROM online_retail_fr
GROUP BY Description
ORDER BY TotalQUantitySold DESC
LIMIT 10;

/* Top 10 Revenue Products*/
SELECT
	Description AS ProdcutName,
    SUM(Revenue) AS TotalSales
FROM online_retail_fr
GROUP BY Description
ORDER BY TotalSales desc
LIMIT 10;

/* Sales by Hour */
SELECT
	HOUR(InvoiceDate) AS Hour,
    SUM(Revenue) AS TotalSales
FROM online_retail_Fr
GROUP BY Hour
ORDER BY Hour; -- makes output easier to read

/* Sales by Day of Week*/
SELECT
	DAYOFWEEK(InvoiceDate) AS DayOfWeek,
    SUM(Revenue) AS TotalSales
FROM online_retail_Fr
GROUP BY DayOfWeek
ORDER BY DayOfWeek; -- No sales on Saturdays



