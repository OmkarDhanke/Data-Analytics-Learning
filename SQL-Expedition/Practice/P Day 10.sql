-- =============================================================
-- DAY 10: SQL PRACTICE SET - Window Functions
-- Domain: "Velocity Motors"
-- Topics: OVER(), PARTITION BY, ROW_NUMBER(), RANK(), DENSE_RANK()
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS VelocityMotors_DB;
USE VelocityMotors_DB;

CREATE TABLE sales_reps (
    rep_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(50) -- 'Downtown', 'Suburbs'
);

CREATE TABLE car_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    rep_id INT,
    car_model VARCHAR(50),
    sale_price DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE car_sales;
TRUNCATE TABLE sales_reps;

INSERT INTO sales_reps (name, branch) VALUES
('Alex', 'Downtown'),
('Beth', 'Downtown'),
('Cody', 'Suburbs'),
('Dana', 'Suburbs');

INSERT INTO car_sales (rep_id, car_model, sale_price, sale_date) VALUES
(1, 'Sedan X', 25000, '2024-01-05'),
(1, 'SUV Max', 40000, '2024-01-10'),
(2, 'Coupe S', 35000, '2024-01-08'),
(2, 'Sedan X', 25000, '2024-01-12'),
(2, 'Truck Pro', 50000, '2024-01-15'),
(3, 'SUV Max', 40000, '2024-01-03'),
(3, 'Truck Pro', 50000, '2024-01-20'),
(4, 'Sedan X', 25000, '2024-01-06'),
(4, 'Sedan X', 25000, '2024-01-18'),
(4, 'SUV Max', 40000, '2024-01-25');


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: The "Grand Total" Window
-- Show every individual car sale (sale_id, car_model, sale_price). 
-- Add a 4th column that shows the TOTAL revenue of the entire dealership on every row.
-- Vague Hint: Use SUM() but append the empty window clause to it.

-- Question 2: The "Partitioned" Total
-- Show the sale_id, rep_id, and sale_price.
-- Add a column showing the total revenue generated specifically by THAT rep.
-- Vague Hint: You need to divide your window into sections based on the rep.

-- Question 3: Running Total (Cumulative Sum)
-- List all sales in chronological order (sale_date). 
-- Calculate a running total of revenue for the dealership over time.
-- Vague Hint: A window sum combined with a chronological sort inside the window creates a running total.

-- Question 4: Numbering Rows (Chronological)
-- Assign a chronological sequence number (1, 2, 3...) to every sale based on the sale_date.
-- Vague Hint: Use the function designed to generate sequential row numbers, ordered by date.

-- Question 5: First, Second, Third Sale (Partitioned Numbering)
-- We want to track each rep's personal milestones. 
-- Number the sales chronologically, but reset the counter back to 1 for each new Sales Rep.
-- Vague Hint: Combine the logic from Q2 (breaking into sections) and Q4 (numbering).

-- Question 6: Ranking by Price (RANK vs DENSE_RANK)
-- Rank all individual car sales from most expensive (1) to least expensive.
-- Try using both RANK() and DENSE_RANK() as separate columns to see the difference when prices tie.
-- Vague Hint: Apply the sorting logic directly inside the window clause for both functions.

-- Question 7: Ranking Aggregates (CTEs + Window Functions)
-- Who is the top performing salesperson? 
-- First, find the total revenue per rep. Then, rank them 1, 2, 3 based on that total.
-- Vague Hint: You can't put an aggregate inside a window function directly. Calculate the totals in a CTE first, then apply the rank to the CTE.

-- Question 8: Finding the "Top 1" per Category (Filtering Windows)
-- Find the single most expensive car sold by *each* branch. 
-- Show Branch, Car Model, and Price.
-- Vague Hint: Window functions cannot be put in a WHERE clause directly. Generate a ranking partitioned by branch in a CTE, then filter for Rank 1 outside.

-- Question 9: Percent of Total (Math with Windows)
-- For each sale, calculate what percentage it contributes to the dealership's grand total revenue.
-- Output: sale_id, sale_price, percentage.
-- Vague Hint: Divide the individual row's price by the grand total window (from Q1), then multiply by 100.

-- Question 10: Segmenting Data (NTILE)
-- We want to divide all our sales into 3 equal tiers based on price (High, Medium, Low).
-- Assign a bucket number (1, 2, or 3) to each sale, sorted by price highest to lowest.
-- Vague Hint: Look up the window function that chunks data into a specific number of groups.