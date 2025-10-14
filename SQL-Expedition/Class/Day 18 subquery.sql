-- Advance SQL subquery
SELECT name, salary from emp
WHERE salary > (SELECT avg(salary) from emp);

-- 1. Show employees who work in the same department as the manager with the highest salary.
select name , department, salary from employees
where department =
(select department from managers
where salary = (select max(salary) from managers));

-- 2. List employees whose salary is equal to the minimum salary in their department.
SELECT name, department from emp 
WHERE salary IN  (SELECT MIN(salary) FROM emp
GROUP BY department);

-- 3. Get the employees whose manager's department matches the department of Meera Kapoor.
SELECT name FROM emp
WHERE department IN (SELECT department FROM managers WHERE manager_name = 'Meera Kapoor');


