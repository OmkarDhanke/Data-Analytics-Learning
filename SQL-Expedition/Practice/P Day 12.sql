-- =============================================================
-- DAY 12: SQL PRACTICE SET - Interview Patterns (E-Commerce)
-- Domain: "CartDrop" E-Commerce
-- Topics: Funnel Analysis, Conversion Rates, LTV, CTEs
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CartDrop_DB;
USE CartDrop_DB;

-- Table 1: Users
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    acquisition_channel VARCHAR(50) -- 'Organic', 'Paid Social', 'Email'
);

-- Table 2: User Activity Events (The Funnel)
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_type VARCHAR(50), -- 'view_item', 'add_to_cart', 'checkout', 'purchase'
    event_timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table 3: Completed Orders (Revenue)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_total DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE orders;
TRUNCATE TABLE events;
TRUNCATE TABLE users;

INSERT INTO users (user_id, signup_date, acquisition_channel) VALUES
(1, '2024-04-01', 'Organic'),
(2, '2024-04-01', 'Paid Social'),
(3, '2024-04-02', 'Email'),
(4, '2024-04-03', 'Paid Social'),
(5, '2024-04-05', 'Organic');

-- Simulating the user journey (The Funnel)
INSERT INTO events (user_id, event_type, event_timestamp) VALUES
(1, 'view_item', '2024-04-01 10:00:00'),
(1, 'add_to_cart', '2024-04-01 10:05:00'),
(1, 'checkout', '2024-04-01 10:10:00'),
(1, 'purchase', '2024-04-01 10:12:00'), -- User 1 completed the funnel

(2, 'view_item', '2024-04-01 11:00:00'),
(2, 'add_to_cart', '2024-04-01 11:15:00'), -- User 2 abandoned cart

(3, 'view_item', '2024-04-02 09:00:00'), -- User 3 only viewed

(4, 'view_item', '2024-04-03 14:00:00'),
(4, 'add_to_cart', '2024-04-03 14:05:00'),
(4, 'checkout', '2024-04-03 14:10:00'),
(4, 'purchase', '2024-04-03 14:15:00'), 
(4, 'view_item', '2024-04-10 10:00:00'), 
(4, 'add_to_cart', '2024-04-10 10:05:00'), 
(4, 'checkout', '2024-04-10 10:10:00'), 
(4, 'purchase', '2024-04-10 10:15:00'); -- User 4 is a repeat purchaser

-- Revenue Data
INSERT INTO orders (user_id, order_total, order_date) VALUES
(1, 150.00, '2024-04-01'),
(4, 85.00, '2024-04-03'),
(4, 120.00, '2024-04-10');


-- 3. INTERVIEW QUESTIONS
-- =============================================================

-- Question 1: Aggregate Funnel (Raw Numbers)
-- Count the total number of times EACH event type occurred across the whole platform.
-- Sort the results logically to represent the funnel (most common to least common).
-- Vague Hint: Simple grouping and counting on the events table.
SELECT
	event_type,
    count(event_id) as Total_Count
FROM
	cartdrop_db.events
GROUP BY event_type
order by Total_Count DESC;

-- Question 2: Unique User Funnel
-- Question 1 counted total actions. Now, count how many UNIQUE users performed each event type.
-- Output: event_type, unique_user_count.
-- Vague Hint: Group by event type, but change what goes inside your counting function to eliminate duplicates.
SELECT
	event_type,
    count(DISTINCT user_id) as unique_user_count
FROM
	cartdrop_db.events
GROUP BY event_type
order by unique_user_count DESC;

-- Question 3: Overall Conversion Rate
-- What percentage of unique users who "viewed an item" eventually made a "purchase"?
-- Output just a single percentage number.
-- Vague Hint: You will likely need CTEs. CTE 1 counts total distinct viewers. CTE 2 counts total distinct purchasers. Final query divides them.
With CTE_1 AS (
	SELECT
		count(DISTINCT user_id) as unique_user_count
	FROM
		cartdrop_db.events
) ,
CTE_2 AS(
	SELECT
		count(DISTINCT order_id) as unique_Order_count
	FROM
		cartdrop_db.orders
)
SELECT 
	C1.unique_user_count / C2.unique_Order_count as 'Overall Conversion Rate'
FROM
	CTE_1 as C1 
    JOIN CTE_2 AS C2;
	
-- Question 4: Cart Abandonment Rate
-- Find the number of users who added an item to their cart, but NEVER made a purchase.
-- Vague Hint: Use CTEs or Subqueries. Find the list of users who added to cart. Then, exclude the list of users who made a purchase (NOT IN or Anti-Join).
SELECT
	COUNT(user_id) as 'Cart Abandonment'
FROM
	cartdrop_db.events
WHERE
	user_id NOT IN (
		SELECT
			user_id
        FROM
			cartdrop_db.events
		WHERE
			event_type IN ('purchase')
    );
    
-- Question 5: Average Order Value (AOV)
-- Calculate the Average Order Value across the entire platform.
-- Vague Hint: Look at the 'orders' table. This is a very straightforward mathematical function.
SELECT
	round(avg(order_total),2) as AOV
FROM
	cartdrop_db.orders;
    
-- Question 6: Customer Lifetime Value (LTV)
-- Calculate the total amount of money spent by each individual user.
-- Include users who signed up but have spent $0.
-- Vague Hint: Join the users table to the orders table. Ensure you use the correct join type to keep users with no orders, and use COALESCE/IFNULL for the blanks.

SELECT
	u.user_id,
    ifnull(SUM(o.order_total),0) as LTV
FROM
	cartdrop_db.users as u
    LEFT JOIN cartdrop_db.orders as o
    ON u.user_id = o.user_id
GROUP BY u.user_id

-- Question 7: Repeat Purchaser Rate
-- What percentage of our paying customers have made MORE than 1 order?
-- Vague Hint: CTE 1: Count orders per user. CTE 2: Count how many of those users have > 1 order, and how many users exist in total. Divide.


-- Question 8: Revenue by Acquisition Channel
-- Which marketing channel brings in the most revenue?
-- List the acquisition_channel and the total revenue generated by users from that channel.
-- Vague Hint: Join the users table to the orders table and group by the channel.

-- Question 9: Time to First Purchase
-- For users who made a purchase, calculate the number of days between their 'signup_date' and their very first 'order_date'.
-- Vague Hint: You need to find the earliest order date for each user and compare it to their signup date.

-- Question 10: The "Drop-Off" Pivot (Advanced)
-- Create a single row that shows the counts for each step of the funnel as separate columns:
-- 'Total_Views', 'Total_Carts', 'Total_Checkouts', 'Total_Purchases'.
-- Vague Hint: Use conditional aggregation (SUM combined with a CASE statement) for each event type.