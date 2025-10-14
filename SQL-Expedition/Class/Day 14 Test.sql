-- Test
use omkar_db;
SELECT * FROM products;
SELECT * FROM sales_orders;

-- Show total quantity and total revenue per product.
SELECT product, SUM(quantity) AS total_quantity, SUM(quantity * price_per_unit) AS total_revenue FROM sales_orders
GROUP BY product;

-- Show average quantity and average unit price per region.
SELECT region,avg(quantity),avg(price_per_unit) from sales_orders
GROUP BY region;

-- Show min, max, and average price per unit for each product.
SELECT Product, MIN(price_per_unit) as Min_P,MAX(price_per_unit) MAX_P, AVG(price_per_unit) AVG_P FROM sales_orders
GROUP BY Product;

-- Show total quantity, total price, and number of orders per region.
SELECT region, SUM(quantity) as Total_quantity, SUM(price_per_unit) AS Total_Price, COUNT(*) AS order_count from sales_orders
GROUP BY region ;

-- List each customer’s total orders, total quantity, and total sales.
SELECT customer_name , COUNT(*) AS total_orders , sum(quantity * price_per_unit) as Total_sales from sales_orders
GROUP BY customer_name;


SELECT * FROM salaries;
use omkar_db;

CREATE TABLE managers (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(100),
    department VARCHAR(50),
    hire_date DATE,
    email VARCHAR(100),
    contact VARCHAR(15),
    salary DECIMAL(10, 2)
);


INSERT INTO managers (manager_id, manager_name, department, hire_date, email, contact, salary)
VALUES
(1, 'Rajesh Singh', 'Engineering', '2010-05-15', 'rajesh.singh@xyzmail.com', '9876543230', 120000.00),
(2, 'Meera Kapoor', 'Marketing', '2012-09-10', 'meera.kapoor@xyzmail.com', '9876543231', 95000.00),
(3, 'Vikas Mehta', 'Sales', '2008-11-20', 'vikas.mehta@xyzmail.com', '9876543232', 110000.00),
(4, 'Anjali Patil', 'HR', '2011-07-30', 'anjali.patil@xyzmail.com', '9876543233', 90000.00);

ALTER TABLE emp
ADD CONSTRAINT fk_emp_managers
FOREIGN KEY (manager_id)
REFERENCES managers(manager_id);



