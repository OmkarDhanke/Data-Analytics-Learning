-- Write a query to display the employee's name, and their manager's name, email id.
SELECT e.name as E_name, m.manager_name as M_name  , m.email from emp as e
LEFT JOIN managers as m
ON e.manager_id = m.manager_id;

-- List all employees along with their manager's name.
SELECT e.name as E_name, m.manager_name as M_name   from emp as e
left JOIN managers as m
ON e.manager_id = m.manager_id;

-- Show employee name, department, and corresponding manager's email.
SELECT e.name , e.department,  m.email from emp as e
left JOIN managers as m 
on e.manager_id = m.manager_id;

-- List employees and their managers who belong to the same department.
SELECT  e.name , e.department, m.manager_name, e.department  from emp as e
INNER JOIN managers as m 
on e.manager_id = m.manager_id
where e.department = m.department;

-- Get the names of employees who have a manager assigned.
SELECT e.name, e.manager_id from emp as e
right JOIN managers as m
on e.manager_id = m.manager_id;

-- List employee names and manager names where employee salary is greater than manager salary.
SELECT e1.id, e1.name , e2.name as M_name, e2.salary FROM emp as e1
join emp as e2
on e1.id = e2.manager_id
where e1.salary > e2.salary;

-- List all employees with their manager's name, including those who don't have a manager.
SELECT e.name as E_name, m.manager_name as M_name from emp as e
LEFT JOIN managers as m
ON e.manager_id = m.manager_id;

-- Find employees who do not have a manager assigned.
SELECT e.name as E_name from emp as e
LEFT JOIN managers as m
ON e.manager_id = m.manager_id
where e.manager_id is null;
