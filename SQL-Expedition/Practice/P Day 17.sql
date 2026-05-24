CREATE DATABASE IF NOT EXISTS ecomm_analytics;
USE ecomm_analytics;

DROP TABLE IF EXISTS sales_records;

CREATE TABLE sales_records (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_category VARCHAR(50),
    transaction_date DATE,
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    transaction_status VARCHAR(20) -- 'Completed', 'Refunded', 'Processing'
);

INSERT INTO sales_records VALUES
(1, 101, 'Electronics', '2024-02-01', 2, 299.99, 'Completed'),
(2, 102, 'Apparel', '2024-02-01', 3, 45.00, 'Completed'),
(3, 103, 'Electronics', '2024-02-02', 1, 899.99, 'Refunded'),
(4, 101, 'Home & Kitchen', '2024-02-03', 1, 120.00, 'Completed'),
(5, 104, 'Apparel', '2024-02-03', 5, 20.00, 'Completed'),
(6, 105, 'Home & Kitchen', '2024-02-04', 2, 150.00, 'Processing'),
(7, 102, 'Electronics', '2024-02-05', 1, 199.99, 'Completed'),
(8, 101, 'Apparel', '2024-02-05', 2, 55.00, 'Completed'),
(9, 106, 'Electronics', '2024-02-06', 4, 250.00, 'Completed');

-- =============================================================
-- DAY 17 ASSIGNMENTS: Grouping & Aggregation
-- Domain: E-Commerce Sales
-- =============================================================

-- Task 1 (Finance Team):
-- "We need to know our total recognized revenue per product category. 
-- Please calculate the total revenue (quantity * price). 
-- Call the columns 'Category' and 'Total Revenue'. 
-- IMPORTANT: Only include 'Completed' transactions. Do not count refunds or processing orders."
-- Write your query below
SELECT
	product_category as Category,
    Sum(quantity_sold * unit_price) as 'Total Revenue'
FROM
	ecomm_analytics.sales_records
WHERE transaction_status = 'Completed'
GROUP BY 1;

-- Task 2 (Marketing Team):
-- "We want to identify our high-volume buyers to send them a VIP discount. 
-- Find the customer_ids of people who have successfully purchased ('Completed') 
-- MORE THAN 4 items in total across all their orders. 
-- Call the column 'Total Items Bought'."
-- Write your query below:
SELECT
	customer_id,
    sum(quantity_sold * unit_price) as 'Total Item Bought'
FROM
	ecomm_analytics.sales_records
WHERE
	transaction_status = 'Completed' 
GROUP BY 1
HAVING sum(quantity_sold) > 4;

-- Task 3 (Operations Team):
-- "What is our Average Order Value (AOV) for 'Completed' sales? 
-- I just need one single number representing the average revenue per transaction."
-- Write your query below:
SELECT
	avg(unit_price) as AOV
FROM
	ecomm_analytics.sales_records
where
	transaction_status = 'Completed';
	

-- Task 4 (Interview-Style Challenge):
-- "Show me the highest single transaction revenue generated in each product category. 
-- However, I ONLY want to see categories where the *total overall revenue* for that category is above $500. 
-- (Only look at 'Completed' sales)."
-- Write your query below:
SELECT	
	product_category,
    MAX(unit_price * unit_price)  as 'total overall revenue'
FROM
	ecomm_analytics.sales_records
where
	transaction_status = 'Completed'
GROUP BY 1
HAVING
	MAX(unit_price * unit_price) > 500;
	