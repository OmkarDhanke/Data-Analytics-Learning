-- Filtering -> Where clause
select * from emp 
where department = "marketing";

-- Aliasing -> Tempary name this use to give a tempary name to the column 
select name as marketing_employees from emp 
where department = "marketing";

-- to retrivve the data from a table present in the data base
select * from omkar_db.emp;

-- to tampary change the name of the table 
select * from emp as e;

-- List the names and departments of all female employees.
select name , department from emp
where gender = "female";

-- Show the names and salaries of employees who earn more than 80,000.
select name , salary from emp 
where salary > 80000.00;

-- Find all inactive employees and display their email and department.
select email from emp 
where is_active = 0;

-- Display the names of employees who joined after the year 2015, along with their hire year.
select name, hire_date from emp
where hire_date < '2015-12-31';
select name, hire_date from emp
where year(hire_date) > 2015;

-- List employees who work in the Sales or HR departments, along with their names and contact numbers.
select name , contact, Department from emp 
where department = 'HR' or department = 'sales';

-- Show the names and ages of employees who are older than 35.
select name , age from emp
where age > 35;

-- Find employees whose salaries are between 70,000 and 90,000, and show their names and departments.
select name as emp_name , department as emp_department from emp 
where salary between 70000.00 and 90000.00;

-- List the names and manager IDs of employees who have a manager assigned.
select name as emp_name from emp 
where manager_id is not null;

-- Show the names, genders, and salaries of male employees who earn more than 90,000.
select name as emp_name , gender as emp_gender , salary as emp_salary from emp
where gender = "male" and salary > 90000.00;



