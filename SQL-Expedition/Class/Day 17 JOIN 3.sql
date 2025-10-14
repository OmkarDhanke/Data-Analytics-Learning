-- Show employee name, manager name, and department even if manager info is missing.
SELECT e.name , m.manager_name as M_Name , e.department , m.department from emp as e
LEFT JOIN managers as m
on e.manager_id = m.manager_id;

-- List all managers and the employees reporting to them.
SELECT e.name as E_Name , m.manager_name as M_name from emp as e
INNER JOIN managers as m
on m.manager_id = e.manager_id ;

-- Find managers who do not have any employees reporting to them.
SELECT m.manager_name as M_name, e.name from managers as m 
LEFT JOIN emp as e
on m.manager_id = e.manager_id 
WHERE e.manager_id not in  ( m.manager_id);

-- How many total combinations of employees and managers can be made?
SELECT m.manager_name as M_name , E.name as E_name from managers as m
CROSS JOIN emp as e
on m.manager_id = e.manager_id;


-- SELF JOIN Questions (Same table join)
-- Find pairs of employees who belong to the same department.
SELECT e.department ,e.name from emp as e
JOIN emp as e2
on e.department = e2.department
GROUP BY department;
 
 SELECT 
	 e.department,
    e.name AS employee1,
    e2.name AS employee2
FROM emp AS e
JOIN emp AS e2
    ON e.department = e2.department
    AND e.name > e2.name
    ORDER BY department ;  
 
-- List employee pairs where one is older than the other in the same department. 
-- Employee's name, their manager's name, and manager's email

SELECT e.name AS employee_name,
       m.manager_name,
       m.email AS manager_ema
FROM employees12 e
JOIN managers m
     ON e.manager_id = m.manager_id;

-- List all employees along with their manager's name

SELECT e.name AS employee_name,
       m.manager_name
FROM employees12 e
JOIN managers m
     ON e.manager_id = m.manager_id;

-- Show employee name, department, and corresponding manager's email

SELECT e.name AS employee_name,
       e.department,
       m.email AS manager_email
FROM employees12 e
JOIN managers m
     ON e.manager_id = m.manager_id;

-- List employees and their managers who belong to the same department

SELECT e.name AS employee_name,
       m.manager_name,
       e.department
FROM employees12 e
JOIN managers m
     ON e.manager_id = m.manager_id
WHERE e.department = m.department;

-- Get names of employees who have a manager assigned

SELECT name
FROM employees12
WHERE manager_id IS NOT NULL;


-- Employee names and manager names where employee salary > manager salary

SELECT e.name AS employee_name,
       e.salary AS employee_salary,
       m.manager_name,
       m.salary AS manager_salary
FROM employees12 e
JOIN managers m
     ON e.manager_id = m.manager_id
WHERE e.salary > m.salary;

-- All employees with their manager's name (include those without a manager)

SELECT e.name AS employee_name,
       m.manager_name
FROM employees12 e
LEFT JOIN managers m
     ON e.manager_id = m.manager_id;


SELECT *
FROM employees12
WHERE manager_id IS NULL;

-- Employee name, manager name, and department even if manager info is missing

SELECT e.name AS employee_name,
       m.manager_name,
       e.department
FROM employees12 e
LEFT JOIN managers m
     ON e.manager_id = m.manager_id;

-- All managers and the employees reporting to them

SELECT 
    m.manager_name, e.name AS employee_name
FROM
    managers m
        LEFT JOIN
    employees12 e ON m.manager_id = e.manager_id
ORDER BY m.manager_name;

-- Managers who do not have any employees reporting to them

SELECT m.manager_id,
       m.manager_name
FROM managers m
LEFT JOIN employees12 e
     ON m.manager_id = e.manager_id
WHERE e.manager_id IS NULL;


