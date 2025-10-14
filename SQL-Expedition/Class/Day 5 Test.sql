-- Test Date 18-07-2025

-- 1. Write a query to create a database named `CompanyData`.
create database CompanyData;
use CompanyData;

-- 2. Create a table `departments` with the following columns:

   -- `dept_id` INT PRIMARY KEY
   -- `dept_name` VARCHAR(100)
   -- `location` VARCHAR(100)

create table departments(
dept_id int primary key,
dep_name varchar(100),
location varchar(100)
);

-- 3. Create a table `employees` with the following columns:

    -- `emp_id` INT PRIMARY KEY
   -- `emp_name` VARCHAR(100)
   -- `age` INT
   -- `gender` VARCHAR(10)
   -- `salary` DECIMAL(10,2)
   -- `dept_id` INT
    
create table employees(
emp_id int primary key,
emp_name varchar(100),
age int,
gender varchar(10),
salary decimal(10,2),
dep_id int
);

show tables;

-- 3. Insert these rows into the `employees` table:
insert into employees(emp_id,emp_name,age,gender,salary,dep_id) 
values 
(101,'Anil',30,'male',60000.00,1),
(102,'Priya',28,'Female',72000.00,2),
(103, 'Rohit', 35, 'Male', 65000.00, 2),
(104, 'Neha', 26, 'Female', 58000.00, 3),
(105, 'Karan', 40, 'Male', 80000.00, 2),
(106, 'Sneha', 31, 'Female', 69000.00, 4),
(107, 'Ramesh', 45, 'Male', 85000.00, 5),
(108, 'Swati', 29, 'Female', 61000.00, 1),
(109, 'Manish', 33, 'Male', 78000.00, 3),
(110, 'Isha', 27, 'Female', 70000.00, 4);

-- 5. Add a new column `email` of type `VARCHAR(100)` to the `employees` table.
alter table employees ADD(email varchar(100));

-- 6. Modify the `salary` column to allow up to 12 digits, 2 after the decimal.
alter table employees modify salary decimal(12,2);

-- 7. Rename the column `emp_name` to `full_name`.
alter table employees rename column emp_name to full_name;

-- 8. Delete the `email` column from the `employees` table.
alter table employees drop email;

-- 9. Select all columns from the `employees` table.
select * from employees;

-- 10. Select only `full_name` and `salary` from all employees.
select full_name , salary from employees;

-- 11. Display the `emp_id`, `full_name`, and `dept_id` of all employees.
select emp_id, full_name, dep_id from employees;

-- 12. Show all employees where salary is more than 70000.
select * from employees 
where salary > 70000.00;

-- 13. Display all records where age is less than 30.
select * from employees
where age < 30;

-- 14. Show all distinct department IDs from the table.
select distinct dep_id from employees;

-- 15. Display all unique ages of the employees.
select distinct age from employees;

-- 16. Display all employees sorted by salary in ascending order.
select * from employees
order by salary asc;

-- 17. Show employees sorted by age in descending order.
select * from employees
order by age desc;

-- 18. List all employees sorted first by dept\_id and then by salary descending.
select * from employees 
order by dep_id asc, salary desc;



