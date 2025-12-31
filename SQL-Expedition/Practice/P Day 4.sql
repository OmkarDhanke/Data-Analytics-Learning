-- =============================================================
-- DAY 4: SQL PRACTICE SET - Joins (Inner & Left)
-- Domain: "Java & Beans" Coffee Shop
-- New Topics: INNER JOIN, LEFT JOIN, Table Aliases
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CoffeeShop_DB;
USE CoffeeShop_DB;

-- Table 1: The Menu (Product Info)
CREATE TABLE IF NOT EXISTS menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(5,2)
);

-- Table 2: The Customers (People Info) - NEW!
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    favorite_drink VARCHAR(50)
);

-- Table 3: The Orders (Transaction Info) - Updated to link to Customers
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- Links to customers table
    item_id INT,     -- Links to menu_items table
    quantity INT,
    order_date DATE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE orders; 
TRUNCATE TABLE customers;
TRUNCATE TABLE menu_items;

INSERT INTO menu_items (item_id, item_name, category, price) VALUES
(1, 'Espresso', 'Coffee', 2.50),
(2, 'Latte', 'Coffee', 4.50),
(3, 'Green Tea', 'Tea', 3.00),
(4, 'Croissant', 'Bakery', 3.50),
(5, 'Bagel', 'Bakery', 2.00),
(6, 'Thermos', 'Merch', 25.00); -- Note: Item 6 is never ordered below

INSERT INTO customers (customer_id, first_name, favorite_drink) VALUES
(1, 'Alice', 'Latte'),
(2, 'Bob', 'Espresso'),
(3, 'Charlie', 'Green Tea'),
(4, 'Diana', 'Water'); -- Note: Diana never makes an order below

INSERT INTO orders (customer_id, item_id, quantity, order_date) VALUES
(1, 2, 1, '2024-01-01'), -- Alice bought Latte
(1, 4, 2, '2024-01-01'), -- Alice bought 2 Croissants
(2, 1, 1, '2024-01-02'), -- Bob bought Espresso
(3, 3, 1, '2024-01-03'), -- Charlie bought Green Tea
(2, 5, 3, '2024-01-04'); -- Bob bought 3 Bagels


-- 3. PRACTICE QUESTIONS
-- =============================================================
-- Question 1: The Basic Join (Who bought what?)
-- We have the 'orders' table, but it only has IDs. We want to see the Names.
-- Select the 'order_id' and the 'item_name'.
SELECT
	o.order_id,
    m.item_name
FROM	
	orders o
JOIN menu_items m 
ON o.item_id = m.item_id;

-- Question 2: Adding Customer Names
-- Select the 'first_name' of the customer and the 'item_name' they bought.
-- Hint: You need to join 'orders' with 'customers' AND 'menu_items'.
SELECT
	c.first_name,
    m.item_name
FROM
	customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN menu_items m 
ON o.item_id = m.item_id;

-- Question 3: Calculation in Joins
-- Calculate the total revenue for each order row (quantity * price).
-- Show 'order_id', 'item_name', and 'Revenue'.
-- Hint: You can do math using columns from different tables: (orders.quantity * menu_items.price).
SELECT	
	o.order_id,
    m.item_name,
    o.quantity * m.price as Revenue
FROM orders o 
JOIN menu_items m
ON o.item_id = m.item_id;

-- Question 4: Filtering Joins
-- Show all orders that included a "Coffee" item.
-- List the 'order_id', 'first_name', and 'item_name'.
-- Hint: Join the tables, then add a WHERE menu_items.category = 'Coffee'.
SELECT
	o.Order_id,
	c.first_name,
    m.item_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN menu_items m
ON o.item_id = m.item_id
WHERE
	m.category = 'Coffee';

-- Question 5: Aggregation per Customer
-- How much money has each customer spent in total?
-- Show 'first_name' and 'Total_Spent'.
-- Hint: JOIN, then SUM(quantity * price), then GROUP BY first_name.
SELECT
	c.First_name,
    SUM(o.quantity * m.price) as Total_Spent
FROM customers c 
JOIN orders o 
ON o.customer_id = c.customer_id
JOIN menu_items m 
ON o.item_id = m.item_id
GROUP BY c.First_name;

-- Question 6: The "Unsold" Items (Left Join)
-- We want to see ALL menu items, even the ones that have never been ordered (like the Thermos).
-- Show 'item_name' and 'order_id'.
-- Hint: Use FROM menu_items LEFT JOIN orders ON...
-- (Note: 'menu_items' must be on the LEFT side of the join to show all items).
SELECT
	m.item_name,
    o.order_id
FROM menu_items m
LEFT JOIN orders o 
ON m.item_id = o.item_id;

-- Question 7: Finding the "Zero Sales" Item
-- Based on the previous question, filter the list to ONLY show items that have never been ordered.
-- Hint: Use the Left Join, then add WHERE orders.order_id IS NULL.
SELECT
	m.item_name,
    o.order_id
FROM menu_items m
LEFT JOIN orders o 
ON m.item_id = o.item_id
WHERE o.order_id IS NULL;

-- Question 8: The Inactive Customer
-- Find which customer has registered but never placed an order (Diana).
-- Show their 'first_name'.
-- Hint: FROM customers LEFT JOIN orders... WHERE order_id IS NULL.
SELECT
	c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Question 9: Best Selling Category
-- Which category has generated the most revenue?
-- Hint: JOIN orders and menu, SUM(quantity * price), GROUP BY category, ORDER BY desc.
SELECT
	m.category,
    SUM(o.quantity * m.price) as Revenue
FROM  menu_items m
LEFT JOIN orders o
ON o.item_id = m.item_id
GROUP BY m.category
ORDER BY Revenue DESC;

-- Question 10: The "Favorite" Match
-- (Tricky) Find customers who actually bought their 'favorite_drink'.
-- Select customer 'first_name' and 'item_name'.
-- Hint: Join orders, customers, and menu. Then add a WHERE clause:
-- WHERE customers.favorite_drink = menu_items.item_name.
SELECT
	c.first_name,
    m.item_name
FROM
	customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN menu_items m 
ON o.item_id = m.item_id
WHERE c.favorite_drink = m.item_name;