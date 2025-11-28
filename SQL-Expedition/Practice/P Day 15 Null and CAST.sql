-- ==========================================
-- DATASET: E-Commerce Inventory & Orders
-- ==========================================

-- 1. Create Products Table (Contains Data Type issues & NULLs)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price_Text VARCHAR(20),      -- PROBLEM: Price stored as Text!
    StockQuantity INT,           -- Contains 0s (Division risk)
    DiscountPercent DECIMAL(5,2) -- Contains NULLs (No discount)
);

-- 2. Create Customers Table (Contains Hierarchy issues for COALESCE)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),          -- Contains NULLs
    ShippingAddress VARCHAR(150),
    BillingAddress VARCHAR(150)
);

-- 3. Create Orders Table (Contains DateTime for casting)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDateTime DATETIME,      -- Needs casting to DATE
    TotalAmount DECIMAL(10,2)    -- Contains NULLs (failed transactions)
);

-- ==========================================
-- INSERTING DATA
-- ==========================================

INSERT INTO Products VALUES
(1, 'Gaming Laptop', '1200.00', 10, 0.10),
(2, 'Wireless Mouse', '25.50', 50, NULL),
(3, 'Mechanical Keyboard', '150.00', 0, 0.05),
(4, 'HDMI Cable', '10', 100, NULL),
(5, 'Monitor Stand', 'Unknown', 15, 0.00),

(6, 'USB-C Charger', '45.99', 40, NULL),
(7, 'Laptop Cooling Pad', 'Invalid', 20, 0.15),
(8, 'Bluetooth Speaker', '75.00', 0, 0.05),
(9, '4K Monitor', '350.50', 25, NULL),
(10, 'Webcam HD', '59', 30, 0.10),

(11, 'Desk Lamp', 'NULL', 60, NULL),
(12, 'Portable SSD', '99.90', 0, 0.08),
(13, 'Smartwatch Band', '12.00', 150, NULL),
(14, 'VR Headset', '499.99', 5, 0.12),
(15, 'Graphics Tablet', 'text', 8, NULL),

(16, 'Noise Cancelling Headphones', '220.00', 18, 0.20),
(17, 'USB Hub', '18.50', 0, NULL),
(18, 'Ethernet Cable', '5', 200, 0.02),
(19, 'Gaming Chair', '175.00', 7, NULL),
(20, 'LED Strip', 'Unknown', 80, 0.05);

INSERT INTO Customers VALUES
(101, 'Alice Smith', 'alice@example.com', '123 Main St', '123 Main St'),
(102, 'Bob Jones', NULL, NULL, '456 Corporate Blvd'),
(103, 'Charlie Brown', 'charlie@test.com', NULL, NULL),
(104, 'Diana Prince', NULL, '789 Island Rd', '789 Island Rd'),

(105, 'Ethan Hunt', 'ethan@imf.com', '12 Spy Ln', NULL),
(106, 'Fiona Glenanne', NULL, NULL, NULL),
(107, 'George Wilson', 'george@mail.com', '88 Street Rd', '22 Market Ln'),
(108, 'Hannah Baker', 'hannah@school.com', NULL, NULL),

(109, 'Ian Carter', 'ian@workmail.com', '12 Lakeview', '12 Lakeview'),
(110, 'Jane Foster', NULL, '200 Asgard Blvd', NULL),
(111, 'Kyle Rayner', 'kyle@lantern.com', NULL, '12 Space St'),
(112, 'Laura Palmer', NULL, NULL, NULL),

(113, 'Mark Spencer', 'mark@food.com', '45 Maple Dr', '45 Maple Dr'),
(114, 'Nina Brooks', NULL, '88 Palm Ave', '88 Palm Ave'),
(115, 'Oliver Queen', 'oliver@arrow.com', NULL, NULL),
(116, 'Pam Beesly', 'pam@office.com', '172 Scranton Rd', NULL),

(117, 'Quinn Hall', NULL, NULL, NULL),
(118, 'Rachel Green', 'rachel@fashion.com', NULL, NULL),
(119, 'Steve Rogers', NULL, 'Brooklyn St', 'Brooklyn St'),
(120, 'Tony Stark', 'tony@stark.com', '10880 Malibu Point', NULL);

INSERT INTO Orders VALUES
(1001, 101, '2024-01-15 08:30:00', 1200.00),
(1002, 101, '2024-01-15 14:45:00', 25.50),
(1003, 102, '2024-02-10 10:00:00', NULL),
(1004, 103, '2024-02-11 18:20:00', 150.00),

(1005, 104, '2024-02-15 09:10:00', 10.00),
(1006, 105, '2024-02-16 11:50:00', 75.00),
(1007, 106, '2024-02-17 16:25:00', NULL),
(1008, 107, '2024-02-18 13:40:00', 499.99),

(1009, 108, '2024-03-01 10:05:00', 18.50),
(1010, 109, '2024-03-01 11:22:00', NULL),
(1011, 110, '2024-03-02 09:00:00', 350.50),
(1012, 111, '2024-03-02 14:45:00', NULL),

(1013, 112, '2024-03-05 17:15:00', 59.00),
(1014, 113, '2024-03-06 08:30:00', 175.00),
(1015, 114, '2024-03-07 20:10:00', NULL),
(1016, 115, '2024-03-08 07:45:00', 499.99),

(1017, 116, '2024-03-10 18:20:00', 12.00),
(1018, 117, '2024-03-11 08:50:00', NULL),
(1019, 118, '2024-03-12 19:30:00', 220.00),
(1020, 119, '2024-03-13 21:45:00', NULL),

(1021, 120, '2024-04-01 10:10:00', 350.50),
(1022, 101, '2024-04-02 11:00:00', 75.00),
(1023, 103, '2024-04-03 12:30:00', NULL),
(1024, 104, '2024-04-03 14:00:00', 10.00),

(1025, 107, '2024-04-04 15:00:00', 150.00),
(1026, 108, '2024-04-05 16:20:00', NULL),
(1027, 109, '2024-04-06 18:00:00', 45.99),
(1028, 110, '2024-04-07 19:30:00', NULL),

(1029, 111, '2024-04-08 20:10:00', 75.00),
(1030, 112, '2024-04-09 07:40:00', 18.50),
(1031, 113, '2024-04-10 08:55:00', NULL),
(1032, 114, '2024-04-11 09:10:00', 12.00),

(1033, 115, '2024-04-12 11:45:00', 499.99),
(1034, 116, '2024-04-13 13:20:00', NULL),
(1035, 117, '2024-04-14 14:35:00', 59.00),
(1036, 118, '2024-04-15 16:00:00', 220.00),

(1037, 119, '2024-04-16 17:20:00', NULL),
(1038, 120, '2024-04-17 18:30:00', 175.00),
(1039, 101, '2024-04-18 19:50:00', NULL),
(1040, 102, '2024-04-19 21:10:00', 350.50);

######################################################### Practie ######################################################### 
-- IFNULL (Null To VALUE)
SELECT 
	emp_name,
    salary,
	Bonus,
    (salary + Bonus) as Raw_total,
    (salary + ifnull(bonus,0)) as Fixed_Total
FROM sales.employees;

-- Handling Null in aggrigate function
SELECT 
	OrderID ,
	TotalAmount,
    AVG(TotalAmount) OVER () as AVG_Total_1,
    AVG(ifnull(TotalAmount,0)) OVER () as AVG_Total_2
FROM data.orders;

-- COALESCE (Null To VALUE)
SELECT 
	FullName, 
	COALESCE(ShippingAddress,BillingAddress,'N/A') AS Adsress
FROM data.customers;

-- Null handling with string
SELECT 	
	FullName,
    Email,
    concat(FullName ,' ', coalesce(Email,'')) as Name_Email
FROM data.customers;

-- Handling Null With case
SELECT 	
	FullName,
	CASE WHEN Email IS NULL THEN 'N/A' ELSE Email END as Mail
FROM data.customers;

-- NULLIF (VALUE TO NULL)
SELECT CustomerID, nullif(ShippingAddress,BillingAddress) as adress
FROM data.customers;

SELECT 
	CustomerID,
	nullif(ShippingAddress,BillingAddress) as AddressCheck
FROM data.customers;

-- CAST & CONVERT
SELECT cast("15.50" as DECIMAL(10,2)) * 2;
	
SELECT 100 * '554' as Total;

SELECT
    CAST(ShipmentTime AS DATE) AS Just_The_Date
FROM timedb.shipments;


######################################################### Practie ######################################################### 
-- =============================================================
-- 20 PRACTICE QUESTIONS: NULLS & CONVERSION
-- Dataset: Products, Customers, Orders
-- =============================================================

-- PART 1: Filtering Nulls (IS NULL / IS NOT NULL)

-- Q1: Write a query to find all Customers who do not have an Email address recorded.
SELECT * FROM data.customers
WHERE Email is NUll;
-- Q2: Write a query to list all Products that actually have a DiscountPercent (i.e., not NULL).
SELECT * FROM data.products
WHERE DiscountPercent is  NOT NULL;
-- Q3: Find all Orders where the TotalAmount is missing (NULL), indicating a failed transaction.
SELECT * FROM data.orders
WHERE TotalAmount iS NULL;

-- Q4: List all Customers who have both a ShippingAddress AND a BillingAddress (neither should be NULL).
SELECT * FROM data.customers
WHERE ShippingAddress is not null and BillingAddress is not null;

-- PART 2: Replacing Nulls (IFNULL / COALESCE)
---------------------------------------------------------

-- Q5: Select ProductName and DiscountPercent. If the discount is NULL, display it as 0.00 using IFNULL.
SELECT ProductName,ifnull(DiscountPercent,0.00) as DiscountPercent
FROM data.products;

-- Q6: Select OrderID and TotalAmount. If TotalAmount is NULL, display '0.00' so we can sum it up later without losing data.
select OrderID,ifnull(TotalAmount,0.00) as Fix_total from data.orders;

-- Q7: (The Hierarchy Check) Select CustomerID and a column 'PrimaryAddress'. 
--     Logic: Check ShippingAddress first. If NULL, check BillingAddress. If both are NULL, return 'Head Office'.
SELECT 
	CustomerID,
	coalesce(ShippingAddress,BillingAddress,'Head Office') as PrimaryAddress
FROM data.customers;

-- Q8: Calculate the 'Final Price' for each product. Logic: Price - (Price * Discount). 
--     Important: You must handle the NULL discounts as 0, otherwise the math will result in NULL.
SELECT 
	ProductID,
	ProductName,
    Price_Text - (Price_Text * ifnull(DiscountPercent,0)) as Final_Price
FROM data.products;

-- PART 3: Value-to-Null (NULLIF) & Logic
-- Q9: We want to compare addresses. Select CustomerID. Create a column 'SameAddressCheck'.
--     It should return NULL if ShippingAddress equals BillingAddress, otherwise return the ShippingAddress.
SELECT 
	CustomerID,
    NULLIF(ShippingAddress,BillingAddress) as SameAddressCheck
FROM data.customers;

-- Q10: (Division Safety) Calculate 'Price per Stock Unit' (Price / StockQuantity).
--      Use NULLIF on StockQuantity to avoid a "Division by Zero" error for ProductID 3 (which has 0 stock).
SELECT 
	ProductID,
    NULLIF(StockQuantity, 0) as StockQuantity
FROM data.products;

-- PART 4: Data Type Conversion (CAST / CONVERT)
-- Q11: The 'Price_Text' is a string. Write a query to display ProductName and the Price CAST as a DECIMAL(10,2).
--      (Filter out 'Unknown' prices first to avoid errors).
SELECT 
	ProductName,
    CAST(Price_Text as DECIMAL(10,2)) as Price
FROM data.products;

-- Q12: We need to do math. Calculate Total Inventory Value (Price * StockQuantity). 
--      You MUST CAST the Price_Text to a number to do this calculation.
SELECT CAST(Price_Text as DECIMAL(10,2)) * StockQuantity as "Total Inventory"
FROM data.products;

-- Q13: Extract just the DATE (YYYY-MM-DD) from the 'OrderDateTime' column in the Orders table.
SELECT cast(OrderDateTime as date) as OrderDate
FROM data.orders;

-- Q14: Extract just the TIME (HH:MM:SS) from the 'OrderDateTime' column.
SELECT cast(OrderDateTime as TIME) as OrderTime
FROM data.orders;

-- Q15: Write a query that converts the 'StockQuantity' (integer) into a CHAR/String format so it can be used in text functions.
SELECT CONVERT(StockQuantity, CHAR) as StockQuantity
FROM data.products;

-- PART 5: Advanced & Combined Scenarios
-- Q16: (Sorting) Sort all products by DiscountPercent in Ascending order. 
--      Force the NULL discounts to appear at the very bottom of the list.
SELECT ProductID,DiscountPercent
FROM data.products
ORDER BY DiscountPercent DESC;

-- Q17: (Aggregation) Calculate the Average DiscountPercent for all products. 
--      Ensure NULLs are treated as 0 so they pull the average down correctly (Standard AVG ignores NULLs).
SELECT avg(ifnull(DiscountPercent,0)) as Average
FROM data.products;

-- Q18: (Reporting) Create a single string column: "Order #[ID] was placed on [Date]".
--      You will need to CAST the ID to string and CAST the DateTime to Date inside a CONCAT function.
SELECT concat(cast(OrderID as Char), ' ' ,cast(OrderDateTime as date)) as Reporting
FROM data.orders;

-- Q19: (Cleaning) Select ProductName. Create a 'Status' column. 
--      If Price_Text is 'Unknown', return 'Check Price'. Otherwise, return 'Active'.
SELECT ProductName, coalesce(ifnull(Price_Text,'Unknown'),'Active') as Status
FROM data.products;

-- Q20: (The Master List) Select CustomerName and Email. 
--      If Email is NULL, display 'No Contact'. 
SELECT FullName, ifnull(Email, 'No Contact') as Email
FROM data.customers;

