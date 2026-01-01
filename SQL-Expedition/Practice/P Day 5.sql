-- =============================================================
-- DAY 5: SQL PRACTICE SET - Subqueries
-- Domain: "Java & Beans" Coffee Shop
-- New Topics: Subqueries (WHERE ... SELECT), IN, NOT IN
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CoffeeShop_DB;
USE CoffeeShop_DB;

-- (Same tables as Day 4, ensuring data is clean for today's logic)
CREATE TABLE IF NOT EXISTS menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    quantity INT,
    order_date DATE
);

-- 2. POPULATE DATA
-- =============================================================
DROP TABLE orders;
DROP TABLE customers;
Drop TABLE menu_items;

INSERT INTO menu_items (item_id, item_name, category, price) VALUES
(1, 'Espresso', 'Coffee', 2.00),
(2, 'Fancy Latte', 'Coffee', 6.00), -- Expensive item
(3, 'Drip Coffee', 'Coffee', 2.50),
(4, 'Green Tea', 'Tea', 3.00),
(5, 'Bagel', 'Bakery', 2.00),
(6, 'Lobster Roll', 'Lunch', 25.00); -- Very expensive outlier

INSERT INTO customers (customer_id, first_name) VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie'), (4, 'Diana'), (5, 'Eve');

INSERT INTO orders (customer_id, item_id, quantity, order_date) VALUES
(1, 1, 1, '2024-01-01'), -- Alice bought Espresso
(2, 5, 2, '2024-01-01'), -- Bob bought Bagels
(3, 4, 1, '2024-01-02'), -- Charlie bought Tea
(1, 2, 1, '2024-01-03'), -- Alice bought Latte
(4, 5, 1, '2024-01-03'); -- Diana bought Bagel
-- Note: Eve (ID 5) never bought anything.
-- Note: The Lobster Roll (ID 6) was never sold.


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: Above Average Prices (Scalar Subquery)
-- Find all menu items that cost MORE than the average price of all items.
--   Step 1 (Inner): SELECT AVG(price) FROM menu_items
--   Step 2 (Outer): SELECT * FROM menu_items WHERE price > (Step 1)
SELECT
	* 
FROM 
	menu_items
WHERE
	price > 
			(
				SELECT	AVG(price) FROM menu_items
            )
;
-- Question 2: The Most Expensive Item
-- Find the item details (name/price) for the item with the absolute highest price.
-- Hint: WHERE price = (SELECT MAX(price) FROM menu_items).
SELECT
	item_name,
    price
FROM	
	menu_items
WHERE
	price = 
			(
				SELECT MAX(Price) FROM menu_items
            )
;
-- Question 3: Who bought 'Bagels'? (Subquery with IN)
-- Find the names of customers who bought a 'Bagel'.
-- Try doing this WITHOUT a Join, using a subquery.
-- Hint:
--   Step 1: Get customer_ids from orders WHERE item_id is the Bagel's ID.
--   Step 2: SELECT first_name FROM customers WHERE customer_id IN (Step 1).
SELECT
	first_name
FROM
	customers
WHERE
	customer_id IN 
				(
					SELECT customer_id FROM orders
                    WHERE item_id = 
									(
										SELECT item_id FROM menu_items
										WHERE item_name = 'Bagel'
                                    )
                )
;
-- Question 4: The "Unsold" Items (NOT IN)
-- Find the names of menu items that have NEVER been ordered.
-- Hint:
--   Step 1: Get a list of all item_ids that ARE in the orders table.
--   Step 2: Select items WHERE item_id NOT IN (Step 1).
SELECT
	item_id
FROM 
	menu_items
WHERE
	item_id NOT IN 
				(
					SELECT item_id FROM orders
                )
;

-- Question 5: The "Inactive" Customers (NOT IN)
-- Find the names of customers who have never placed an order (Eve).
-- Hint: Similar to Q4. WHERE customer_id NOT IN (SELECT customer_id FROM orders).
SELECT
	customer_id
FROM
	customers
WHERE
	customer_id NOT IN 
					(
						SELECT customer_id FROM orders
                    )
;

-- Question 6: Expensive Orders
-- Find the details of orders (order_id, quantity) where the *Item Price* is greater than $5.00.
-- Do this without a JOIN.
-- Hint: SELECT * FROM orders WHERE item_id IN (SELECT item_id FROM menu_items WHERE price > 5).
SELECT
	item_id,
    quantity
FROM
	orders
WHERE	
	item_id IN 
			(
				SELECT item_id FROM menu_items
                WHERE price > 5
            );
-- Question 7: Subquery in the SELECT Clause (Advanced)
-- For every menu item, list its name, price, and the *Overall Average Price* of the whole menu side-by-side.
-- Hint: SELECT item_name, price, (SELECT AVG(price) FROM menu_items) AS avg_price FROM menu_items;
SELECT
	item_name,
    price,
    (SELECT Round(AVG(Price),2) FROM menu_items) as avg_price
FROM
	menu_items;
	
-- Question 8: Comparing to Specific Categories
-- Find all items that are cheaper than the cheapest 'Coffee' item.
-- Hint: WHERE price < (SELECT MIN(price) FROM menu_items WHERE category = 'Coffee').
SELECT
	*
FROM
	menu_items
WHERE
	price < 
			(
				SELECT MIN(price) FROM menu_items
                WHERE category = 'Coffee'
            );
-- Question 9: Deleting with Subqueries (DML)
-- (Write the query, don't run it if you want to save data)
-- Write a command to Delete all orders made by 'Bob'.
-- Hint: DELETE FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE first_name = 'Bob').
DELETE FROM orders
WHERE
	customer_id = 
				(
					SELECT customer_id FROM customers
                    WHERE first_name = 'Bob'
                );
                
-- Question 10: The "Big Spender" (Aggregated Subquery)
-- (Tricky) Find the customer_id of the person who placed the single order with the highest quantity.
-- Hint: WHERE quantity = (SELECT MAX(quantity) FROM orders).
SELECT	
	customer_id
FROM
	orders
WHERE
	quantity =
			(
				SELECT MAX(quantity) FROM orders
            );
