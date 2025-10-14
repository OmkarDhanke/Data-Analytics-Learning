
-- Q1. Create a view that shows only the active employees (is_active = TRUE) with their id, name, department, and salary.
CREATE OR REPLACE VIEW emp_is_active AS
SELECT id, name, department, salary
FROM emp
WHERE is_active = 1;

SELECT * FROM emp_is_active;

-- Q2. Create a view to list employees along with their manager’s name (using manager_id).
CREATE OR REPLACE VIEW emp_e AS
SELECT e.name AS employee_name,
       m.manager_name AS manager_name
FROM emp AS e
LEFT JOIN managers AS m
       ON e.manager_id = m.manager_id;

SELECT * FROM emp_e;


-- Q3. Create a view that displays the employee name, department, and salary for employees earning more than 50,000.
CREATE OR REPLACE VIEW emp_1 AS
SELECT name, department, salary
FROM emp
WHERE salary > 50000;

SELECT * FROM emp_1;

-- Q4. Create a view to show department-wise average salary.
CREATE OR REPLACE VIEW emp_2 AS
SELECT department,
       round(AVG(salary), 2) AS avg_salary
FROM emp
GROUP BY department;

SELECT * FROM emp_2;

-- If Exists
SELECT department_name from company_db.departments as d
WHERE EXISTS (SELECT 1 FROM employees as e WHERE e.department_id = d.department_id);

 use omkar_db;
-- 1. List employees who have a manager present in the managers table.
select * from emp as e where exists (SELECT manager_name FROM managers m);

-- 2. Show employees whose department exists in the managers table.
SELECT name, department from emp as e WHERE EXISTS ( SELECT department FROM managers as m WHERE e.department = m.department);

-- 3. Find managers who manage at least one employee.
SELECT manager_name from managers as m  WHERE  EXISTS (SELECT 1 FROM emp as e WHERE m.manager_id = e.manager_id);
select * from emp as e where exists (SELECT manager_name FROM managers m);

-- 4. Get employees who do not have any manager.
SELECT name from emp as e WHERE NOT EXISTS (SELECT 1 FROM managers as m where  m.manager_id = e.manager_id);

-- 5. Show departments that have both employees and managers.
SELECT distinct department  from emp as e1  WHERE EXISTS (SELECT 1 FROM managers as e2 WHERE e1.department = e2.department);
 
 
 -- PROCEDURE
delimiter $$
CREATE PROCEDURE full_table()
BEGIN 
	SELECT * from orders;
END $$
delimiter //

call full_table();

delimiter //
CREATE PROCEDURE full_table2()
BEGIN
    INSERT INTO emp(id)
    VALUES (47);
    SELECT * FROM emp;
END //
delimiter //

CALL full_table2();

DROP PROCEDURE IF EXISTS full_table2;

delimiter //
CREATE PROCEDURE full_table(IN e_id int)
BEGIN 
	SELECT * FROM emp
    WHERE id = e_id;
END //
delimiter //

CALL full_table(4);


