USE practice;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Smith', 'Sales', 60000, '2020-01-15'),
(2, 'Jane', 'Doe', 'Marketing', 75000, '2019-03-22'),
(3, 'Peter', 'Jones', 'Engineering', 95000, '2018-07-11'),
(4, 'Mary', 'Williams', 'Sales', 62000, '2021-02-10'),
(5, 'David', 'Brown', 'Engineering', 110000, '2017-05-29'),
(6, 'Sarah', 'Davis', 'HR', 55000, '2022-08-01'),
(7, 'Michael', 'Miller', 'Marketing', 80000, '2019-11-19'),
(8, 'Emily', 'Wilson', 'Engineering', 105000, '2020-09-03'),
(9, 'Chris', 'Moore', 'Sales', 58000, '2023-01-20'),
(10, 'Jessica', 'Taylor', 'HR', 52000, '2022-10-14'),
(11, 'Matthew', 'Anderson', 'Engineering', NULL, '2021-06-08'),
(12, 'Ashley', 'Thomas', 'Marketing', 78000, '2020-04-30'),
(13, 'Daniel', 'Jackson', 'Sales', 65000, '2019-08-17'),
(14, 'Amanda', 'White', 'Engineering', 120000, '2018-12-25'),
(15, 'James', 'Harris', 'HR', NULL, '2023-03-12');



-- Select , Where , ORDER BY 
-- SELECT 
SELECT * from employees;

SELECT employeeID, FirstName, LastName from employees;

-- WHERE
SELECT FirstName , lastname , salary from employees
WHERE salary > 100000.00;

SELECT * from employees
WHERE department = 'HR';

-- ORDER BY 
SELECT Firstname , lastname , salary , HireDate from employees 
ORDER BY hiredate;

SELECT * from employees
ORDER BY salary DESC;

-- IN and NOT IN Opraters
SELECT FirstName, LastName,department from employees
where department IN ('Sales','HR');

SELECT FirstName , LastName , Department from employees
WHERE department NOT IN ('Marketing', 'Sales');

-- BETWEEN 
SELECT series_title,my_score from data_db.animelist
WHERE my_score BETWEEN 8 AND 10 ORDER BY my_score;

-- Like Oprator with Wildcards
SELECT * from employees
where Firstname like 'P%';

SELECT * from employees
where FirstName like 'j_%';

-- Null And NOT Null
SELECT * from employees
WHERE salary IS NULL;

################################### Practice Problem ##############################################

-- Beginner (Q1–Q8)
-- Q1: Write a query to retrieve all columns for every employee in the Employees table.
SELECT * FROM employees;

-- Q2: Write a query to select the FirstName, LastName, and Salary of all employees.
SELECT FirstName, LastName, Salary FROM employees;

-- Q3: Write a query to find all employees who work in the 'Sales' department.
SELECT FirstName, LastName, department from employees
where department = 'Sales';

-- Q4: Write a query to list all employees with a salary greater than $80,000.
SELECT FirstName, LastName,salary from employees
where salary > 80000.00;

-- Q5: Write a query to retrieve the FirstName, LastName, and HireDate of all employees, sorted by HireDate in ascending order.
SELECT FirstName, LastName, HireDate from employees
ORDER BY Hiredate;

-- Q6: Write a query to get the details of all employees, sorted by Salary in descending order.
SELECT FirstName, LastName, salary from employees
ORDER BY salary DESC;

-- Q7: Write a query to find all employees whose Salary is not recorded (i.e., is NULL).
SELECT FirstName, LastName, salary from employees
WHERE salary is null;

-- Q8: Write a query to select all employees who have a Salary listed (i.e., is NOT NULL).
SELECT FirstName, LastName, salary from employees
where salary is not null;

-- Intermediate (Q9–Q17)
-- Q9: Write a query to find all employees who work in the 'Engineering' department and have a salary greater than $100,000.
SELECT FirstName, LastName,Department, salary from employees
WHERE Department = 'Engineering' AND salary > 100000.00;

-- Q10: Write a query to list all employees who are in the 'Sales' or 'Marketing' department. Use the IN operator.
SELECT FirstName, LastName, Department from employees
WHERE Department IN ('Sales','Marketing');

-- Q11: Write a query to find all employees who are not in the 'HR' or 'Sales' departments. Use the NOT IN operator.
SELECT FirstName, LastName, Department from employees
WHERE department NOT IN ('Sales','Marketing');

-- Q12: Write a query to retrieve all employees who were hired between January 1, 2020, and December 31, 2021. Use the BETWEEN operator.
SELECT FirstName, LastName, Hiredate from employees
where Hiredate BETWEEN '2020-01-01' and '2021-12-31';

-- Q13: Write a query to find all employees whose FirstName starts with the letter 'J'.
SELECT FirstName , LastName from employees
WHERE FirstName LIKE 'j%';

-- Q14: Write a query to find all employees whose LastName ends with 's'.
SELECT FirstName from employees
where FIrstName LIKE '%s';

-- Q15: Write a query to select all employees whose Department contains the word 'neer'.
SELECT FirstName, Department from employees
where Department like '%neer%';

-- Q16: Write a query to find all employees in the 'Marketing' department and order the results by Salary from highest to lowest.
SELECT FirstName, Salary,Department from employees
WHERE Department = 'Marketing' ORDER BY salary DESC;

-- Q17: Write a query to select employees who have a salary between $50,000 and $70,000, and are in the 'Sales' or 'HR' department.
SELECT FirstName, Salary,Department from employees
WHERE salary BETWEEN 50000.00 and 70000.00 and department in ('Sales','HR');

-- Advanced (Q18–Q25)
-- Q18: Write a query to find all employees whose FirstName is four letters long and ends with 's'.
SELECT FirstName, Salary,Department from employees
WHERE FirstName like '___s';

-- Q19: Write a query to select all employees hired in 2019, and who are not in the 'Engineering' department.
SELECT FirstName, Hiredate,Department from employees
where hiredate BETWEEN '2019-01-01' and '2019-12-31' and Department != 'Engineering';

-- Q20: Write a query to find all employees whose LastName has 'a' as the second letter.
SELECT FirstName , LastName from employees
WHERE LastName Like '_a%';

-- Q21: Write a query to retrieve employees who do not have a recorded salary and were hired after 2022.
SELECT FirstName ,Salary , Hiredate from employees
where salary is null and hiredate > '2022-12-31'; 

-- Q22: Write a query to find all employees whose FirstName starts with 'M' and LastName does not end with 's', sorted by department alphabetically.
SELECT FirstName , LastName,department from employees
WHERE FirstName LIKE 'M%' and LastName NOT Like '%s'
ORDER BY department ASC;

-- Q23: Write a query to list employees in the 'Engineering' department with a salary over $100,000 OR employees in the 'Marketing' department with a salary over $75,000.
SELECT FirstName , Salary,department from practice.employees
WHERE department = 'Engineering' and salary > 100000.00 
or department = 'Marketing' and salary > 75000.00;

-- Q24: Write a query to find all employees hired on or after January 1, 2020, whose department is not 'HR' and whose salary is not null.
SELECT FirstName , Hiredate, department from employees
where hiredate > '2020-01-01' and department != 'HR' and salary is not null;

-- Q25: Write a query to select all employees whose FirstName starts with a vowel (A, E, I, O, U) and whose salary is between $50,000 and $100,000, ordered by last name.
SELECT * from employees
where (FirstName LIKE 'A%'Or FirstName LIKE 'E%' OR FirstName LIKE 'I%' OR FirstName LIKE 'O%' OR FirstName LIKE 'U%')
AND salary BETWEEN 50000.00 and 100000.00 
ORDER BY LastName;