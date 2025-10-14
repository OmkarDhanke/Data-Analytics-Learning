Create DATABASE Practice_Join;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    LeadEmployeeID INT NULL,
    FOREIGN KEY (LeadEmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE ArchivedEmployees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    LastDepartment VARCHAR(50)
);


INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
((101, 'Sales', 'New York'),
(102, 'Marketing', 'London'),
(103, 'Engineering', 'Bengaluru'),
(104, 'HR', 'New York'),
(105, 'IT Support', 'Bengaluru'));

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID) VALUES
((1, 'Aarav', 'Sharma', 101),
(2, 'Priya', 'Patel', 101),
(3, 'Rohan', 'Verma', 103),
(4, 'Saanvi', 'Gupta', 103),
(5, 'Vivaan', 'Singh', 102),
(6, 'Diya', 'Mehra', NULL),
(7, 'Advik', 'Jain', 104),
(8, 'Ananya', 'Roy', 103));

INSERT INTO Projects (ProjectID, ProjectName, LeadEmployeeID) VALUES
((5001, 'Q1 Marketing Campaign', 5),
(5002, 'Mobile App Relaunch', 3),
(5003, 'Data Warehouse Migration', 4),
(5004, 'East Coast Sales Drive', 1),
(5005, 'Internal Security Audit', NULL),
(5006, 'Talent Acquisition Portal', 7));

INSERT INTO ArchivedEmployees (EmployeeID, FirstName, LastName, LastDepartment) VALUES
((9, 'Ishaan', 'Kumar', 'Engineering'),
(10, 'Myra', 'Chopra', 'Sales'),
(1, 'Aarav', 'Sharma', 'Sales'));

-- INNER Join
SELECT e.FirstName , d.DepartmentName from practice_join.employees as e
INNER JOIN practice_join.departments as d
on e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName DESC;

SELECT e.EmployeeID,e.FirstName, e.LastName,p.ProjectName from practice_join.employees as e
INNER JOIN practice_join.projects as p
ON e.EmployeeID = p.LeadEmployeeID
WHERE e.EmployeeID >= 4;

-- LEFT Join
-- Q4: LEFT JOIN: List all employees' FirstName and LastName, along with their DepartmentName. Include employees without a department.
SELECT concat(e.firstname ,' ' ,e.lastname ) as FullName , d.departmentname 
from practice_join.employees as e
LEFT JOIN practice_join.departments as d
ON e.DepartmentID = d.DepartmentID;

-- RIGHT JOIN
-- Q5: RIGHT JOIN: List all departments and the full names of the employees in them. Include departments with no employees.
SELECT E.FirstName, E.LAstName ,D.Departmentname as Department from employees as E
RIGHT JOIN departments as D
on E.DepartmentID = D.DepartmentID;

-- Full Join 
SELECT * from employees as E
LEFT JOIN departments as D
on E.DepartmentID = D.DepartmentID
UNION
SELECT * from employees as E
RIGHT JOIN departments as D
on E.DepartmentID = D.DepartmentID;

-- UNION And UNION ALL
-- Q6: UNION ALL: Create a combined list of FirstName and LastName of current employees and archived employees.
SELECT FirstName , LastName from archivedemployees
UNION All
SELECT FirstName, LastName from employees;

######################################################## Practice Question ########################################################
-- Q1: INNER JOIN: List the FirstName of each employee and their corresponding DepartmentName.
select e.firstname , d.departmentname from employees as e
inner join departments as d
on e.DepartmentID = d.DepartmentID;

-- Q2: INNER JOIN: Show the ProjectName and the FirstName and LastName of the employee leading that project.
SELECT p.Projectname, e.FirstName , e.Lastname from employees as e 
INNER JOIN projects as p 
on e.EmployeeID = p.LeadEmployeeID;

-- Q3: INNER JOIN with WHERE: List the full names of all employees who work in the 'Engineering' department.
SELECT e.FirstName , e.Lastname from employees as e 
INNER JOIN departments as d
on e.DepartmentID = d.DepartmentID
WHERE DepartmentName = 'Engineering';

-- Q4: LEFT JOIN: List all employees' FirstName and LastName, along with their DepartmentName. Include employees without a department.
SELECT e.Firstname , e.lastname , d.departmentname from employees as e 
LEFT JOIN departments AS d
on e.DepartmentID = d.DepartmentID;

-- Q5: RIGHT JOIN: List all departments and the full names of the employees in them. Include departments with no employees.
SELECT e.Firstname , e.lastname , d.departmentname from employees as e 
RIGHT JOIN departments AS d
on e.DepartmentID = d.DepartmentID;

-- Q6: UNION ALL: Create a combined list of FirstName and LastName of current employees and archived employees.
SELECT Firstname , lastname from employees
UNION ALL
SELECT FirstName, LastName FROM archivedemployees;

-- Q7: UNION: Generate a single, unique list of all EmployeeIDs from both Employees and ArchivedEmployees.
SELECT employeeID FROM employees
UNION
SELECT EmployeeID FROM archivedemployees;

-- Q8: Three-Table JOIN: List the ProjectName for projects led by an employee from the 'Sales' department.
SELECT P.Projectname , e.Firstname , d.Departmentname as Dep_Name FROM projects as p
INNER JOIN employees as e on e.EmployeeID = p.LeadEmployeeID
INNER JOIN departments as d on e.DepartmentID = d.DepartmentID
WHERE DepartmentName = 'Sales';

-- Q9: LEFT JOIN with IS NULL: Find names of employees who are not assigned to any department.
SELECT e.FirstName , d.DepartmentName as Dep_name from employees as e
LEFT JOIN departments as d 
on e.DepartmentID = d.DepartmentID
WHERE DepartmentName is null;

-- Q10: RIGHT JOIN with IS NULL: Find names of departments that have no employees.
SELECT e.FirstName ,d.DepartmentName as Dep_name from employees as e
RIGHT JOIN departments as d 
on e.DepartmentID = d.DepartmentID
WHERE FirstName is null;

-- Q11: LEFT JOIN: List all projects and the first name of the employee leading them (include projects without leads).
SELECT p.Projectname, e.Firstname from projects as p
LEFT JOIN employees as e
on p.LeadEmployeeID = e.EmployeeID;

-- Q12: FULL OUTER JOIN: Show all employee full names and department names, matched up where possible (include unmatched).
SELECT e.Firstname, e.lastname , d.DepartmentName from employees as e
LEFT JOIN departments as d
on e.DepartmentID = d.DepartmentID
UNION 
SELECT e.Firstname, e.lastname , d.DepartmentName from employees as e
RIGHT JOIN departments as d
on e.DepartmentID = d.DepartmentID;

-- Q13: UNION with Aliasing: Create a list of all people (current and archived) with columns FirstName, LastName, Status.
SELECT Firstname , Lastname , 'Current' as Status FROM employees
UNION 
SELECT Firstname , Lastname , 'Archived' as Status FROM archivedemployees;

-- Q14: JOIN with COUNT: Show each DepartmentName and the total number of employees in it.
SELECT d.DepartmentName , COUNT(e.EmployeeID) as Emp_Count from departments as d
INNER JOIN employees as e
on d.DepartmentID = e.DepartmentID
GROUP BY DepartmentName
ORDER BY Emp_Count;

-- Q15: LEFT JOIN with COUNT: Include all departments, showing 0 for those without employees.
SELECT d.DepartmentName , COUNT(e.EmployeeID) as Emp_Count from departments as d
LEFT JOIN employees as e
on d.DepartmentID = e.DepartmentID
GROUP BY DepartmentName
ORDER BY Emp_Count;

-- Q16: JOIN with Multiple Conditions: List employees whose DepartmentID is 101 AND who lead ProjectID 5004.
SELECT e.EmployeeID, e.FirstName,e.LastName,e.DepartmentID,p.ProjectID from employees as e
INNER JOIN projects as p
on e.EmployeeID = p.LeadEmployeeID
WHERE DepartmentID = 101 and ProjectID = 5004;

-- Q17: Three-Table LEFT JOIN: List all employees’ full names, their department’s name, and the name of any project they lead.
SELECT e.Firstname , e.lastname , d.Departmentname, p.projectname FROM employees as e
LEFT JOIN departments as d on e.DepartmentID = d.DepartmentID
LEFT JOIN projects as p on e.EmployeeID = p.LeadEmployeeID;
 
-- Q18: Find Unassigned Projects: List ProjectName of projects without a lead.
SELECT p.projectname FROM projects as p
LEFT JOIN employees as e
on p.LeadEmployeeID = e.EmployeeID
WHERE EmployeeID is null;

-- Q19: Find Employees Not Leading Projects: List employees who are not leading any project.
SELECT e.Firstname , e.lastname  FROM employees as e
LEFT JOIN projects as p
on e.EmployeeID = p.LeadEmployeeID
WHERE LeadEmployeeID is NULL;

-- Q20: Comprehensive Report: Show DepartmentName, Location, Employee FirstName, and ProjectName they lead. Include all unmatched.
SELECT d.DepartmentName,d.Location,e.FirstName,p.ProjectName FROM departments as d
LEFT join employees as e on d.DepartmentID = e.DepartmentID
LEFT JOIN projects as p on p.LeadEmployeeID = e.EmployeeID;

-- Q21: JOIN with HAVING: List departments in 'Bengaluru' with more than 2 employees.
SELECT d.DepartmentName , d.Location ,COUNT(e.employeeID) as Emp_count from departments as d
LEFT JOIN employees as e
ON d.DepartmentID = e.DepartmentID
WHERE d.Location = 'Bengaluru'
GROUP BY DepartmentName
HAVING Emp_count > 2;

-- Q22: Combining JOIN and UNION: List names of all 'Engineering' employees (current and archived) with status.
SELECT e.FirstName, d.DepartmentName FROM employees as e
INNER JOIN departments as d
ON e.DepartmentID = d.DepartmentID
WHERE DepartmentName = 'Engineering'
UNION 
SELECT a.FirstName, a.LastDepartment  FROM archivedemployees as a
WHERE LastDepartment = 'Engineering';

-- Q23: Finding Orphan Records: FULL OUTER JOIN Employees and Projects to find employees without projects and projects without leads.
SELECT e.FirstName, p.projectname from employees as e
LEFT JOIN projects as p
on e.EmployeeID = p.LeadEmployeeID

UNION 

SELECT e.FirstName, p.projectname from employees as e
RIGHT JOIN projects as p
on e.EmployeeID = p.LeadEmployeeID;

-- Q24: UNION with Different Structures: Create a list with columns Name and Type (Department vs. Project).
SELECT departmentname as Name , 'Department' as Type from departments 
UNION 
SELECT projectname as Name , 'Project' as Type from projects;

-- Q25: Complex Filtering with JOIN: Find names of projects led by employees not in a 'New York' department.
SELECT e.FirstName, p.ProjectName, d.Location FROM employees as e
INNER JOIN projects as p on e.EmployeeID = p.LeadEmployeeID
INNER JOIN departments as d on e.DepartmentID = d.DepartmentID
WHERE d.Location != 'New York';

