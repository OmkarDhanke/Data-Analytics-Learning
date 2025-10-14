-- 1. Find the employees whose salary is greater than the salary of Sita Nair.
SELECT name , salary from emp 
where salary > (SELECT salary from emp
where name like 'Sita nair');

-- 2. Show the employees who were hired before Simran Kaur.
SELECT name , hire_date from emp 
where hire_date < (SELECT hire_date from emp WHERE name LIKE 'Simran Kaur');

-- 3. Find the employees who have the same salary as Vikram Reddy.
SELECT name , salary from emp 
where salary = (SELECT salary from emp
where name like 'Vikram Reddy');

-- 4. Get the employee(s) who have the lowest salary.
SELECT name , salary from emp 
where salary < (SELECT avg(salary) from emp);

-- 5. List employees whose manager,s salary is greater than the salary of Meera Kapoor.
SELECT name from emp 
where manager_id in (SELECT manager_id from managers
where salary > (SELECT salary from managers where manager_name like 'Meera Kapoor'));

-- IN Operator:
-- 1. Get employees working in departments that have managers.
SELECT name from emp
WHERE manager_id in
(SELECT manager_id from managers);

-- 2. Find employees whose manager ID exists in the managers table.
SELECT name FROM emp
WHERE manager_id IN (SELECT manager_id FROM managers);

-- 3. Show employees in the same departments as Amit Sharma and Neha Desai.
SELECT name from emp 
WHERE department in (SELECT department from emp
where name in ('Neha Desai','Amit Sharma'));


-- 4. List employees hired in the same years as any manager.
SELECT name from emp
where year(hire_date) in (SELECT year(hire_date) from managers);

-- 5. Display employees whose email domain is the same as that of any manager.
SELECT name FROM emp
WHERE SUBSTRING_INDEX(email, '@', -1) in
(SELECT SUBSTRING_INDEX(email, '@', -1) FROM managers);

