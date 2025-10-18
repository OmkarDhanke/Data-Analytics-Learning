/* Create the Departments table */
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

/* Create the Employees table */
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(10, 2),
    DeptID INT,
    ManagerID INT
);

/* Create the Projects table */
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

/* Create the EmployeeProjects junction table */
CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjectID INT,
    PRIMARY KEY (EmpID, ProjectID)
);

/* Populate Departments */
INSERT INTO Departments (DeptID, DeptName, Location)
VALUES
(1, 'Engineering', 'New York'),
(2, 'Sales', 'Chicago'),
(3, 'Marketing', 'New York'),
(4, 'Human Resources', 'Chicago'),
(5, 'Finance', 'Boston');

/* Populate Employees */
INSERT INTO Employees (EmpID, FirstName, LastName, Email, HireDate, Salary, DeptID, ManagerID)
VALUES
(101, 'Sarah', 'Chen', 'sarah.chen@company.com', '2022-05-15', 110000.00, 1, NULL),  -- Manager (CEO/CTO)
(102, 'David', 'Lee', 'david.lee@company.com', '2022-06-01', 85000.00, 1, 101),
(103, 'Alice', 'Johnson', 'alice.j@company.com', '2022-07-20', 90000.00, 1, 101),
(104, 'Michael', 'Smith', 'michael.s@company.com', '2023-01-10', 72000.00, 2, 106),
(105, 'Emily', 'Brown', 'emily.b@company.com', '2023-02-22', 68000.00, 3, 107),
(106, 'Chris', 'Wilson', 'chris.w@company.com', '2022-04-05', 105000.00, 2, 101),
(107, 'Jessica', 'Patel', 'jessica.p@company.com', '2022-08-30', 95000.00, 3, 101),
(108, 'Brian', 'Miller', 'brian.m@company.com', '2023-05-12', 62000.00, 4, NULL), -- Manager
(109, 'Laura', 'Davis', 'laura.d@company.com', '2023-11-01', 88000.00, 1, 102),
(110, 'Tom', 'Harris', 'tom.h@company.com', '2024-01-05', 71000.00, 2, 106);

/* Populate Projects */
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate)
VALUES
(1, 'Project Alpha', '2023-01-01', '2023-06-30'),
(2, 'Project Beta', '2023-03-15', '2023-12-31'),
(3, 'Project Gamma', '2023-07-01', '2024-06-30'),
(4, 'Project Delta', '2024-02-01', '2024-05-01'),
(5, 'Project Omega', '2024-04-01', NULL); -- Ongoing project

/* Populate EmployeeProjects */
INSERT INTO EmployeeProjects (EmpID, ProjectID)
VALUES
(102, 1),
(102, 2),
(103, 1),
(105, 3),
(106, 2),
(107, 3),
(109, 4),
(109, 5);

-- Section A: Filtering, Sorting, & Operators (Day 1-2)

-- 1. (SELECT, WHERE) Find all employees in the 'Engineering' department. [cite: 231, 239]
-- 2. (WHERE, LIKE) Find all employees whose last name starts with the letter 'S'. [cite: 291, 299]
-- 3. (WHERE, LIKE) Find all employees whose email address ends with '@company.com'.
-- 4. (ORDER BY) List all employees, sorted by their salary from highest to lowest. [cite: 247, 256]
-- 5. (ORDER BY) List all employees in the 'Sales' department, sorted alphabetically by last name. [cite: 247, 252]
-- 6. (WHERE, IN) Find all employees who work in the 'Sales' or 'Marketing' departments. [cite: 259, 265]
-- 7. (WHERE, BETWEEN) Find all employees hired in 2023 (i.e., between '2023-01-01' and '2023-12-31'). [cite: 275, 281]
-- 8. (WHERE, IS NULL) Find all employees who do not have a manager (their ManagerID is NULL). [cite: 308, 316]
-- 9. (WHERE, IS NOT NULL) Find all projects that have been completed (i.e., their EndDate is NOT NULL). [cite: 311]


-- Section B: Aggregations (Day 3-4)

-- 10. (COUNT) How many total employees are in the 'Employees' table? [cite: 3, 7]
-- 11. (SUM) What is the total combined salary of all employees in the 'Engineering' department? [cite: 14, 19]
-- 12. (AVG) What is the average salary for the 'Sales' department? [cite: 26, 30]
-- 13. (MIN, MAX) Find the earliest hire date (MIN) and the latest hire date (MAX) from the 'Employees' table. [cite: 37, 42, 44]
-- 14. (GROUP BY, COUNT) Count the number of employees in each department. [cite_start]Show the DeptID and the count. [cite: 51, 55]
-- 15. (GROUP BY, AVG) Calculate the average salary for each department. [cite_start]Show DeptID and the average. [cite: 51, 55]
-- 16. (HAVING) List the departments (DeptID) that have an average salary *greater than* $80,000. [cite: 68, 77]
-- 17. (WHERE, GROUP BY, HAVING, COUNT) List the departments (DeptID) that have *more than 2* employees AND are *not* in 'New York'. [cite: 65, 68]


-- Section C: Joins (Day 8-10)

-- 18. (INNER JOIN) List the first name, last name, and department name for all employees. [cite: 134, 145]
-- 19. (INNER JOIN) List the names of employees (FirstName, LastName) and the names of the projects (ProjectName) they are working on. [cite: 134, 145]
-- 20. (LEFT JOIN) List *all* employees (FirstName, LastName) and any projects they are on (ProjectName). [cite_start]Employees with no projects should still be listed, with a NULL for the ProjectName. [cite: 152, 161]
-- 21. (RIGHT JOIN) List *all* projects (ProjectName) and any employees working on them (FirstName, LastName). [cite_start]Projects with no employees should still be listed. [cite: 169, 179]
-- 22. (Self-Join using INNER JOIN) List each employee (FirstName, LastName) and their manager's first and last name. [cite_start]You will need to join the 'Employees' table to itself. [cite: 134]
-- 23. (UNION) Create a single list of all employee names (FirstName) and all department names (DeptName). [cite: 215, 220]


-- Section D: Conditional Logic (Day 5-6)
-- 24. (Searched CASE) Create a "Salary Tier" for each employee. [cite_start]Show their FirstName, LastName, Salary, and a new column 'SalaryTier' that is: [cite: 80, 83]
  /* 'High' if Salary > $100,000
   * 'Medium' if Salary is between $70,000 and $100,000
   * 'Low' if Salary < $70,000*/
   
-- 25. (Simple CASE) Show the DeptName and a new column 'Region'. [cite: 100, 105]
     /* WHEN Location is 'New York' THEN 'East Coast'
     * WHEN Location is 'Chicago' THEN 'Midwest'
     * WHEN Location is 'Boston' THEN 'East Coast'
     * ELSE 'Unknown'*/
     
-- 26. (CASE with Aggregates) Write a single query that counts the number of employees in 'New York' and the number of employees in 'Chicago'. [cite_start]The output should have two columns: 'NewYork_Count' and 'Chicago_Count'. [cite: 122, 130]

-- 27. (CASE with Aggregates) Calculate the total salary paid to employees hired in 2022 vs. 2023. Show two columns: 'TotalSalary_2022' and 'TotalSalary_2023'. [cite: 122, 126]


-- Section E: Comprehensive Review (Combining Concepts)
-- 28. (JOIN, GROUP BY, COUNT) Show the name of each department (DeptName) and the number of employees working in it. [cite: 145, 55]
-- 29. (JOIN, WHERE, GROUP BY, AVG) What is the average salary for employees in 'New York'? (You will need to join Employees and Departments)[cite_start]. [cite: 145, 65, 55]
-- 30. (JOIN, GROUP BY, COUNT) Show the name of each project (ProjectName) and the total number of employees assigned to it. [cite: 145, 55]
-- 31. (LEFT JOIN, WHERE...IS NULL) Find the names of all employees who are *not* assigned to any projects. [cite: 161, 316]
-- 32. (JOIN, GROUP BY, HAVING, COUNT) List the project names (ProjectName) that have *more than one* employee assigned to them. [cite: 145, 55, 68]
-- 33. (JOIN, CASE, GROUP BY, SUM) Calculate the total salary payroll for the 'East Coast' and 'Midwest' regions (using the logic from Q.25). [cite_start]Show the 'Region' and the 'TotalSalary' for each. [cite: 145, 105, 55, 126]