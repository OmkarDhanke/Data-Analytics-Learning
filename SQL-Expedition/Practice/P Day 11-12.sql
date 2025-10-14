-- Step 1: Create table
CREATE TABLE EmployeeDetails (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Location VARCHAR(50),
    Salary INT,
    ManagerID INT
);

-- Step 2: Insert sample data
INSERT INTO EmployeeDetails (EmployeeID, FullName, Department, Location, Salary, ManagerID) VALUES
(1, 'Vikram Batra', 'Technology', 'Bengaluru', 2500000, NULL),
(2, 'Priya Singh', 'Sales', 'Mumbai', 2200000, NULL),
(3, 'Anjali Mehta', 'HR', 'Delhi', 2000000, NULL),
(4, 'Rohan Joshi', 'Technology', 'Bengaluru', 1800000, 1),
(5, 'Sneha Reddy', 'Technology', 'Bengaluru', 1600000, 1),
(6, 'Arjun Kapoor', 'Technology', 'Delhi', 1500000, 1),
(7, 'Diya Sharma', 'Sales', 'Mumbai', 1200000, 2),
(8, 'Kabir Khan', 'Sales', 'Mumbai', 1400000, 2),
(9, 'Meera Desai', 'Sales', 'Bengaluru', 1300000, 2),
(10, 'Ishaan Verma', 'HR', 'Delhi', 900000, 3),
(11, 'Zara Ali', 'HR', 'Delhi', 950000, 3),
(12, 'Advik Kumar', 'Technology', 'Bengaluru', 2000000, 1),
(13, 'Sania Mirza', 'Sales', 'Mumbai', 1250000, 2),
(14, 'Veer Patel', 'HR', 'Delhi', 1000000, 3),
(15, 'Riya Chopra', 'Technology', 'Delhi', 1700000, 1);

SELECT * FROM employeedetails;
-- Learning 


-- Step 3: Practice Questions

-- Beginner (Q1–Q8) - Basic Subqueries & Simple CTEs
-- Q1: Find the full names of all employees who have the same salary as 'Rohan Joshi'.
SELECT Fullname FROM employeedetails
WHERE Salary = (SELECT Salary FROM employeedetails WHERE FullName = 'Rohan Joshi');

-- Q2: Find all employees who earn a salary greater than the company-wide average salary.
select upper("show databases");
-- Q3: Find the full names of all employees who are managers.
-- Q4: Find the full names of all employees who are not managers.
-- Q5: Write a query that lists each employee's FullName, their Salary, and the company's maximum salary.
-- Q6: Create a CTE named Sales_Dept that contains all employees from the 'Sales' department.
-- Q7: Rewrite Q2 using a CTE to first calculate the average salary.
-- Q8: Find the employee(s) with the lowest salary in the 'HR' department.

-- Intermediate (Q9–Q17) - Correlated Subqueries & Multi-Step CTEs
-- Q9: Find all employees who earn more than the average salary of their own department.
-- Q10: Rewrite Q9 using a CTE that calculates the average salary for each department.
-- Q11: Using a subquery in the FROM clause, find the average salary of employees in 'Bengaluru'.
-- Q12: For each employee, display their FullName, Salary, and the average salary of their department.
-- Q13: Rewrite Q12 using a CTE.
-- Q14: Find all departments that have at least one employee earning exactly 2,000,000 INR.
-- Q15: Use a CTE to create a list of managers and join it to list each manager and their employees.
-- Q16: Create two CTEs (Mumbai employees, Delhi employees). Return all employees from both.
-- Q17: Find the names of all employees who have the highest salary in their department.

-- Advanced (Q18–Q25) - Complex Logic & CTE Applications
-- Q18: Use a CTE and RANK() to find the employee with the second-highest salary in Technology.
-- Q19: Create two CTEs (DeptAverages and HighEarners). Count high earners by location.
-- Q20: Find employees who earn less than their direct manager, showing both salaries.
-- Q21: Use a CTE to find average salary per department, then calculate the average of these averages.
-- Q22: Use a CTE to find all employees who are not managers. From them, select those earning >1,500,000.
-- Q23: Using a CTE and window function, find the median salary for the company.
-- Q24: Write a recursive CTE to display the hierarchy starting from 'Vikram Batra'.
-- Q25: Use CTEs to find employees who earn less than their department's average salary but more than HR's average.
