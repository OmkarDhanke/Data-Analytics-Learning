CREATE DATABASE Sales;

use Sales;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO Customers VALUES
(1, 'Amit Sharma', 'India', 'Mumbai', '2022-02-10'),
(2, 'John Smith', 'USA', 'New York', '2021-08-14'),
(3, 'Sara Lee', 'UK', 'London', '2023-03-25'),
(4, 'Priya Nair', 'India', 'Bangalore', '2022-06-19'),
(5, 'David Kim', 'South Korea', 'Seoul', '2021-11-02'),
(6, 'Maria Garcia', 'Spain', 'Madrid', '2023-01-11'),
(7, 'Robert Chen', 'China', 'Beijing', '2021-12-05'),
(8, 'Emma Wilson', 'Australia', 'Sydney', '2022-09-09'),
(9, 'Olivia Brown', 'Canada', 'Toronto', '2023-04-15'),
(10, 'Liam Jones', 'Germany', 'Berlin', '2021-07-30');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 75000),
(102, 'Smartphone', 'Electronics', 50000),
(103, 'Headphones', 'Accessories', 3000),
(104, 'Shoes', 'Fashion', 4000),
(105, 'Backpack', 'Travel', 2500),
(106, 'Smartwatch', 'Electronics', 12000),
(107, 'T-shirt', 'Fashion', 1500),
(108, 'Camera', 'Electronics', 60000),
(109, 'Tablet', 'Electronics', 35000),
(110, 'Sunglasses', 'Accessories', 2500);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders VALUES
(201, 1, '2023-02-15', 85000),
(202, 2, '2023-05-10', 3000),
(203, 3, '2023-07-22', 125000),
(204, 1, '2023-08-15', 50000),
(205, 4, '2023-09-05', 12000),
(206, 5, '2023-09-12', 90000),
(207, 6, '2023-10-02', 20000),
(208, 7, '2023-10-10', 75000),
(209, 8, '2023-10-18', 18000),
(210, 2, '2023-11-01', 50000),
(211, 9, '2023-09-23', 42000),
(212, 10, '2023-08-09', 27000);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails VALUES
(301, 201, 101, 1),
(302, 201, 103, 2),
(303, 202, 107, 3),
(304, 203, 101, 1),
(305, 203, 106, 1),
(306, 204, 102, 1),
(307, 205, 104, 2),
(308, 206, 108, 1),
(309, 207, 105, 4),
(310, 208, 101, 1),
(311, 209, 107, 2),
(312, 210, 106, 1),
(313, 211, 109, 2),
(314, 212, 110, 3);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT
);

INSERT INTO Employees VALUES
(501, 'Rohit Mehta', 'Sales', 60000, NULL),
(502, 'Sneha Patel', 'Sales', 50000, 501),
(503, 'Arjun Rao', 'Support', 45000, 501),
(504, 'Emily Carter', 'Marketing', 70000, NULL),
(505, 'David Miller', 'Marketing', 40000, 504),
(506, 'Ananya Gupta', 'HR', 55000, NULL),
(507, 'Alex Wong', 'Sales', 48000, 501),
(508, 'Riya Verma', 'Support', 42000, 503);


################################### Practice ########################################
-- Result Type 
-- 1. Scaler Subquery
 SELECT AVG(GPA) Avrage_GPA From students;
 
-- Row Subquesry 
SELECT Fullname from students;

-- Table Subquery
SELECT Fullname , GPA from students;

-- Subquery Location Clause
-- From Clause
SELECT * From 
(
	SELECT
	CustomerID,
    OrderTotal,
    AVG(OrderTotal) Over () as AVGTotal
    FROM omkar_db.orders
) as T 
where OrderTotal > AVGTotal;

-- SELECT Subquesry
SELECT -- Main Quesry
product_id,
product_name,
price,
(SELECT COUNT(*) FROM sales.orders) as Total_orders -- Subquery 
FROM sales.products;

-- JOIN Clause 
-- show all customer details and find the total orders ot each customer

-- Mail Quesry
SELECT
c.*,
o.TotalOrders
From sales.customers c
LEFT JOIN(
			SELECT 
			customer_id,
			COUNT(*) TotalOrders
			FROM sales.orders
			GROUP BY customer_id) o
ON c.customer_id = o.customer_id;

-- SELECT Subqurey
SELECT 
	product_name,
    price 
FROM 
	sales.products
WHERE 
	price > (SELECT AVG(price) from sales.products);

-- IN/NOT IN Subquery
SELECT * FROM sales.orders
WHERE customer_id IN
					(SELECT customer_id
                     FROM sales.customers
                     WHERE country = 'India');

SELECT * FROM sales.orders
WHERE customer_id NOT IN 
						(SELECT customer_id 
                        FROM sales.customers 
                        WHERE country = 'India');

-- ANY/ALL
SELECT 
	emp_id,emp_name,salary
FROM sales.employees
WHERE gender = 'Female' 
and salary > ANY (
				  SELECT salary 
				  FROM sales.employees 
				  WHERE gender = 'male');
                  
SELECT 
	emp_id,emp_name,salary
FROM sales.employees
WHERE gender = 'Female' 
and salary > ALL (
				  SELECT salary 
				  FROM sales.employees 
				  WHERE gender = 'male');

-- EXISTS Operator (Correlated Subquery)
SELECT * from sales.orders o
WHERE EXISTS (SELECT 1 from sales.customers c 
			  WHERE country = 'India' 
              and o.customer_id = c.customer_id);

SELECT * from sales.orders o
WHERE NOT EXISTS (SELECT 1 from sales.customers c 
			  WHERE country = 'India' 
              and o.customer_id = c.customer_id);
################################### Practice ########################################

-- =====================================================
-- Beginner (Q1–Q8)
-- Focus: WHERE clause with scalar and IN subqueries
-- =====================================================

-- Q1: Find the names of all customers who are in the same country as 'Amit Sharma'.
SELECT customer_name from sales.customers
WHERE country = (SELECT country FROM sales.customers WHERE customer_name = 'Amit sharma');

-- Q2: Find all orders that include the product 'Laptop' 
-- (use a subquery on Products to get product_id, then OrderDetails to get order_id).

SELECT o.order_id,p.Product_name FROM sales.orderdetails o
INNER JOIN 
(
	Select Product_id ,Product_name
    from sales.products 
    where Product_name = 'Laptop'
) p
on o.product_id = p.product_id; 

-- Q3: Find all orders whose total_amount is greater than the average order amount across all orders.
SELECT order_id,total_amount
FROM sales.orders
WHERE total_amount > (SELECT avg(total_amount) FROM sales.orders);

-- Q4: List full names of customers who have placed at least one order (use IN on Orders).
SELECT customer_name FROM sales.customers 
WHERE customer_id IN (SELECT customer_id FROM sales.orders );

-- Q5: List full names of customers who have no orders (use NOT IN on Orders).
SELECT customer_name FROM sales.customers 
WHERE customer_id NOT IN (SELECT customer_id FROM sales.orders );

-- Q6: Find the order(s) with the highest total_amount.
SELECT order_id , total_amount FROM sales.orders
WHERE total_amount = (SELECT MAX(total_amount) from sales.orders);

-- Q7: List all product names that are in the same category as 'Camera'.
SELECT product_name FROM sales.products
WHERE category IN (SELECT category FROM sales.products WHERE product_name = 'Camera');

-- Q8: List all 'Fashion' products whose price is below the average price of all 'Electronics' products.
SELECT product_name,price FROM sales.products
WHERE category = 'Fashion' 
and price < (
				SELECT AVG(price) 
                FROM sales.products 
                WHERE category = 'Electronics'
			);

-- =====================================================
-- Intermediate (Q9–Q17)
-- Focus: FROM (derived tables), EXISTS, correlated subqueries
-- =====================================================
-- Q9: Find all product categories that have at least one ordered product (use EXISTS with OrderDetails).
SELECT category FROM sales.products p
WHERE EXISTS (SELECT 1 FROM sales.orderdetails o WHERE p.product_id = o.product_id)
GROUP BY category;
 
-- Q10: Find all products that have never been ordered (use NOT EXISTS with OrderDetails).
SELECT product_id,product_name,category FROM sales.products p
WHERE NOT EXISTS (SELECT 1 FROM sales.orderdetails o WHERE p.product_id = o.product_id);

-- Q11: Return order_id and total_amount for orders whose total_amount is greater than the average total_amount for that same customer (correlated subquery).
SELECT o1.order_id,o1.total_amount FROM sales.orders o1
WHERE o1.total_amount > (SELECT AVG(o2.total_amount) 
						 FROM sales.orders o2 
                         WHERE o1.customer_id = o2.customer_id);

-- Q12: Using a subquery in the FROM clause (derived table), compute the average price of all products in the 'Electronics' category.
SELECT * 
FROM (
		SELECT
		product_name,price, round(AVG(price) over (),2)  Avg_price
        From sales.products WHERE category = 'Electronics'
) as t ;

-- Q13: Show each product’s product_id, product_name, price, and a new column CategoryAvgPrice that shows the average price for that product’s category (correlated subquery on Products).
SELECT 
p1.product_id,
p1.product_name,
p1.price,
(SELECT round(avg(price),2) from sales.products p2 WHERE p2.category = p1.category) as AVG_price
FROM sales.products p1;

-- Q14: List the full names of customers who bought any product with quantity >= 3 in a single order line (subquery on OrderDetails → Orders → Customers).
SELECT c.customer_name FROM sales.customers c
WHERE c.customer_id IN 
(SELECT o.customer_id FROM sales.orders o WHERE o.order_id IN 
(SELECT od.order_id FROM sales.orderdetails od WHERE od.quantity >= 3 ));

-- Q15: Find all customers who have ordered at least one product from the 'Electronics' category.
SELECT c.customer_name FROM sales.customers c
WHERE EXISTS 
(SELECT 1 FROM sales.orders o 
		JOIN sales.orderdetails od ON o.order_id = od.order_id
        JOIN sales.products p ON od.product_id = p.product_id
        WHERE
            c.customer_id = o.customer_id 
		AND p.category = 'Electronics');

-- Q16: Find all customers who have purchased 'Laptop' and whose total spending is higher than 'John Smith's total spending.
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spending
FROM
    sales.customers c
JOIN
    sales.orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.customer_name
HAVING
    -- Condition 1: Their total spending is > John Smith's total
    SUM(o.total_amount) > (
        SELECT SUM(o_john.total_amount)
        FROM sales.customers c_john
        JOIN sales.orders o_john ON c_john.customer_id = o_john.customer_id
        WHERE c_john.customer_name = 'John Smith'
    )
    -- Condition 2: Their customer_id is in the list of 'Laptop' buyers
    AND c.customer_id IN (
        SELECT DISTINCT o_laptop.customer_id
        FROM sales.orders o_laptop
        JOIN sales.orderdetails od_laptop ON o_laptop.order_id = od_laptop.order_id
        JOIN sales.products p_laptop ON od_laptop.product_id = p_laptop.product_id
        WHERE p_laptop.product_name = 'Laptop'
    );
    
	-- Q17: Find all customers who have placed at least one order but have never purchased 'Smartphone'.
SELECT
    c.customer_name
FROM
    sales.customers c
WHERE
	-- Condition 1: Find all customers who have placed at least one order
    EXISTS (
        SELECT 1
        FROM sales.orders o
        WHERE o.customer_id = c.customer_id
    )
    AND
    -- Condition 2: From that list, remove customers who have EVER bought a 'Smartphone'
    NOT EXISTS (
        SELECT 1
        FROM sales.orders o
        JOIN sales.orderdetails od ON o.order_id = od.order_id
        JOIN sales.products p ON od.product_id = p.product_id
        WHERE
            o.customer_id = c.customer_id
            AND p.product_name = 'Smartphone'
    );
-- =====================================================
-- SQL PRACTICE ANSWERS: SalesDB (Q18–Q25)
-- Tables: Customers, Orders, OrderDetails, Products, Employees
-- =====================================================

-- Q18: Find the customers who have the highest total spending within their respective country.
WITH customer_spend AS (
    SELECT
        c.country,
        c.customer_id,
        c.customer_name,
        SUM(o.total_amount) AS total_spend,
        RANK() OVER (PARTITION BY c.country ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM Customers c
    JOIN Orders o ON o.customer_id = c.customer_id
    GROUP BY c.country, c.customer_id, c.customer_name
)
SELECT country, customer_id, customer_name, total_spend
FROM customer_spend
WHERE rnk = 1;

-- Q19: Using a derived table, first calculate the average order amount per country,
-- then join it back to list customers whose average order amount is above their country’s average.
WITH cust_avg AS (
    SELECT
        c.country,
        c.customer_id,
        c.customer_name,
        AVG(o.total_amount) AS avg_order_amt
    FROM Customers c
    JOIN Orders o ON o.customer_id = c.customer_id
    GROUP BY c.country, c.customer_id, c.customer_name
),
country_avg AS (
    SELECT
        c.country,
        AVG(o.total_amount) AS country_avg_order_amt
    FROM Customers c
    JOIN Orders o ON o.customer_id = c.customer_id
    GROUP BY c.country
)
SELECT ca.country, ca.customer_id, ca.customer_name, ca.avg_order_amt, co.country_avg_order_amt
FROM cust_avg ca
JOIN country_avg co ON ca.country = co.country
WHERE ca.avg_order_amt > co.country_avg_order_amt;

-- Q20: Find the full names of customers who buy only 'Electronics' products across all their orders (use NOT EXISTS).
SELECT DISTINCT c.customer_id, c.customer_name
FROM Customers c
WHERE EXISTS (  -- has at least one purchase
    SELECT 1
    FROM Orders o
    JOIN OrderDetails od ON od.order_id = o.order_id
    JOIN Products p ON p.product_id = od.product_id
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS ( -- has no purchase outside Electronics
    SELECT 1
    FROM Orders o
    JOIN OrderDetails od ON od.order_id = o.order_id
    JOIN Products p ON p.product_id = od.product_id
    WHERE o.customer_id = c.customer_id
      AND p.category <> 'Electronics'
);

-- Q21: List all product categories where the minimum product price is greater than the average price of 'Fashion' products.
SELECT category
FROM Products
GROUP BY category
HAVING MIN(price) > (
    SELECT AVG(price) FROM Products WHERE category = 'Fashion'
);

-- Q22: Using a derived table over OrderDetails joined to Products, find the product category with the highest total quantity sold.
WITH category_qty AS (
    SELECT p.category, SUM(od.quantity) AS total_qty
    FROM OrderDetails od
    JOIN Products p ON p.product_id = od.product_id
    GROUP BY p.category
),
ranked AS (
    SELECT category, total_qty, RANK() OVER (ORDER BY total_qty DESC) AS rnk
    FROM category_qty
)
SELECT category, total_qty
FROM ranked
WHERE rnk = 1;

-- Q23: Find all 'Electronics' products priced higher than ANY product in 'Accessories' (use > ANY).
SELECT product_id, product_name, price
FROM Products
WHERE category = 'Electronics'
  AND price > ANY (SELECT price FROM Products WHERE category = 'Accessories');

-- Q24: Find the product name with the highest average line revenue (quantity * price) across its order lines.
WITH per_product AS (
    SELECT
        p.product_id,
        p.product_name,
        AVG(od.quantity * p.price) AS avg_line_revenue
    FROM OrderDetails od
    JOIN Products p ON p.product_id = od.product_id
    GROUP BY p.product_id, p.product_name
),
r AS (
    SELECT *, RANK() OVER (ORDER BY avg_line_revenue DESC) AS rnk
    FROM per_product
)
SELECT product_id, product_name, avg_line_revenue
FROM r
WHERE rnk = 1;

-- Q25: Find the average total_amount of customers who have at least one high-value order (e.g., total_amount > 50000).
-- (Average across all orders placed by those customers.)
SELECT AVG(o.total_amount) AS avg_order_amount_high_value_customers
FROM Orders o
WHERE o.customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE total_amount > 50000
);

-- =====================================================
-- END OF FILE
-- =====================================================
-- ===========================================================
-- 📘 SQL PRACTICE FILE: SalesDB Subquery Exercises (30 Questions)
-- LEVEL: Easy → Medium → Moderate
-- Tables: Customers, Orders, OrderDetails, Products, Employees
-- ===========================================================


-- ===========================================================
-- 🟢 LEVEL 1 — EASY (Scalar + IN Subqueries)
-- ===========================================================

-- Q1: Find all customers from the same country as 'Amit Sharma'.
SELECT customer_name from sales.customers
WHERE country In (
	SELECT country FROM sales.customers
    WHERE customer_name = 'Amit Sharma'
);
-- Q2: Display all orders whose total_amount is greater than the average total_amount of all orders.
SELECT * from sales.orders
WHERE total_amount > (SELECT AVG(total_amount)from sales.orders);

-- Q3: Show product names whose price is higher than the average product price.
SELECT product_name,price from  sales.products 
WHERE price > (SELECT avg(price) from sales.products);

-- Q4: List all orders made by customers from 'India'.
SELECT customer_id,customer_name,country from sales.customers
WHERE customer_id In (SELECT customer_id from sales.orders );

-- Q5: Display all products belonging to the same category as 'Laptop'.
SELECT product_name FROM sales.products
WHERE category in (SELECT category FROM sales.products WHERE product_name = 'Laptop');

-- Q6: Find the employee(s) who have the maximum salary in the company.
SELECT emp_name,salary FROM sales.employees
WHERE salary = (SELECT max(salary) from sales.employees);

-- Q7: Display all customers who have placed at least one order.
SELECT customer_name FROM sales.customers
WHERE customer_id In (SELECT customer_id from sales.orders);

-- Q8: Display customers who have never placed an order.
SELECT customer_name FROM sales.customers
WHERE customer_id NOT In (SELECT customer_id from sales.orders);

-- Q9: Show all orders that include the product 'Smartphone'.

SELECT * from sales.orders
WHERE order_id in 
(SELECT order_id from sales.orderdetails WHERE product_id in 
(SELECT product_id from sales.products WHERE product_name = 'smartphone'));

-- Q10: Display the product name and price for products cheaper than the average price in their category.
SELECT p.product_name,p.price from sales.products p 
where p.price < (
	SELECT AVG(p2.price) from sales.products p2
    WHERE p.category = p2.category
);


-- ===========================================================
-- 🟡 LEVEL 2 — MEDIUM (WHERE, SELECT & FROM Subqueries)
-- ===========================================================

-- Q11: Find customers who have made orders with a total amount greater than 50,000.
SELECT customer_id,customer_name from sales.customers
WHERE customer_id in (SELECT customer_id FROM sales.orders WHERE total_amount > 50000);

-- Q12: Show each customer's name and their highest order amount (subquery in SELECT).
SELECT customer_name, 
(SELECT MAX(total_amount) from sales.orders o WHERE o.customer_id = c.customer_id )  as max_am
from sales.customers c;

-- Q13: Find all orders placed by customers who live in 'Australia'.
SELECT * from sales.orders
WHERE customer_id in (SELECT customer_id from sales.customers WHERE country = 'Australia');

-- Q14: List all categories where at least one product's price is below 5,000.
SELECT DISTINCT category FROM sales.products
WHERE category IN  (SELECT category FROM sales.products WHERE price < 5000);

-- Q15: Show customers whose average order total is greater than the overall average order total.

-- Q16: Display all customers who purchased more than one product type.

-- Q17: Find products that were ordered by both Indian and US customers (use IN + subquery).

-- Q18: List products that no customer has ever ordered (use NOT IN).

-- Q19: Find all customers whose total spending equals the maximum total spending among all customers.

-- Q20: Show each product's name and its total quantity sold, using a subquery in FROM (derived table).


-- ===========================================================
-- 🟠 LEVEL 3 — MODERATE (Nested, Correlated & EXISTS-based)
-- ===========================================================

-- Q21: Find customers who have placed more than one order (use correlated subquery).

-- Q22: Display employees whose salary is greater than the average salary of their department.

-- Q23: List customers who have ordered at least one product from the 'Electronics' category (use EXISTS).

-- Q24: Find orders made by customers who belong to countries with average spending above 50,000.

-- Q25: Show product categories whose minimum price is higher than the average price of 'Fashion' products.

-- Q26: Display the names of customers who have ordered every Electronics product (use NOT EXISTS).

-- Q27: Find customers whose latest order total_amount is above the average order total of all customers.

-- Q28: List countries that have at least one customer with no orders (nested EXISTS).

-- Q29: Find employees whose salary is less than any employee in the 'Marketing' department (use < ANY).

-- Q30: Show all 'Electronics' products whose price is greater than all 'Accessories' product prices (use > ALL).



