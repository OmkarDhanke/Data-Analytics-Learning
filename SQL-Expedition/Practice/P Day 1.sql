-- =============================================================
-- DAY 1: SQL BASICS (Beginner)
-- Domain: "Java & Beans" Coffee Shop
-- Topics: SELECT, WHERE, ORDER BY, LIMIT, DISTINCT
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CoffeeShop_DB;
USE CoffeeShop_DB;

-- We will start with a single table to master single-table logic first.
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    category VARCHAR(30), -- 'Coffee', 'Tea', 'Bakery', 'Merch'
    price DECIMAL(5,2),   -- Price in Dollars
    calories INT,
    is_gluten_free BOOLEAN -- 1 = Yes, 0 = No
);

-- 2. POPULATE DATA
-- =============================================================
INSERT INTO menu_items (item_name, category, price, calories, is_gluten_free) VALUES
('Espresso', 'Coffee', 2.50, 10, 1),
('Cappuccino', 'Coffee', 4.00, 120, 1),
('Latte', 'Coffee', 4.50, 150, 1),
('Caramel Macchiato', 'Coffee', 5.00, 250, 1),
('Green Tea', 'Tea', 3.00, 0, 1),
('Earl Grey', 'Tea', 3.00, 0, 1),
('Croissant', 'Bakery', 3.50, 300, 0),
('Blueberry Muffin', 'Bakery', 3.75, 450, 0),
('Bagel', 'Bakery', 2.00, 280, 0),
('GF Brownie', 'Bakery', 4.00, 350, 1),
('Ceramic Mug', 'Merch', 12.00, 0, 1),
('Thermos', 'Merch', 25.00, 0, 1);


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: The Full Menu
-- We need to see everything available in the shop.
-- Write a query to select all columns from the 'menu_items' table.
-- Hint: Use the asterisk (*) symbol to grab everything.
SELECT * FROM menu_items;

-- Question 2: Price List
-- We want a clean list for the signboard.
-- Select ONLY the 'item_name' and 'price' columns.
-- Hint: List the column names separated by a comma after SELECT.

SELECT item_name, Price FROM menu_items;

-- Question 3: Finding Specific Items (Equality)
-- Find all details for the item named 'Croissant'.
-- Hint: Use WHERE item_name = '...'. Remember to use single quotes for text.

SELECT * FROM menu_items
WHERE item_name = 'Croissant';

-- Question 4: Filtering by Category
-- Show us only the items that belong to the 'Coffee' category.
-- Hint: Use WHERE category = 'Coffee'.

SELECT * FROM menu_items
WHERE category = 'Coffee';

-- Question 5: Finding Cheap Items (Comparisons)
-- Find all items that cost $3.00 or less.
-- Hint: Use the less than or equal to operator (<=) on the 'price' column.

SELECT item_name FROM coffeeshop_db.menu_items
WHERE price <= 3.00;

-- Question 6: Multiple Conditions (AND)
-- Find items that are in the 'Bakery' category AND are also 'Gluten Free' (is_gluten_free = 1).
-- Hint: Use the AND operator to combine two conditions in the WHERE clause.

SELECT item_name 
FROM coffeeshop_db.menu_items
WHERE category = 'Bakery' AND is_gluten_free = 1;

-- Question 7: Sorting Data (High to Low)
-- List all items, but sort them by 'calories' from Highest to Lowest.
-- Hint: Use ORDER BY column_name DESC.

SELECT item_name,calories 
FROM coffeeshop_db.menu_items
ORDER BY calories DESC;

-- Question 8: The Top 3 Most Expensive
-- Find the top 3 most expensive items on the menu.
-- Hint: Combine ORDER BY ... DESC with LIMIT 3.

SELECT * 
FROM coffeeshop_db.menu_items
ORDER BY price DESC 
LIMIT 3;

-- Question 9: Unique Categories
-- We want to know what types of categories we have (e.g., Coffee, Tea...), but we don't want duplicates.
-- Hint: Use SELECT DISTINCT column_name...

SELECT DISTINCT category 
FROM coffeeshop_db.menu_items;

-- Question 10: Calculations
-- Imagine we raise all prices by $1.00 for a projection.
-- Select the 'item_name' and a calculated column 'new_price' (price + 1).
-- Hint: You can do math directly in the SELECT part: SELECT price + 1 ...

SELECT item_name, Price as Old_Price,(Price + 1) as New_Price
FROM coffeeshop_db.menu_items;