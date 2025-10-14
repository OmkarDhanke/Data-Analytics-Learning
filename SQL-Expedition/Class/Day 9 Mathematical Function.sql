-- mathematical function
select abs(10);

-- ceil
select ceil(5.4);
select ceil(-5.4);

-- Floor
select floor(5.4);
select floor(-5.4);

-- round(x,[d])
select round(3.14159);
select round(440.1322512,-2); -- it will round the number if the nuber is greater than 5 
select round(3,-2);

--  mod(N,M) or N % M
select mod(10,3); select 10 % 3;
select mod(-10,-3);
select mod(-10,4);
select mod(25460,542);

-- power(x,y) or pow(x,y)
select power(2,3);
select pow(2,3);
select power(5,10);

-- sqrt(n)
select sqrt(45);
select sqrt(25);
select sqrt(-45);

-- truncate(x,y)
select truncate(123.456,2);
select truncate(123.456,-2);

-- rand(n)
select rand() * 100;
select id , rand() from emp;
SELECT FLOOR(7 + (RAND() * 6));

-- sing
select sign(-1);
select sign(1);
select sign(0);

-- Mathematical Functions

-- 1. Show the rounded salary of each employee.
select name, round(salary,-4) as Round_salary from emp;

-- 2. Display the floor value of salary for all employees
select name, floor(salary) as floor_salary from emp;

-- 3. Display the ceiling value of salary for all employees.
select name, ceil(salary) as ceil_salary from emp;

-- 4. Find the absolute difference between salary and 75000.
select name , abs(salary) from emp;

-- 5. Calculate the average salary of all employees.
select avg(salary) as Avg_salary from emp;

-- 6. Find the maximum and minimum salary.
select max(salary) as Max_salary,min(salary) as Min_salary from emp; 


-- 8. Show the modulo 1000 of each salary.
select name , mod(salary,1000) as Mod_salary from emp;

-- 9. Raise each salary to the power of 2.
select name, power(salary,2) as salary_pow_2 from emp;

-- 10. Show the square root of each salary.
select name , sqrt(salary) as sqrt_salary from emp;

-- 11. Round salary to nearest 1000 using rounding techniques.
select name , round(salary,1000) as Rounded_salary from emp;

-- 12. Show employee salary divided by 12 as monthly salary.
select name, salary / 12 as Monthly_salary from  emp;

-- 13. Show salary multiplied by 10% as bonus amount
select name ,salary, salary + salary / 10 from emp;

-- 14. Find total salary paid to all active employees.
select sum(salary) from emp 
where is_active = 1;

-- 15. Calculate salary difference between employee and manager

-- 16. Display salary increased by 10% for all marketing department employees
-- 17. Show salaries sorted based on rounded values
-- 18. Get salary raised to 3 decimal precision
-- 19. Show the log base 10 of each salary.
-- 20. Group by department and show sum and average salary.




