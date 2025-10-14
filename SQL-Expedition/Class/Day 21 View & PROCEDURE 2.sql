-- View's 
-- Create a view that shows each employee’s name, department, and their manager’s name.
CREATE VIEW empdata as 
SELECT e.name,e.department, m.manager_name from emp as e
LEFT JOIN managers as m
on e.manager_id = m.manager_id;

SELECT * from empdata;

-- Create a view that lists only active employees along with their salary and manager’s email.
CREATE VIEW active_emp as
SELECT e.name , e.salary, m.email from emp as e
LEFT JOIN managers as m
on e.manager_id = m.manager_id
WHERE e.is_active = 1;

SELECT * from active_emp;


-- Store PROCEDURE

-- Write a stored procedure that takes a department name as input and returns all employees along with their manager’s name for that department.
delimiter //
CREATE PROCEDURE emp_data(IN dep char(50))
BEGIN
    select e.name ,e.department, m.manager_name from emp as e
    left join managers as m
    on e.manager_id = m.manager_id
    where e.department = dep;
END //
delimiter //

call emp_data('Engineering');

DROP PROCEDURE IF EXISTS emp_data;

-- Write a stored procedure that takes a manager’s ID as input and returns the total number of employees reporting to that manager.
delimiter //
CREATE PROCEDURE emp_data1(in m_id INT)
BEGIN 
    SELECT COUNT(*) AS total_employees
    FROM emp
    WHERE manager_id = m_id;
END //
delimiter //

call emp_data1(2);


