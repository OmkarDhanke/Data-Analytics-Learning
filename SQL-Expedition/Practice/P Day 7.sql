-- =============================================================
-- DAY 7: SQL PRACTICE SET - Advanced Joins & NULLs
-- Domain: "Apex Corp" HR
-- Topics: Self-Joins, Anti-Joins, COALESCE, 3-Table Joins
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS ApexCorp_DB;
USE ApexCorp_DB;

-- Table 1: Employees (Contains a Self-Referencing Relationship)
-- Note: 'manager_id' points to 'emp_id' IN THE SAME TABLE.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50),
    salary INT,
    manager_id INT -- This is the Foreign Key to itself
);

-- Table 2: Projects
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50)
);

-- Table 3: Assignments (Many-to-Many link between Emp and Proj)
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    project_id INT,
    hours_logged INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE assignments;
TRUNCATE TABLE projects;
TRUNCATE TABLE employees;

-- Insert Employees (Hierarchy: Alice is CEO -> Bob/Charlie -> David)
INSERT INTO employees VALUES
(1, 'Alice', 'CEO', 150000, NULL),   -- Alice has no manager
(2, 'Bob', 'Director', 120000, 1),   -- Bob reports to Alice
(3, 'Charlie', 'Manager', 90000, 1), -- Charlie reports to Alice
(4, 'David', 'Analyst', 60000, 3),   -- David reports to Charlie
(5, 'Eve', 'Intern', 30000, 3),      -- Eve reports to Charlie
(6, 'Frank', 'Bench', 40000, 2);     -- Frank reports to Bob (but has no project)

-- Insert Projects
INSERT INTO projects VALUES
(101, 'Website Redesign'),
(102, 'Data Migration'),
(103, 'Cloud Upload');

-- Insert Assignments
INSERT INTO assignments (emp_id, project_id, hours_logged) VALUES
(3, 101, 20), -- Charlie on Website
(4, 101, 40), -- David on Website
(4, 102, 10), -- David on Data Migration (Multi-project)
(5, 103, 15); -- Eve on Cloud
-- Note: Frank (ID 6) and Alice (ID 1) have NO assignments.


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: The Self-Join (Hierarchy)
-- We want a list showing the Employee's Name and their Manager's Name side-by-side.
-- Hint: Treat the 'employees' table as if it were two separate tables (e.g., table 'E' and table 'M'). Join them where the Manager ID matches the Employee ID.
SELECT	
	e1.name as Emp_name,
    e2.name as Manager_name
FROM
	employees e1
JOIN employees e2
on  e1.manager_id = e2.emp_id;

-- Question 2: Handling the CEO (Left Self-Join)
-- Your previous query likely excluded Alice because she has no manager (NULL).
-- Rewrite the query so Alice appears in the list. Her manager column should just be NULL (or empty).
-- Hint: One side of your join needs to be inclusive of unmatched rows.
SELECT	
	e1.name as Emp_name,
    e2.name as Manager_name
FROM
	employees e1
LEFT JOIN employees e2
on  e1.manager_id = e2.emp_id;

-- Question 3: Formatting NULLs (COALESCE)
-- Modify Q2. Instead of showing 'NULL' for Alice's manager, display the text 'Top Boss'.
-- Hint: Wrap the manager's name column in a function that provides a fallback value if the main value is missing.
SELECT 
	e1.Name as Emp_name,
    coalesce(e2.Name,'Top Boss') as Manager_name
FROM
	employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.emp_id;

-- Question 4: The "Bench" Employees (Anti-Join)
-- Find the names of employees who are currently NOT assigned to any project.
-- Hint: Join Employees to Assignments using a specific type of Join that keeps all employees, then look for the "ghosts" (rows where the assignment side is missing).
SELECT
	E.emp_id,
    E.name,
    A.project_id
FROM employees E
LEFT JOIN assignments A
ON E.emp_id = A.emp_id
WHERE
	project_id IS NULL;

-- Question 5: Multi-Table Chain
-- List the Employee Name, Project Name, and Hours Logged.
-- Note: You will need to join three tables to get from Name (Emp) to Project Name (Proj).
-- Hint: Employees -> Assignments -> Projects.
SELECT
	E.name,
    P.project_name,
    A.hours_logged
FROM employees E
LEFT JOIN assignments A
ON E.emp_id = A.emp_id
LEFT JOIN projects P 
ON A.project_id = P.project_id;

-- Question 6: Manager's Total Team Size
-- Count how many people report directly to each manager.
-- Show Manager's Name and 'Direct_Report_Count'.
-- Hint: You are grouping by the "Manager" side of the self-join.
SELECT 
	E1.manager_id AS Manager_ID,
    COUNT(*) 'Direct_Report_Count'
FROM employees E1
JOIN employees E2
ON E1.manager_id = E2.emp_id
GROUP BY E1.manager_id;

-- Question 7: Aggregation with Nulls
-- Calculate the Total Hours logged for EACH project name.
-- Hint: Simple Join + Group By.
SELECT
	E.name AS Emp_Name,
    SUM(A.hours_logged) AS 'Total Hours logged'
FROM employees E
JOIN assignments A
ON E.emp_id = A.emp_id
GROUP BY Emp_Name;

-- Question 8: The "Busy" Analysts (Filter on Aggregate)
-- Find the names of employees who have logged more than 45 hours in TOTAL across all their projects.
-- Hint: Join, Group by Employee, Sum the hours, and then filter the *result* of that sum.
SELECT
	E.name AS Emp_Name,
    SUM(A.hours_logged) AS 'Total Hours logged'
FROM employees E
JOIN assignments A
ON E.emp_id = A.emp_id
GROUP BY Emp_Name
HAVING SUM(A.hours_logged) > 45;
    
-- Question 9: Finding Managers (Subquery vs Join)
-- Find the names of all employees who are actually managers (meaning, someone reports to them).
-- Try using a Subquery for this.
-- Hint: Select names where the ID exists in the 'manager_id' column of the table.
SELECT
	E.emp_id,
    E.name
FROM employees E
WHERE EXISTS (SELECT 1 FROM employees E2 WHERE E2.manager_id = E.emp_id);

-- Question 10: Salary Comparison (Tricky)
-- Find employees who earn MORE than their direct manager.
-- (Note: In this specific dataset, nobody does, so the result should be empty. But write the logic to check!).
-- Hint: In your self-join, compare the Salary column of Table E vs Salary column of Table M.
SELECT
	E.Name,
    E.salary
FROM employees E 
JOIN employees M
ON E.manager_id = M.emp_id
WHERE E.salary > M.salary;