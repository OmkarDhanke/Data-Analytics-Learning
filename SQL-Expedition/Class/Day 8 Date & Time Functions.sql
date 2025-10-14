### 2. Date and Time Functions
show databases;
use omkar_db;

-- 1. Display the year of hire for all employees.
select year(hire_date) as emp_year from emp;

-- 2. Show the month name of the hire\_date.
select monthname(hire_date) as hire_month from emp;

-- 3. Get employees hired before 2015.
select * from emp
where year(hire_date) < 2015;

-- 4. Calculate the number of years each employee has worked.
select name , timestampdiff(year, hire_date , curdate()) as years_of_emp from emp;

-- 5. Display the day of the week for each hire date.
select name, dayname(hire_date) as day_of_week from emp;

-- 6. Get the current date and show it with each employee.
select name , curdate() as date from emp;

-- 7. Show employees who were hired in the month of August.
select name as emp_August from emp
where month(hire_date) = 8;

-- 8. Get employees hired in the last 10 years
select * from emp
where hire_date >= date_sub(curdate(), interval 10 year);

-- 9. Add 1 year to each hire date.
select name , hire_date ,adddate(hire_date, interval 1 year) as new_hire_date from emp;

-- 10. Find the employee(s) with the earliest hire date
select name , hire_date  from emp
order by hire_date asc;

-- 11. Show employees with hire\_date in the first 15 days of the month.
select name , hire_date from emp
where day(hire_date) <= 15;

-- 12. Show difference in days between today and hire\_date.
select name , hire_date , datediff(curdate(), hire_date) as day_diff from emp;

-- 13. Extract only the date part of the hire\_date (remove time if added).
select name , date(hire_date) from emp;

-- 14. Format hire\_date as `'DD-MM-YYYY'`.
select date_format(hire_date, '%D-%m-%Y') as date_formated from emp;

-- 15. Count how many employees were hired each year

-- 16. Find the number of employees hired in the first quarter (Jan–Mar)
select name , hire_date from emp
where quarter(hire_date) <= 1;

-- 17. Get employees hired on a weekend
select name as emp_hire_on_weekend , hire_date, dayname(hire_date) as day_name from emp
where weekday(hire_date) = 5 or weekday(hire_date) = 6;

-- 18. Show all employees and their next work anniversary date

-- 19. Get employees who completed exactly 10 years this year.
select name, hire_date from emp
where year(curdate()) - year(hire_date) = 10 ;

-- 20. Show how many months each employee has completed in the company.
select name , hire_date , timestampdiff(month, hire_date, curdate()) as months_completed from emp;


-- revisition 
select now();
select curdate();
select curtime();
select date_format(now(),'%D-%M-%y');


-- day 
select day(curdate()) as Todays_date;
select time(now());

-- dateadd / we can change the date , year , month by changing the day to year to month
select date_add('2025-07-28', interval 5 day) as date_added;
select date_add('2025-07-28', interval 5 month) as month_added;
select date_add('2025-07-28', interval 5 year) as year_added;
select date_add('2025-06-28 10:00:00' , interval 30 minute) as add_minute;
select date_add( now() , interval 30 minute) as add_minutes;
select date_format( date_sub(now() , interval 30 minute) as sub_minutes , '%D-%M-%y' );

-- timestampdiff
select timestampdiff(month, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(day, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(year, '2025-02-22', '2026-05-22') as timestampdiff;
select timestampdiff(week, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(quarter, '2025-02-22', '2026-05-22') as timestampdiff;

-- date sub
select date_sub('2025-06-28' , interval 5 day) as sub_date;
select date_sub('2025-06-28' , interval 5 month) as sub_month;
select date_sub('2025-06-28' , interval 5 year) as sub_year;
select date_sub('2025-06-28 10:00:00' , interval 30 minute) as sub_minutes;
select date_sub( now() , interval 30 minute) as sub_minutes;


-- date diff### 2. Date and Time Functions
show databases;
use omkar_db;

-- 1. Display the year of hire for all employees.
select year(hire_date) as emp_year from emp;

-- 2. Show the month name of the hire\_date.
select monthname(hire_date) as hire_month from emp;

-- 3. Get employees hired before 2015.
select * from emp
where year(hire_date) < 2015;

-- 4. Calculate the number of years each employee has worked.
select name , timestampdiff(year, hire_date , curdate()) as years_of_emp from emp;

-- 5. Display the day of the week for each hire date.
select name, dayname(hire_date) as day_of_week from emp;

-- 6. Get the current date and show it with each employee.
select name , curdate() as date from emp;

-- 7. Show employees who were hired in the month of August.
select name as emp_August from emp
where month(hire_date) = 8;

-- 8. Get employees hired in the last 10 years
select * from emp
where hire_date >= date_sub(curdate(), interval 10 year);

-- 9. Add 1 year to each hire date.
select name , hire_date ,adddate(hire_date, interval 1 year) as new_hire_date from emp;

-- 10. Find the employee(s) with the earliest hire date
select name , hire_date  from emp
order by hire_date asc;

-- 11. Show employees with hire\_date in the first 15 days of the month.
select name , hire_date from emp
where day(hire_date) <= 15;

-- 12. Show difference in days between today and hire\_date.
select name , hire_date , datediff(curdate(), hire_date) as day_diff from emp;

-- 13. Extract only the date part of the hire\_date (remove time if added).
select name , date(hire_date) from emp;

-- 14. Format hire\_date as `'DD-MM-YYYY'`.
select date_format(hire_date, '%D-%m-%Y') as date_formated from emp;

-- 15. Count how many employees were hired each year

-- 16. Find the number of employees hired in the first quarter (Jan–Mar)
select name , hire_date from emp
where quarter(hire_date) <= 1;

-- 17. Get employees hired on a weekend
select name as emp_hire_on_weekend , hire_date, dayname(hire_date) as day_name from emp
where weekday(hire_date) = 5 or weekday(hire_date) = 6;

-- 18. Show all employees and their next work anniversary date

-- 19. Get employees who completed exactly 10 years this year.
select name, hire_date from emp
where year(curdate()) - year(hire_date) = 10 ;

-- 20. Show how many months each employee has completed in the company.
select name , hire_date , timestampdiff(month, hire_date, curdate()) as months_completed from emp;


-- revisition 
select now();
select curdate();
select curtime();
select date_format(now(),'%D-%M-%y');


-- day 
select day(curdate()) as Todays_date;
select time(now());

-- dateadd / we can change the date , year , month by changing the day to year to month
select date_add('2025-07-28', interval 5 day) as date_added;
select date_add('2025-07-28', interval 5 month) as month_added;
select date_add('2025-07-28', interval 5 year) as year_added;
select date_add('2025-06-28 10:00:00' , interval 30 minute) as add_minute;
select date_add( now() , interval 30 minute) as add_minutes;
select date_format( date_sub(now() , interval 30 minute) as sub_minutes , '%D-%M-%y' );

-- timestampdiff
select timestampdiff(month, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(day, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(year, '2025-02-22', '2026-05-22') as timestampdiff;
select timestampdiff(week, '2025-02-22', '2025-05-22') as timestampdiff;
select timestampdiff(quarter, '2025-02-22', '2026-05-22') as timestampdiff;

-- date sub
select date_sub('2025-06-28' , interval 5 day) as sub_date;
select date_sub('2025-06-28' , interval 5 month) as sub_month;
select date_sub('2025-06-28' , interval 5 year) as sub_year;
select date_sub('2025-06-28 10:00:00' , interval 30 minute) as sub_minutes;
select date_sub( now() , interval 30 minute) as sub_minutes;


-- date diff
select datediff('2025-08-28', now()) as date_diff;
select datediff(now(), '2025-08-28');

-- timediff
select timediff('6:25:30', '05:25:30');
select datediff('2025-08-28', now()) as date_diff;
select datediff(now(), '2025-08-28');

-- timediff
select timediff('6:25:30', '05:25:30');



