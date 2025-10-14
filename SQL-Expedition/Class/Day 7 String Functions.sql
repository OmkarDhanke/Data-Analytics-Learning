
-- lapad/rpad
select lpad(emp_id,'6','0') as Emp_id from employees;
select rpad(emp_id,'6','0') as Emp_id from employees;

-- substring_index
select substring_index("www.gamil.com",'.',-1);
select substring_index("Amit Sharma"," ",1) as name;

-- 1. Show the first name from the full name of each employee.
select substring_index(name," ",1) as first_name from emp;

-- 2. Display all employee names in uppercase.
select upper(name) as uppercase_name from emp;

-- 3. Display all employee names in lowercase.
select lower(name) as lowercase_name from emp;

-- 4. Find the length of each employee’s name.
select length(name) as name_lenth from emp;

-- 5. Get the name of employees whose email ends with "@xyzmail.com".
select substring_index(email,'@xyzmail.com',1) as Email_Name from emp;

-- 6. Replace `xyzmail.com` with `abc.com` in each email.
select replace(email,'xyzmail.com','abc.com') as New_Email from emp;

-- 7. Show the employee names reversed.
select reverse(name) as reverse_name from emp;

-- 8. Trim spaces from contact numbers (if any).
select trim(' 123456789 ');
select trim(leading '_' from '_omkar' );

-- 9. Get the position of '@' in each email.
select locate('@', email) as Email_position from emp;

-- 10. Get the domain part of the email (after @).
select substring_index(email,'@', -1) as domain_name from emp;

-- 11. Concatenate `name` and `department` with a hyphen. 
select concat(name,'-',department) as Name_department from emp;

-- 12. Show the first 5 characters of each employee's email.
select left(email,5) as name from emp;

-- 13. Pad employee names with '\*' on the left to make them 20 characters long.
select lpad(name,20,'*') as name from emp;

-- 14. Extract the last word (surname) from the name.
select substring_index(name,' ',-1) as surname from omkar_db.emp;

-- 15. Show the email in lowercase and name in uppercase together.
select concat(upper(name),'-',lower(email)) as name_email from emp;

-- 16. Get names that start with ‘A’.
select name from emp
where name like 'A%';

-- 17. Get employees whose name contains 'ar' anywhere.
select name from emp
where name like '%AR%';

