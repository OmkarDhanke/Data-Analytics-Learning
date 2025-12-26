Create database Revision;
use Revision;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'HR');

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary INT,
    HireDate DATE,
    Region VARCHAR(50),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate, Region) VALUES
(1, 'Priya', 'Sharma', 1, 80000, '2021-03-15', 'North'),
(2, 'Rohan', 'Gupta', 1, 95000, '2020-05-22', 'North'),
(3, 'Ananya', 'Singh', 2, 110000, '2019-11-01', 'West'),
(4, 'Vikram', 'Mehra', 3, 140000, '2018-07-10', 'West'),
(5, 'Aditi', 'Verma', 1, 82000, '2022-01-10', 'North'),
(6, 'Arjun', 'Kumar', 2, 150000, '2019-02-18', 'West'),
(7, 'Sneha', 'Patel', 2, 130000, '2020-08-30', 'North'),
(8, 'Karan', 'Jain', 1, 78000, '2023-04-12', 'North'),
(9, 'Meera', 'Das', 3, 85000, '2021-06-05', 'North'),
(10, 'Sahil', 'Khan', 1, 92000, '2022-09-20', 'North'),
(11, 'Pooja', 'Mishra', 2, 120000, '2023-11-25', 'West'),
(12, 'Rahul', 'Nair', 1, 55000, '2024-01-15', 'North'),
(13, 'Aisha', 'Bose', 3, 145000, '2019-04-30', 'North'),
(14, 'Varun', 'Reddy', 2, 125000, '2022-07-19', 'North'),
(15, 'Zara', 'Ali', 1, 75000, '2023-10-01', 'North'),
(16, 'Yash', 'Thakur', NULL, 60000, '2023-03-05', 'North'),
(17, 'Isha', 'Malik', 1, 88000, '2021-12-10', NULL),
(18, 'Dev', 'Anand', 2, 135000, '2020-10-05', 'West'),
(19, 'Nia', 'Joseph', 3, 90000, '2022-05-18', 'North'),
(20, 'Om', 'Chopra', 1, 81000, '2021-08-21', 'North');

CREATE TABLE SalesLog (
    SaleID INT PRIMARY KEY,
    EmployeeID INT,
    SaleAmount INT,
    SaleDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO SalesLog (SaleID, EmployeeID, SaleAmount, SaleDate) VALUES
(1001, 1, 1500, '2025-01-20'),
(1002, 2, 2200, '2025-01-22'),
(1003, 1, 1800, '2025-02-01'),
(1004, 3, 3000, '2025-02-05'),
(1005, 2, 2500, '2025-03-10'),
(1006, 1, 2000, '2025-04-05'),
(1007, 3, 1000, '2025-04-15'),
(1008, 5, 500, '2025-05-02'),
(1009, 1, 1000, '2025-05-20'),
(1010, 2, 2800, '2025-06-11'),
(1011, 7, 1200, '2025-01-30'),
(1012, 1, 100, '2025-02-15'),
(1013, 8, 750, '2025-04-08'),
(1014, 10, 1100, '2025-06-01');

-- 📅 Day 1-2: Basic Filtering & Sorting

-- 1. Write a query to select the FirstName, LastName, and Salary of all employees.
SELECT Firstname, Lastname,salary from employees;

-- 2. Write a query to find all employees who work in the 'North' region.
SELECT * from employees
WHERE Region = 'North';

-- 3. Write a query to retrieve all details for employees with a Salary greater than 100,000.
SELECT * from employees
where Salary > 100000;

-- 4. Write a query to find all employees hired before January 1, 2021.
SELECT * from employees
where HireDate < '2021-01-01';

-- 5. Write a query to list all employees, sorted by their Salary from highest to lowest.
SELECT * from employees 
ORDER BY salary DESC;

-- 6. Write a query to find all employees whose Salary is between 70,000 and 90,000.
SELECT * from employees
WHERE Salary BETWEEN 70000 and 90000;

-- 7. Write a query to find all employees who are in DepartmentID 1 or 3. Use the IN operator.
SELECT * FROM employees
WHERE DepartmentID IN (1,3);

-- 8. Write a query to find all employees whose FirstName starts with the letter 'A'.
SELECT * from employees
WHERE FirstName like 'A%';

-- 9. Write a query to find all employees who are not in the 'North' region.
SELECT * FROM employees
WHERE Region != ('North');

-- 10. Write a query to find all employees who do not have a Region listed (assume some Region values are NULL).
SELECT * from employees
WHERE Region is null;

-- 📊 Day 3-4: Aggregation & Grouping

-- 11. Write a query to count the total number of employees in the Employees table.
SELECT COUNT(EmployeeID) as Total_Employee from employees;

-- 12. Write a query to find the average Salary of all employees.
SELECT round(AVG(salary),2) as Average_salary from employees;

-- 13. Write a query to find the total SaleAmount from the SalesLog table.
SELECT round(sum(SaleAmount),2) as Total_sale FROM saleslog;

-- 14. Write a query to find the highest and lowest Salary in the company.
SELECT MAX(salary) as highest, MIN(Salary) as Lowest from employees;

-- 15. Write a query to count the number of employees in each Region.
SELECT Region,COUNT(EmployeeID) as Regin_Count from employees
GROUP BY Region;

-- 16. Write a query to find the average Salary for each DepartmentID.
SELECT d.DepartmentName, round(AVG(e.salary),2) as Avg_salary from employees as e
LEFT JOIN departments as d
on d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- 17. Write a query to calculate the total SaleAmount for each EmployeeID from the SalesLog table.
SELECT employeeId , round(sum(Saleamount),2) as Total_sale, COUNT(*) as saleCount from saleslog
GROUP BY EmployeeID;

-- 18. Write a query to find the DepartmentIDs that have an average Salary greater than 90,000.
SELECT DepartmentID, round(avg(salary),2) as avg_salary FROM employees
GROUP BY DepartmentID HAVING avg(Salary) > 90000 ;

-- 19. Write a query to find the EmployeeIDs from SalesLog who have a total SaleAmount over 5,000.
SELECT EmployeeID , round(sum(Saleamount),2) as Total_sale FROM saleslog
GROUP BY EmployeeID HAVING sum(Saleamount) > 5000;

-- 20. Write a query to list the regions that have more than 10 employees.
SELECT Region, COUNT(EmployeeID) from employees
GROUP BY Region HAVING COUNT(EmployeeID) > 10;

-- 💡 Day 5-10: Conditional Logic & Joins

-- 21. (CASE) Write a query to list the FirstName, Salary, and a new column SalaryBracket that shows 'High' if Salary > 100,000, 'Medium' if Salary > 60,000, and 'Low' otherwise.
SELECT FirstName,salary,
CASE
	WHEN salary > 100000 THEN 'High'
    WHEN salary > 60000 THEN 'Medium'
    ELSE 'Low'
END as SalaryBracket
FROM employees;

-- 22. (CASE) Write a query to count the number of employees in each SalaryBracket (using the logic from Q21).
-- 23. (CASE with Aggregates) Write a query to find the total sales amount from SalesLog, but in separate columns: Q1_Sales (Jan-Mar) and Other_Sales (all other months).
-- 24. (INNER JOIN) Write a query to list the FirstName of all employees and their corresponding DepartmentName.
-- 25. (INNER JOIN) Write a query to list the FirstName of employees and the SaleAmount for every sale they made.
-- 26. (LEFT JOIN) Write a query to list all employees and their DepartmentName. If an employee has no department, they should still be listed.
-- 27. (LEFT JOIN) Write a query to list all employees' FirstName and their total SaleAmount (from SalesLog). If an employee has made no sales, their total sales should show as 0 or NULL.
-- 28. (LEFT JOIN + IS NULL) Write a query to find the names of all employees who have not made a single sale.
-- 29. (RIGHT JOIN + IS NULL) Write a query to find the names of any departments that have zero employees.
-- 30. (UNION) Write a query that creates a single list of all DepartmentIDs from the Employees table and the Departments table, showing only unique values.
