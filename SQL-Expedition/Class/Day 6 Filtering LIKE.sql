show databases;
use omkar_db;
use companydata;
show tables;
select * from employees;
select * from emp;

-- NOTE : Always apliy filterring first
-- Comparison Operators "LIKE"
-- Find employees whose name contains ‘a’, sort by salary descending.
select * from emp 
where name like '%A%' order by salary desc;

-- Show employees whose names end with e
select * FROM emp
where name like '%E';

-- Show employees whose second letter is i
select * from emp 
where name like '_i%';

-- Show employees whose name contains an
select * from emp 
where name like '%_an_%';

-- Show employees whose name has exactly 3 letters
select * from emp 
where name like '___';

-- Limit it will show the first row 
select * from emp 
limit 3;

-- Show top 2 highest paid employees
select name as Highest_paid_emp, salary as emp_salary from emp
order by salary desc limit 2;

-- offset is us to skip the entry's
select name as Highest_paid_emp, salary as emp_salary from emp
order by salary desc limit 2;

-- Skip first 2 records and show next 5
select * from emp limit 5 offset 2;

-- Show last 3 employees by ID in descending order
select * from emp
order by id desc limit 3;

-- CONCAT
select concat(name,'-',age) from emp;

-- lenth
select length(name) as name_str from emp;

-- substring()
select substring(email,5,7) from emp;

-- left/right home work
select left(name,'4') from emp;
select right(name,'4') from emp;

-- lover home work
select left(name,'4') from emp;

-- upper
select upper(name) as Uppercase_name from emp;


