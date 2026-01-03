-- =============================================================
-- DAY 6: SQL PRACTICE SET - The "Logic" Layer
-- Domain: "TechZone" Electronics
-- Topics: CASE, CASE with Aggregates, Subqueries
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS TechZone_DB;
USE TechZone_DB;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(20), -- 'Sales', 'Support', 'HR'
    salary DECIMAL(10,2),
    performance_score INT   -- 1 to 10 scale
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    product_category VARCHAR(30), -- 'Laptop', 'Phone', 'Tablet'
    sale_amount DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE sales;
TRUNCATE TABLE employees;

INSERT INTO employees (name, department, salary, performance_score) VALUES
('Alice', 'Sales', 50000, 9),
('Bob', 'Sales', 45000, 7),
('Charlie', 'Support', 40000, 8),
('Diana', 'Support', 42000, 5),
('Eve', 'HR', 60000, 8);

INSERT INTO sales (emp_id, product_category, sale_amount) VALUES
(1, 'Laptop', 1200), (1, 'Phone', 800), (1, 'Phone', 800), -- Alice
(2, 'Tablet', 300), (2, 'Tablet', 300), (2, 'Laptop', 1000), -- Bob
(1, 'Laptop', 1500), -- Alice again
(3, 'Phone', 500);   -- Charlie (Support team made a sale!)


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: Simple Categorization (The Basics)
-- Create a query that lists Employee Name and a new column called 'Salary_Tier'.
-- Logic: If salary > 48000 then 'High', otherwise 'Standard'.
-- Hint: You need a logic structure that evaluates a condition row-by-row.
SELECT
	name,
    CASE
		WHEN salary > 48000.00 THEN 'High'
        ELSE 'Standard'
	END AS Salary_Tier
FROM
	techzone_db.employees;

-- Question 2: Multiple Conditions
-- List Employee Name and 'Performance_Label'.
-- Logic: Score 9-10 = 'Star', Score 7-8 = 'Good', Score < 7 = 'Needs Improvement'.
-- Hint: You can chain multiple conditions before the final default option.
SELECT	
	name,
    CASE
		WHEN performance_score IN (9,10) THEN 'Star'
        WHEN performance_score IN (7,8) THEN 'Good'
        WHEN performance_score < 7 THEN 'Needs Improvement'
	END AS Performance_Label
FROM
	techzone_db.employees;

-- Question 3: The "Pivot" Count (Conditional Aggregation)
-- We want a single row showing the total number of employees in 'Sales' vs 'Support'.
-- Columns should be: 'Total_Sales_Staff', 'Total_Support_Staff'.
-- Hint: You need to count, but only "count" (or sum a 1) when the department matches your criteria.
SELECT
	SUM(CASE WHEN department = 'Sales' THEN 1 ELSE 0 END ) AS 'Total_Sales_Staff',
    SUM(CASE WHEN department = 'Support' THEN 1 ELSE 0 END) AS 'Total_Support_Staff'
FROM
	techzone_db.employees;

-- Question 4: The "Pivot" Sum (Conditional Aggregation)
-- For Employee 'Alice' (ID 1), calculate her total revenue broken down by category in one row.
-- Output columns: 'Alice_Laptop_Revenue', 'Alice_Phone_Revenue'.
-- Hint: Sum up the sale_amount, but only include the amount if the category matches.
SELECT
	SUM(CASE WHEN emp_id = 1 AND product_category = 'Laptop' THEN sale_amount ELSE 0 END) AS 'Alice_Laptop_Revenue',
    SUM(CASE WHEN emp_id = 1 AND product_category = 'Phone' THEN sale_amount ELSE 0 END) AS 'Alice_Phone_Revenue'
FROM
	techzone_db.sales;
    
-- Question 5: Mixing Aggregates
-- Calculate the Total Salary paid to the entire company, but exclude 'HR' from the total.
-- Try to do this using a CASE statement inside SUM, rather than a WHERE clause.
-- Hint: If the department is HR, add 0 to the total; otherwise, add the salary.
SELECT
	SUM(CASE WHEN department = 'HR' THEN 0 ELSE salary END) AS 'Total Salary paid',
    SUM(CASE WHEN department = 'HR' THEN salary ELSE 0 END) AS 'Total Salary paid HR'
FROM
	techzone_db.employees;

-- Question 6: Subquery in Filtering
-- Find the names of employees who have a Performance Score higher than the average score of all employees.
-- Hint: You need to know the verage before you can compare the individual rows.
SELECT	
	name
FROM
	techzone_db.employees
WHERE
	performance_score > 
						(
							SELECT AVG(performance_score) 
                            FROM techzone_db.employees
                        )
;
-- Question 7: Subquery "Existence" Check
-- Find employees who have NEVER made a sale.
-- Do this using a Subquery (NOT IN or NOT EXISTS).
-- Hint: Compare the employee list against the list of people present in the sales table.
SELECT
	emp_id,
    name
FROM
	techzone_db.employees e
WHERE EXISTS (
				SELECT 1 FROM sales s
                WHERE s.emp_id = e.emp_id
			 );


-- Question 8: Grouping with Case (The "Buckets")
-- We want to group sales by "Size".
-- Logic: If amount > 1000 it's 'Big Ticket', otherwise 'Small Ticket'.
-- Count how many sales fall into each bucket.
-- Hint: You can write logic in the SELECT clause, and then Group By that same logic (or alias).

-- Question 9: Advanced Conditional Average
-- Calculate the Average Sale Amount for 'Laptops'.
-- Do this using standard AVG functions (easy way) OR try using SUM/COUNT logic manually to verify.
-- Hint: Standard AVG with a WHERE clause is fine here.

-- Question 10: The Ultimate Conditional Aggregation (Grouped Pivot)
-- List ALL Sales employees (Name).
-- For each person, show three columns:
-- 1. Total Count of 'Laptop' sales
-- 2. Total Count of 'Tablet' sales
-- 3. Total Count of 'Phone' sales
-- Hint: You need to Group By the person, then use three separate conditional counters in the SELECT list.