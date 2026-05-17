-- =============================================================
-- DAY 15: REAL-WORLD ANALYTICS - RFM Segmentation
-- Domain: "LuxeAura" Boutique
-- Focus: Aggregation, NTILE() Window Functions, Advanced CASE Logic
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS LuxeAura_DB;
USE LuxeAura_DB;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 2. POPULATE DATA (Assuming today is '2024-12-31')
-- =============================================================
INSERT INTO customers (customer_id, first_name) VALUES
(1, 'Alice'),   -- The "Champion" (Buys often, spends a lot, bought recently)
(2, 'Bob'),     -- The "Lost VIP" (Spent a ton, but hasn't bought in a year)
(3, 'Charlie'), -- The "Newbie" (Just made their first small purchase)
(4, 'Diana'),   -- The "Loyal Cheapskate" (Buys all the time, but only $10 items)
(5, 'Eve');     -- The "At Risk" (Good spender, but slipping away)

INSERT INTO orders (customer_id, order_date, order_total) VALUES
-- Alice (Recent, High Freq, High Spend)
(1, '2024-11-15', 150.00), (1, '2024-12-01', 200.00), (1, '2024-12-25', 350.00),
-- Bob (Old, Low Freq, High Spend)
(2, '2023-05-10', 800.00), (2, '2023-11-20', 950.00),
-- Charlie (Recent, Low Freq, Low Spend)
(3, '2024-12-28', 45.00),
-- Diana (Recent, High Freq, Low Spend)
(4, '2024-09-01', 15.00), (4, '2024-10-15', 12.00), (4, '2024-11-20', 18.00), (4, '2024-12-20', 20.00),
-- Eve (Mid-Recent, Mid Freq, Mid Spend)
(5, '2024-03-10', 120.00), (5, '2024-06-15', 180.00), (5, '2024-08-01', 140.00);


-- 3. THE BUSINESS REQUESTS (Building the RFM Model)
-- Note: For all date math, assume the "current date" is '2024-12-31'.
-- =============================================================

-- Request 1: "The Base Metrics"
-- Stakeholder Email: "Hi! We want to run an RFM analysis. To start, can you give me a list of all customers showing three things: How many days it has been since their LAST order, their total number of orders, and their total lifetime spend?"
-- Analytical Goal: Group by customer. Use MAX() to find their latest order, DATEDIFF() from '2024-12-31' to get Recency, COUNT() for Frequency, and SUM() for Monetary.
SELECT
	c.customer_id,
    datediff('2024-12-31',MAX(o.order_date)) as 'LAST order day',
    count(o.customer_id) as Total_order,
    Sum(order_total) as Total_spend
FROM
	luxeaura_db.customers as c
    LEFT JOIN luxeaura_db.orders as o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- Request 2: "Scoring the Metrics (The NTILE trick)"
-- Stakeholder Email: "Great. Now we need to rank them. Can you divide the customers into 4 equal buckets (quartiles) for each metric? Score them 1 to 4, where 4 is the BEST."
-- Analytical Goal: Put Request 1 into a CTE. Then, use the NTILE(4) window function for R, F, and M. 
-- ⚠️ TRICKY PART: For Frequency and Monetary, a HIGHER number gets a 4 (ORDER BY DESC). But for Recency, a LOWER number of days is better, so the ordering must be flipped!


-- Request 3: "The RFM Cell"
-- Stakeholder Email: "Awesome. Marketing tools usually need a single 3-digit 'RFM Score' (like '444' or '141'). Can you combine the R, F, and M scores into a single text column?"
-- Analytical Goal: Wrap Request 2 in another CTE. Use CONCAT() to merge the three NTILE scores together.

-- Request 4: "Human Segmentation" (The Final Boss)
-- Stakeholder Email: "Final step! No one knows what '444' means. Can you translate the combined RFM scores into business segments? 
-- Rule 1: If the combined score is '444',