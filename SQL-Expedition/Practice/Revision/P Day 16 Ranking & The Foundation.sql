CREATE TABLE analytics.employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT
);

CREATE TABLE analytics.sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount DECIMAL(10,2),
    sale_datetime DATETIME,
    product VARCHAR(100),
    region VARCHAR(50)
);

##################################################### Practice #####################################################
-- GROUP BY
SELECT 
	department,
    Count(*) as Emp_Count
FROM analytics.employees
GROUP BY department;

-- OVER()
SELECT 
	sale_id,
    Date(sale_datetime) sale_datetime,
    SUM(sale_amount) OVER() as Total_sales
FROM
	analytics.sales;
    
-- PARTITION BY
SELECT 
	sale_id,
    Date(sale_datetime) sale_datetime,
    product,
    SUM(sale_amount) OVER(PARTITION BY product) as Total_sales
FROM
	analytics.sales;

-- With Multiple Aggrigation
SELECT 
	sale_id,
    Date(sale_datetime) sale_datetime,
    product,
    sale_amount,
	SUM(sale_amount) OVER() as Total_sales_1,
    SUM(sale_amount) OVER(PARTITION BY product) as Total_sales_2,
    SUM(sale_amount) OVER(PARTITION BY product,region) as 'Sales_By_Product_&_Region'
FROM
	analytics.sales;

-- Window Funtion OVER() With PARTITION BY
SELECT 
	department,
    COUNT(*) OVER(PARTITION BY department) as Emp_Count
FROM analytics.employees;

-- Ex OF OVER() With PARTITION BY
-- Calculates average salary SPECIFIC to the department of the current row
SELECT
    first_name,
    department,
    salary,
    Round(AVG(Salary) OVER(PARTITION BY department),2) as Dpt_Salary
FROM 
	analytics.employees;

-- Calculate the Max and Min sale_amount over every regin
SELECT
	sale_id,
    region,
    MIN(sale_amount) OVER(PARTITION BY region) as Min_SALE,
    MAX(sale_amount) OVER(PARTITION BY region) as MAX_SALES
FROM 
	analytics.sales;

-- Ranking Function With ORDER BY
-- 1. ROW_NUMBER
SELECT 
	e.first_name,
    ifnull(s.sale_amount,0.00) as sale,
    ROW_NUMBER() OVER(ORDER BY s.sale_amount DESC) as Row_Num
FROM employees as e
LEFT JOIN sales as s
ON e.emp_id = s.emp_id;

-- RANK()
SELECT 
	emp_id,
    sale_amount,
    RANK() OVER(ORDER BY sale_amount DESC) as Sale_rank
FROM 
	analytics.sales;
    
-- DENSE_RANK()
SELECT 
	first_name,
    department,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) as 'Dense_rank'
FROM 	
	analytics.employees;

-- Use Cases in Real Life
-- Find the Highest payed Emp in every dep
SELECT * FROM (    
	SELECT 
		first_name,
		department,
		salary,
		ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as High_salary
	FROM 	
		analytics.employees) as t 
WHERE High_salary = 1;

-- Data cleaning return the data with no duplicates
SELECT * 
From (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY sale_id) as rn,
		s.*
	From 
		analytics.sales as s
	) as d
WHERE
	rn = 1;
    
-- Segmentation Function (NTILE)
SELECT
	first_name,
	salary,
	NTILE(3) OVER(ORDER BY salary DESC) as BucketThree,
	NTILE(2) OVER(ORDER BY salary DESC) as BucketTwo,
	NTILE(1) OVER(ORDER BY salary DESC) as BucketOne
FROM 	
	analytics.employees;
    
-- V. Percentage Based Ranking (Distribution)
-- CUME_DIST() (Cumulative Distribution):
SELECT 
	product_name,
    price,
    CUME_DIST() OVER(ORDER BY Price DESC) as PRice_rank
FROM
	sales.products;

-- PERCENT_RANK
SELECT 
	product_name,
    price,
    PERCENT_RANK() OVER(ORDER BY Price) as PRice_rank
FROM
	sales.products;

##################################################### Practice #####################################################
/*
-------------------------------------------------------------------------
PRACTICE QUESTIONS: WINDOW FUNCTIONS & AGGREGATIONS
Database Context: analytics.employees, analytics.sales
-------------------------------------------------------------------------
*/

-- Q1: Using GROUP BY, write a query to find the total salary expense for each department.
SELECT 
	department,
    sum(salary) as Dep_salary
FROM 
	analytics.employees
GROUP BY department;

-- Q2: Using OVER() without any arguments, write a query to display every employee's details along with the total count of all employees in the company.
SELECT 
	*,
    count(*) OVER() as Toatal_emp
FROM 
	analytics.employees;

-- Q3: Write a query using OVER(PARTITION BY ...) to display each sale_id, sale_amount, and the total sales amount for the Product associated with that sale.
SELECT 
	sale_id,
    sale_amount,
    SUM(sale_amount) OVER(PARTITION BY product) as product_sale
FROM 
	analytics.sales;

-- Q4: Write a query to display employee details (name, salary, department) and the Average Salary of their specific department using a Window Function.
SELECT
	first_name,
    last_name,
    salary,
    round(AVG(salary) OVER(PARTITION BY department),2) as Dep_avg
FROM
	analytics.employees;

-- Q5: Write a query to list every sale_id and sale_amount. Add a column that calculates the running total of sales over time (Order by sale_datetime).
-- (Hint: Use SUM() with PARTITION BY and ORDER BY).
SELECT
	sale_id,
    sale_amount,
    SUM(sale_amount) OVER(ORDER BY sale_datetime ) as runnig_total
FROM
	analytics.sales;
    
-- Q6: Calculate the Minimum and Maximum salary for each department and display it alongside every employee's individual salary.
SELECT
	first_name,
    salary,
    MIN(salary) OVER(PARTITION BY department) as Min_Salary,
	MAX(salary) OVER(PARTITION BY department) as Max_Salary
FROM
	analytics.employees;
    
-- Q7: Assign a sequential integer (1, 2, 3...) to every employee based on their salary, from highest to lowest. Use ROW_NUMBER().
SELECT	
	first_name,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as Sal_Rank
FROM
	analytics.employees;
    
-- Q8: Assign a rank to every sale based on sale_amount (Highest to Lowest). If two sales have the same amount, they should share the rank, and the next rank should skip numbers (e.g., 1, 1, 3).
SELECT
	sale_id,
    sale_amount,
    RANK() OVER(ORDER BY sale_amount DESC) as Sale_Rank
FROM
	analytics.sales;

-- Q9: Assign a rank to every employee based on salary (Highest to Lowest). If two employees match, they share the rank, but the next rank should NOT skip numbers (e.g., 1, 1, 2).
SELECT 
	first_name,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) as sal_rank
FROM
	analytics.employees;

-- Q10: Write a query to find the highest-paid employee in EACH department.
-- (Hint: Use a CTE or Subquery with ROW_NUMBER() partitioned by department).
SELECT * FROM
(
	SELECT
		first_name,
        salary,
        ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_emp
	FROM
		analytics.employees
) e
WHERE
	highest_paid_emp = 1;
	

-- Q11: Write a query to identify the "Latest" sale made by each employee.
-- (Hint: Use ROW_NUMBER() ordered by sale_datetime DESC).
SELECT * FROM
(
	SELECT
		emp_id,
		sale_id,
        sale_amount,
        ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY sale_datetime DESC) as Latest_sale
	FROM 
		analytics.sales
) T
WHERE 
	Latest_sale = 1;

-- Q12: Divide the employees into 4 buckets (Quartiles) based on their salary using NTILE().
SELECT 
	*,
    NTILE(4) OVER(ORDER BY salary DESC) as Quartiles
FROM
	analytics.employees;

-- Q13: Divide the sales data into 5 equal groups based on sale_amount using NTILE().
SELECT	
	*,
    NTILE(5) OVER(ORDER BY sale_amount DESC) as sale_amount_Bracket
FROM
	analytics.sales;

-- Q14: Calculate the Cumulative Distribution (CUME_DIST) of salary within each department.
SELECT
	department,
    CUME_DIST() OVER(PARTITION BY department ORDER BY salary) as CM_Department
FROM
	analytics.employees;
    
-- Q15: Calculate the Percent Rank of every sale_amount compared to all other sales in the table.
SELECT
	sale_id,
    sale_amount,
    PERCENT_RANK() OVER(ORDER BY sale_amount) as PRank_Sale
FROM
	analytics.sales;

-- Q16: Write a query that shows the employee's salary and the difference between their salary and the department's average salary.
SELECT
	first_name,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department) as Dep_avg,
    salary - AVG(salary) OVER(PARTITION BY department) as Salary_Diff
FROM
	analytics.employees;
    

-- Q17: Data Cleaning: Imagine the sales table has duplicate rows for sale_id. Write a query using ROW_NUMBER() to identify the duplicate rows.
SELECT * FROM
(
	SELECT
		sale_id,
        emp_id,
        ROW_NUMBER() OVER(PARTITION BY sale_id) as Clean_data
	FROM
		analytics.sales
) S
WHERE Clean_data = 1;
	
	

-- Q18: Write a query using multiple window functions to show:
--      1. Total sales per region
--      2. Total sales per product
--      ... alongside the individual sale details.
SELECT	
	region,
    SUM(sale_amount) OVER(PARTITION BY region) as Total_Sales,
    product,
    SUM(sale_amount) OVER(PARTITION BY product) as Sales_Product,
    sale_amount
FROM
	analytics.sales;

-- Q19: Find the 2nd highest salary in the entire company using a Window Function.
SELECT * FROM
(
	SELECT 
		emp_id,
        first_name,
        salary,
		DENSE_RANK() OVER(ORDER BY salary DESC) as Highest_salary
	FROM analytics.employees
) E
WHERE 
	Highest_salary = 2;
    
-- Q20: Write a query to calculate the percentage of total company sales that each individual sale represents.
-- (Hint: sale_amount / SUM(sale_amount) OVER() ...).
SELECT 
    sale_id,
    sale_amount,
    SUM(sale_amount) OVER() as Total_Company_Sales,
    (sale_amount / SUM(sale_amount) OVER()) * 100 as Sales_Percentage
FROM 
    analytics.sales;