CREATE DATABASE CTE;

USE CTE;

-- 1. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Country VARCHAR(50)
);

INSERT INTO Customers (CustomerID, FullName, Country) VALUES
(1, 'Aditya Sharma', 'India'),
(2, 'Jane Smith', 'USA'),
(3, 'Kenji Tanaka', 'Japan'),
(4, 'Emily White', 'UK'),
(5, 'Rohan Gupta', 'India'),
(6, 'Chris Lee', 'USA');

-- 2. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(101, 'Laptop', 'Electronics', 1200.00),
(102, 'Smartphone', 'Electronics', 800.00),
(103, 'Coffee Maker', 'Appliances', 60.00),
(104, 'SQL for Beginners', 'Books', 45.00),
(105, 'Running Shoes', 'Apparel', 110.00),
(106, 'Headphones', 'Electronics', 150.00);

-- 3. Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-01-17'),
(3, 1, '2024-02-01'),
(4, 3, '2024-02-05'),
(5, 5, '2024-02-10'),
(6, 4, '2024-02-12'),
(7, 2, '2024-03-01'),
(8, 6, '2024-03-05');

-- 4. OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 101, 1),  -- Aditya, Laptop
(2, 1, 106, 2),  -- Aditya, Headphones
(3, 2, 102, 1),  -- Jane, Smartphone
(4, 3, 104, 3),  -- Aditya, SQL Book
(5, 3, 103, 1),  -- Aditya, Coffee Maker
(6, 4, 101, 1),  -- Kenji, Laptop
(7, 4, 102, 1),  -- Kenji, Smartphone
(8, 5, 105, 1),  -- Rohan, Running Shoes
(9, 6, 106, 1),  -- Emily, Headphones
(10, 7, 105, 2), -- Jane, Running Shoes
(11, 8, 102, 1); -- Chris, Smartphone
############################################################# Practice #############################################################
-- Standalone CTE
WITH CTE_Total_Sales AS
(
SELECT customer_id,SUM(total_amount) as Total_sales 
FROM sales.orders
GROUP BY customer_id
)
-- Main Query 
SELECT 
c.customer_id,
c.customer_name,
cts.Total_sales
FROM sales.customers c
INNER JOIN CTE_Total_Sales cts
ON cts.customer_id = c.customer_id;

-- Multiple Standalone CTE
-- Find the last order date of the customer
-- CTE No 1
WITH CTE_Total_Sales AS
(
SELECT customer_id,SUM(total_amount) as Total_sales 
FROM sales.orders
GROUP BY customer_id
),
-- CTE No 2
CTE_Last_order as
(
SELECT customer_id, MAX(Order_Date) as Last_order
FROM sales.orders
GROUP BY customer_id
)
-- Main Query 
SELECT 
c.customer_id,
c.customer_name,
cts.Total_sales,
clo.Last_order
FROM sales.customers c
INNER JOIN CTE_Total_Sales cts
ON cts.customer_id = c.customer_id
INNER JOIN CTE_Last_order as clo
ON clo.customer_id = c.customer_id;

-- Nested CTE
-- CTE No 1
WITH CTE_Total_Sales AS
(
SELECT customer_id,
SUM(total_amount) as Total_sales 
FROM sales.orders
GROUP BY customer_id
),
-- CTE No 2
CTE_Last_order as
(
SELECT customer_id, 
MAX(Order_Date) as Last_order
FROM sales.orders
GROUP BY customer_id
),
CTE_Customer_rank as
(
SELECT 
customer_id,
Total_sales,
RANK () OVER (ORDER BY Total_sales desc) as CustomerRank
FROM CTE_Total_Sales
)
-- Main Query 
SELECT 
c.customer_id,
c.customer_name,
cts.Total_sales,
clo.Last_order,
ccr.CustomerRank
FROM sales.customers c
INNER JOIN CTE_Total_Sales cts
ON cts.customer_id = c.customer_id
INNER JOIN CTE_Last_order as clo
ON clo.customer_id = c.customer_id
LEFT join CTE_Customer_rank as ccr
ON ccr.customer_id = c.customer_id;

-- Nested two with case 
-- CTE No 1
WITH CTE_Total_Sales AS
(
SELECT customer_id,SUM(total_amount) as Total_sales 
FROM sales.orders
GROUP BY customer_id
),
-- CTE No 2
CTE_Last_order as
(
SELECT customer_id, MAX(Order_Date) as Last_order
FROM sales.orders
GROUP BY customer_id
)
-- Main Query 
SELECT 
c.customer_id,
c.customer_name,
cts.Total_sales,
clo.Last_order
FROM sales.customers c
INNER JOIN CTE_Total_Sales cts
ON cts.customer_id = c.customer_id
INNER JOIN CTE_Last_order as clo
ON clo.customer_id = c.customer_id;

-- Nested CTE
-- CTE No 1
WITH CTE_Total_Sales AS
(
SELECT customer_id,
SUM(total_amount) as Total_sales 
FROM sales.orders
GROUP BY customer_id
),
-- CTE No 2
CTE_Last_order as
(
SELECT customer_id, 
MAX(Order_Date) as Last_order
FROM sales.orders
GROUP BY customer_id
),
-- CTE 3 that pull result from cte 1
CTE_Customer_rank as
(
SELECT 
customer_id,
Total_sales,
RANK () OVER (ORDER BY Total_sales desc) as CustomerRank
FROM CTE_Total_Sales
),
CTE_Customer_segment as
(
SELECT customer_id,
Total_Sales,
CASE 
	When Total_Sales > 80000.00 Then 'High'
    when Total_Sales > 50000.00 THen 'Medium'
    ELSE 'Low'
    end Customer_segment
FROM CTE_Total_Sales
) 
-- Main Query 
SELECT 
c.customer_id,
c.customer_name,
cts.Total_sales,
clo.Last_order,
ccr.CustomerRank,
ccs.Customer_segment
FROM sales.customers c
INNER JOIN CTE_Total_Sales cts
ON cts.customer_id = c.customer_id
INNER JOIN CTE_Last_order as clo
ON clo.customer_id = c.customer_id
LEFT join CTE_Customer_rank as ccr
ON ccr.customer_id = c.customer_id
LEFT JOIN CTE_Customer_segment as ccs
ON ccs.customer_id = c.customer_id;
############################################################# Practice #############################################################

-- Beginner (Q1 - Q8)
-- (Focus: Using a CTE as a simple subquery replacement)

-- Q1: Write a query to find all customers from 'India'. Use a CTE named Indian_Customers.
WITH indian_Customers as
(
SELECT customer_id FROM sales.customers
WHERE country = 'India'
)
SELECT i.customer_id,c.customer_name,c.country,c.city,c.join_date 
from sales.customers c
INNER JOIN indian_Customers as i
on i.customer_id = c.customer_id;

-- Q2: Write a query to list all products in the 'Electronics' category. Use a CTE named Electronic_Products.
With Electronic_Products as 
(
SELECT
	product_id,
    category
FROM sales.products
where category = 'Electronics'
)
SELECT p.product_name
FROM products as p
INNER JOIN Electronic_Products as e
ON e.product_id = p.product_id;

-- Q3: Write a query to find all orders placed in February 2024. Use a CTE named Feb_Orders.
WITH Feb_Orders as
(SELECT *
from sales.orders
where month(order_date) = 2
and year(order_date) = 2023
)
SELECT *
FROM Feb_Orders;

-- Q4: Using a CTE, list the FullName of all customers who placed an order (don't worry about duplicates yet).
WITH All_customer as(
SELECT customer_id
FROM sales.orders
)
SELECT c.customer_name 
FROM sales.customers as c
LEFT JOIN All_customer as ac
on ac.customer_id = c.customer_id;

-- Q5: Write a query to find all OrderDetails (all columns) that have a Quantity greater than 1. Use a CTE.
WITH All_colums as(
SELECT * 
FROM sales.orderdetails
WHERE quantity > 1
)
SELECT * FROM
All_colums;

-- Q6: Using a CTE, select all ProductName and Price for products that cost more than $100.
WITH all_products as (
SELECT product_name , price
FROM sales.products
WHERE price > 8868.75
)
SELECT * FROM 
all_products;

-- Q7: Write a query to show the OrderID and OrderDate for all orders placed by CustomerID 2. Use a CTE.
WITH all_orders as (
select Order_id , Order_date 
FROM sales.orders
WHERE customer_id = 2
)
SELECT * FROM 
all_orders;

-- Q8: Using a CTE, find the ProductName for ProductID 104.
WITH Pname as (
SELECT product_name
FROM sales.products
WHERE product_id = 104
)
SELECT * FROM
Pname;

-- Intermediate (Q9 - Q17)
-- (Focus: CTEs with aggregations, joins, and simple logic)
-- Q9: Using a CTE, calculate the total cost for each line item (i.e., Quantity * Price). The result should show OrderID, ProductName, and LineTotal.
WITH total_cost as (
SELECT  o.order_id, sum(od.quantity * o.total_amount) as LineTotal
FROM sales.orderdetails as od
LEFT JOIN orders as o
on od.order_id = o.order_id
GROUP BY order_id
) 
SELECT (od2.order_id),p.product_name,ts.LineTotal
FROM sales.products as p
LEFT JOIN orderdetails as od2
ON od2.product_id = p.product_id
LEFT JOIN total_cost as ts
ON ts.order_id = od2.order_id;

-- Q10: Write a query to find the total sales amount for each OrderID. Use a CTE to first get the LineTotal for each item (like in Q9) and then SUM them in the main query.
WITH total_cost as (
SELECT  o.order_id, sum(od.quantity * o.total_amount) as LineTotal
FROM sales.orderdetails as od
LEFT JOIN orders as o
on od.order_id = o.order_id
GROUP BY order_id
) 
SELECT (od2.order_id),sum(ts.LineTotal) as Total
FROM sales.products as p
LEFT JOIN orderdetails as od2
ON od2.product_id = p.product_id
LEFT JOIN total_cost as ts
ON ts.order_id = od2.order_id
GROUP BY od2.order_id;

-- Q11: Using a CTE, find the total number of orders placed by each customer (by FullName).
-- Q12: Write a query to find the total quantity of products sold for each ProductID. Use a CTE.
-- Q13: Using a CTE, find the average Price of products in the 'Electronics' category.
-- Q14: Write a query to find all customers (FullName) who have never placed an order. (Hint: Use a CTE to find all customers who *have* placed an order, then use a LEFT JOIN or NOT IN).
-- Q15: Using a CTE, list all products that have never been sold.
-- Q16: Write a query to get the FullName and Country of customers who bought a 'Laptop'.
-- Q17: Using a CTE, find the total revenue (sum of all LineTotals) generated in February 2024.

-- Advanced (Q18 - Q25)
-- (Focus: Multi-step CTEs, complex joins, and window functions)

-- Q18: (Multi-Step) Find the total sales revenue for each Country.
-- (Hint: You'll need one CTE to calculate line totals, a second CTE to join with Orders and Customers to get the country, and a final query to GROUP BY Country).
-- Q19: Find the customer (FullName) who has the highest total spending.
-- Q20: Using a CTE, find the top 3 best-selling products by total Quantity sold.
-- Q21: (Multi-Step) Find the average order value (AOV).
-- (Hint: First CTE to get the total for each order. Main query to AVG() those totals).
-- Q22: (Multi-Step) Find the total revenue generated by each product Category.
-- Q23: Write a query to rank customers by their total spending. Use a CTE and the DENSE_RANK() window function.
-- Q24: (Multi-Step) Find all customers who spent more than the average customer.
-- (Hint: CTE 1 to get total spending per customer. CTE 2 to get the overall average spending. Final query to compare).
-- Q25: Find the most popular product (by Quantity) purchased by customers from 'India'.