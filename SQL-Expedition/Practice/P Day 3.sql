-- =============================================================
-- DAY 3: SQL PRACTICE SET - Grouping & Aggregation
-- Domain: "Java & Beans" Coffee Shop
-- New Topics: GROUP BY, HAVING, MIN, MAX
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CoffeeShop_DB;
USE CoffeeShop_DB;

-- Table 1: The Menu
CREATE TABLE IF NOT EXISTS menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(5,2),
    calories INT,
    is_gluten_free BOOLEAN
);

-- Table 2: Sales Data
CREATE TABLE IF NOT EXISTS daily_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity_sold INT,
    transaction_time TIME,
    payment_method VARCHAR(20)
);

-- 2. POPULATE DATA (Refreshing the data for today's practice)
-- =============================================================
TRUNCATE TABLE menu_items;
TRUNCATE TABLE daily_sales;

INSERT INTO menu_items (item_id, item_name, category, price, calories, is_gluten_free) VALUES
(1, 'Espresso', 'Coffee', 2.50, 10, 1),
(2, 'Cappuccino', 'Coffee', 4.00, 120, 1),
(3, 'Latte', 'Coffee', 4.50, 150, 1),
(4, 'Caramel Macchiato', 'Coffee', 5.00, 250, 1),
(5, 'Green Tea', 'Tea', 3.00, 0, 1),
(6, 'Croissant', 'Bakery', 3.50, 300, 0),
(7, 'Bagel', 'Bakery', 2.00, 280, 0),
(8, 'Thermos', 'Merch', 25.00, 0, 1);

INSERT INTO daily_sales (item_id, quantity_sold, transaction_time, payment_method) VALUES
(1, 1, '08:00:00', 'Cash'),
(1, 2, '08:15:00', 'Cash'),
(2, 1, '08:30:00', 'Card'),
(3, 1, '09:00:00', 'App'),
(3, 1, '09:15:00', 'App'),
(1, 1, '09:30:00', 'Card'),
(6, 2, '10:00:00', 'Cash'), -- Sold 2 Croissants
(6, 1, '10:15:00', 'Card'),
(7, 5, '10:30:00', 'Cash'), -- Sold 5 Bagels (Bulk order)
(8, 1, '11:00:00', 'Card'); -- Sold 1 Thermos

-- 3. PRACTICE QUESTIONS
-- =============================================================
-- Question 1: Simple Grouping
-- We want to know how many items are on the menu for EACH category.
-- Count the items, grouped by 'category'.
SELECT
	category,
    COUNT(*) as Item_Count
FROM
	coffeeshop_db.menu_items
GROUP BY 
	category;

-- Question 2: Average Price per Category
-- Which category is the most expensive on average?
-- Calculate the average price for each 'category'.
SELECT
	category,
    ROUND(AVG(price),2) as Avrage_Price
FROM
	coffeeshop_db.menu_items
GROUP BY 
	category;

-- Question 3: Finding Extremes (MAX)
-- What is the most expensive price in EACH category?
SELECT	
	category,
    MAX(Price) as M_Price_Category
FROM
	menu_items
GROUP BY 
	category;

-- Question 4: Sales by Payment Method
-- We want to see how people prefer to pay.
-- Count how many distinct sales transactions happened for each 'payment_method'.
SELECT
	DISTINCT payment_method,
    COUNT(*) as Payment_Count
FROM
	daily_sales
GROUP BY
	payment_method;
    
-- Question 5: Total Quantity Sold per Item
-- Instead of counting transactions, sum up the actual 'quantity_sold' for each 'item_id'.

SELECT
	item_id,
    SUM(quantity_sold) as quantity_sold
FROM	
	daily_sales
GROUP BY
	item_id;

-- Question 6: Sorting Aggregates
-- Run the same query as Q5, but sort the results so the item with the HIGHEST quantity sold is at the top.
SELECT
	item_id,
    SUM(quantity_sold) as quantity_sold
FROM	
	daily_sales
GROUP BY
	item_id
ORDER BY quantity_sold DESC;

-- Question 7: Filtering Groups (HAVING)
-- We only want to see categories that have more than 2 items on the menu.
-- Hint: Use GROUP BY category HAVING COUNT(*) > 2.
SELECT	
	category,
    COUNT(*) as Item_Count
FROM
	menu_items
GROUP BY
	category
HAVING 
	 COUNT(*) > 2;
     
-- Question 8: High Volume Sales
-- Find which 'item_id' has sold a TOTAL quantity of more than 4 units today.
SELECT
	item_id,
    SUM(quantity_sold) as quantity_sold
FROM
	daily_sales
GROUP BY
	item_id
HAVING 
	quantity_sold > 4;
    
-- Question 9: Combined Logic (WHERE + GROUP BY)
-- We want to check the average calories, but ONLY for 'Coffee' and 'Bakery' categories.
SELECT
	category,
    ROUND(AVG(calories),2) as Avg_calories
FROM
	menu_items
WHERE
	category in ('Coffee' ,'Bakery')
GROUP BY
	category;
    
-- Question 10: The "Price Range" (MIN & MAX)
-- For each category, show the Cheapest item price and the Most Expensive item price side-by-side.
SELECT
	category,
    MIN(Price) as Min_Price,
    MAX(Price) as Max_Price
FROM	
	menu_items
GROUP BY
	category;