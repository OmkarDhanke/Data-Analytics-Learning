CREATE TABLE SalesOrders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    Region VARCHAR(50),
    Salesperson VARCHAR(50),
    ProductCategory VARCHAR(50),
    SaleAmount DECIMAL(10,2)
);

INSERT INTO SalesOrders (OrderID, OrderDate, Region, Salesperson, ProductCategory, SaleAmount) 
VALUES
(101, '2025-01-15', 'North', 'Alice', 'Electronics', 1200),
(102, '2025-01-20', 'North', 'Alice', 'Appliances', 800),
(103, '2025-02-05', 'South', 'Bob', 'Electronics', 1500),
(104, '2025-02-10', 'West', 'Carol', 'Clothing', 300),
(105, '2025-03-12', 'North', 'David', 'Electronics', 2200),
(106, '2025-03-18', 'South', 'Bob', 'Appliances', 950),
(107, '2025-04-22', 'East', 'Alice', 'Clothing', 450),
(108, '2025-05-01', 'West', 'Carol', 'Electronics', 1800),
(109, '2025-05-15', 'North', 'David', 'Appliances', 700),
(110, '2025-06-20', 'South', 'Bob', 'Clothing', 250),
(111, '2025-07-07', 'East', 'Alice', 'Electronics', 1350),
(112, '2025-07-25', 'West', 'Carol', 'Appliances', 1100),
(113, '2025-08-30', 'North', 'David', NULL, 150),
(114, '2025-09-14', 'South', 'Bob', 'Electronics', 2500),
(115, '2025-10-02', 'East', 'Alice', 'Clothing', 500);

-- Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
-- COUNT
SELECT count(*) from SalesOrders 
WHERE Region = 'North';

SELECT COUNT(DISTINCT Salesperson) as Salesperson_Count from practice.salesorders;

-- SUM
SELECT sum(SaleAmount) as TotalAmount from practice.salesorders;

SELECT DISTINCT (sum(saleamount)) as DISTINCT_Amount from practice.salesorders;

-- AVG
SELECT AVG(SaleAmount) as Avrage FROM practice.salesorders;

-- MIN() and MAX()
SELECT MIN(SaleAmount)  as Min_amount , MAX(SaleAmount) as Max_Amount FROM practice.salesorders;

-- Grouping Data with GROUP BY
SELECT Region, sum(SaleAmount) as Totalsales, avg(SaleAmount) as avg_sales from practice.salesorders
GROUP BY Region;

-- Filtering Groups (HAVING vs. WHERE)
SELECT Department, AVG(Salary) from practice.employees
GROUP BY Department
HAVING AVG(Salary) > 70000.00;

-- Beginner (Q1–Q8)
-- Q1: Write a query to count the total number of orders in the SalesOrders table.
SELECT count(*) as TotalOrders from practice.salesorders;

-- Q2: Write a query to calculate the total sum of SaleAmount for all orders.
SELECT sum(SaleAmount) as Total_Sum from practice.salesorders;

-- Q3: Write a query to find the average SaleAmount of all orders.
SELECT avg(SaleAmount) as Avrage from practice.salesorders;

-- Q4: Write a query to find the highest SaleAmount from a single order.
SELECT MAX(SaleAmount) as Max_SaleAmount from practice.salesorders;

-- Q5: Write a query to find the lowest SaleAmount from a single order.
SELECT MIN(SaleAmount) as Lowest_SaleAmount from practice.salesorders;

-- Q6: Write a query to count the number of distinct regions where sales were made.
SELECT count(DISTINCT Region) from practice.salesorders;

-- Q7: Write a query to count the number of orders that have a ProductCategory listed (i.e., not NULL).
SELECT count(ProductCategory) as ProductCategory from practice.salesorders;

-- Q8: Write a query to find the total SaleAmount for all orders made by the salesperson 'Bob'.
SELECT sum(SaleAmount) as total_sale from practice.salesorders
WHERE Salesperson LIKE '%Bob%';

-- Intermediate (Q9–Q17)
-- Q9: Write a query to find the total SaleAmount for each Region.
SELECT Region,sum(SaleAmount) as SalesPerRegion 
from practice.salesorders
GROUP BY Region;

-- Q10: Write a query to count the number of orders handled by each Salesperson.
SELECT Salesperson, COUNT(OrderID) as HandelOrder 
from practice.salesorders
GROUP BY Salesperson;

-- Q11: Write a query to calculate the average SaleAmount for each ProductCategory.
SELECT ProductCategory, avg(SaleAmount) as Avg_Product_Sale
from practice.salesorders
GROUP BY ProductCategory;

-- Q12: Write a query to find the maximum SaleAmount achieved by each Salesperson.
SELECT Salesperson, max(SaleAmount) as MaxSalePerPerson
from practice.salesorders
GROUP BY Salesperson;

-- Q13: Write a query to show the total number of orders and the total SaleAmount for each Region.
SELECT Region, COUNT(OrderID) as TotalOrder , SUM(SaleAmount) as SaleAmountOFRegion
from practice.salesorders
GROUP BY region;

-- Q14: Write a query to list the number of unique salespeople operating in each Region.
SELECT Region, COUNT(DISTINCT Salesperson) as salespeople 
FROM practice.salesorders
GROUP BY Region;

-- Q15: Write a query to find the total SaleAmount for each Salesperson, but only for orders placed in the 'North' region.
SELECT Salesperson, sum(SaleAmount) as SaleAmount 
FROM practice.salesorders 
WHERE region = 'North'
GROUP BY Salesperson;

-- Q16: Write a query to group the data by both Region and Salesperson and show the total SaleAmount for each combination.
SELECT Region, Salesperson, sum(SaleAmount) as TotalAmount
from practice.salesorders
GROUP BY Region, Salesperson; 

-- Q17: Write a query to find the earliest OrderDate for each ProductCategory.
SELECT ProductCategory , MIN(OrderDate) as earliest_OrderDate
from practice.salesorders
GROUP BY ProductCategory;

-- Advanced (Q18–Q25)
-- Q18: Write a query to list the regions where the total SaleAmount is greater than $4000.
SELECT Region , sum(SaleAmount) as Total
from practice.salesorders
GROUP BY Region
HAVING sum(SaleAmount) > 4000.00;

-- Q19: Write a query to list the salespeople who have handled more than 3 orders.
SELECT Salesperson, COUNT(OrderID) as handled_orders
from practice.salesorders
GROUP BY Salesperson 
HAVING COUNT(OrderID) > 3;

-- Q20: Write a query to list the product categories that have an average SaleAmount below $800.
SELECT ProductCategory , avg(SaleAmount) as AVG_SaleAmount 
from practice.salesorders
GROUP BY ProductCategory
HAVING avg(SaleAmount) < 800.00;

-- Q21: Write a query to find the total SaleAmount for each Salesperson, but only include sales that occurred on or after May 1, 2025.
SELECT Salesperson, sum(SaleAmount) as Total
from practice.salesorders
WHERE OrderDate >= '2025-05-01'
GROUP BY Salesperson;

-- Q22: Write a query to list the salespeople who have a total SaleAmount over $2,000 specifically from 'Electronics' sales.
SELECT Salesperson, sum(SaleAmount) as Total
from practice.salesorders
WHERE ProductCategory = 'Electronics'
GROUP BY Salesperson
HAVING sum(SaleAmount) > 2000.00;

-- Q23: Write a query to show the regions where the minimum SaleAmount for an order in that region is less than $300.
SELECT Region, MIN(SaleAmount) as minimum_SaleAmount 
FROM practice.salesorders
GROUP BY Region
HAVING MIN(SaleAmount) < 300.00;

-- Q24: Write a query to list the product categories that have been sold more than twice and also have a total SaleAmount greater than $1,500.
SELECT ProductCategory, COUNT(OrderID) as TotalOrder, SUM(SaleAmount) as TotalSaleAmount
from practice.salesorders
GROUP BY ProductCategory
HAVING COUNT(OrderID) > 2 and SUM(SaleAmount) > 1500.00;

-- Q25: Write a query to find the total sales for salespeople who operate in the 'East' or 'West' regions, but only show the salespeople whose total sales in those regions exceed $3,000.
SELECT Salesperson,COUNT(OrderID) as TotalOrader , sum(SaleAmount) as SaleAmount
from practice.salesorders
WHERE Region in ('East', 'West')
GROUP BY Salesperson
HAVING sum(SaleAmount) > 3000.00;

