
-- Aggrega!e Functions: COUNT, SUM, AVG, MIN, MAX.

-- GROUP BY
SELECT department, avg(salary) from emp
GROUP BY department;

-- 
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(30)
);

SELECT * from sales_orders;

INSERT INTO sales_orders (order_id, customer_name, product, quantity, price_per_unit, order_date, region) VALUES
(1, 'Alice', 'Laptop', 2, 60000, '2025-08-01', 'North'),
(2, 'Bob', 'Mouse', 5, 500, '2025-08-02', 'South'),
(3, 'Charlie', 'Keyboard', 3, 1500, '2025-08-03', 'East'),
(4, 'David', 'Monitor', 2, 12000, '2025-08-03', 'West'),
(5, 'Eve', 'Laptop', 1, 62000, '2025-08-04', 'North'),
(6, 'Frank', 'Mouse', 10, 450, '2025-08-04', 'South'),
(7, 'Grace', 'Monitor', 1, 11500, '2025-08-05', 'East'),
(8, 'Heidi', 'Laptop', 3, 58000, '2025-08-06', 'West'),
(9, 'Ivan', 'Keyboard', 4, 1600, '2025-08-06', 'North'),
(10, 'Judy', 'Mouse', 7, 480, '2025-08-07', 'East'),
(11, 'Kevin', 'Monitor', 2, 12500, '2025-08-07', 'South'),
(12, 'Laura', 'Laptop', 1, 60000, '2025-08-08', 'East'),
(13, 'Mallory', 'Keyboard', 2, 1550, '2025-08-08', 'North'),
(14, 'Niaj', 'Mouse', 4, 470, '2025-08-09', 'West'),
(15, 'Olivia', 'Laptop', 2, 61000, '2025-08-09', 'South'),
(16, 'Peggy', 'Monitor', 1, 13000, '2025-08-10', 'East'),
(17, 'Quentin', 'Keyboard', 5, 1500, '2025-08-10', 'North'),
(18, 'Rupert', 'Mouse', 3, 500, '2025-08-11', 'West'),
(19, 'Sybil', 'Laptop', 1, 60500, '2025-08-11', 'North'),
(20, 'Trent', 'Monitor', 2, 11800, '2025-08-12', 'South');

SELECT * from sales_orders;
-- Count total number of orders.
SELECT  COUNT(order_id) as Total_Order from sales_orders;

-- Find total quantity of products sold.
SELECT sum(quantity) as 'products sold' from sales_orders;

-- Calculate the total sales revenue (quantity * price_per_unit).
SELECT order_id, (quantity * price_per_unit) as 'total sales revenue' from sales_orders;

-- What is the average price per unit for all products?
SELECT avg(price_per_unit) as 'average price' from sales_orders;

-- What is the maximum order quantity in a single order?
SELECT MAX(quantity) as Max_quantity from sales_orders;



-- GROUP BY
-- Total quantity sold per product.
SELECT product, SUM(quantity) FROM sales_orders
GROUP BY product;

-- Total revenue per region.
SELECT region, sum(quantity * price_per_unit) as Total_revenue from sales_orders
GROUP BY region;

-- Average price per unit per product.
SELECT product, avg(price_per_unit) as price_per_unit  from sales_orders
GROUP BY product;

-- Count of orders placed in each region.
SELECT region, COUNT(order_id) as Order_placed from sales_orders
GROUP BY region;

-- Total revenue generated per customer.
SELECT customer_name, sum(quantity * price_per_unit) as 'generated revenue' from sales_orders
GROUP BY customer_name;

-- HAVING Clause
-- Show products with total sales quantity more than 10.
SELECT product , SUM(quantity) as quantity from sales_orders
GROUP BY product HAVING SUM(quantity) > 10;

-- Show regions where total revenue is more than 1,00,000.
SELECT region, sum(quantity * price_per_unit) as Total_Revenue from sales_orders
GROUP BY region HAVING sum(quantity * price_per_unit) > 100000.00; 

-- List customers who placed orders totaling more than ₹60,000.
SELECT customer_name, sum(quantity * price_per_unit) as 'Total_Order_Amount' from sales_orders
GROUP BY customer_name HAVING  sum(quantity * price_per_unit) > 60000.00;

-- Show regions where the average price per unit is greater than ₹10,000.
SELECT region, AVG(price_per_unit) as price_per_unit from sales_orders
GROUP BY region HAVING AVG(price_per_unit) > 10000.00;

-- Show products with average order quantity more than 2.
SELECT product,AVG(quantity) as AVG_quantity from sales_orders
GROUP BY product HAVING AVG(quantity) > 2;