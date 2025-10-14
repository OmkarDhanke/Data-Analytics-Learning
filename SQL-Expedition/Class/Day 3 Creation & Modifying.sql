-- select the data base
USE omkar_db;

show tables;

-- Create table name emp for storing employee data as per the filleds 
CREATE TABLE emp(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    hire_date DATE,
    email VARCHAR(100),
    contact VARCHAR(15),
    is_active BOOLEAN,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    manager_id INT,
    gender VARCHAR(10)
);

-- to insert in to the table we use incert command where first we have to describe the coloums that we are going to incert 
INSERT INTO emp
(id, name, age, hire_date, email, contact, is_active, department, salary, manager_id, gender) 
VALUES 
(1, 'Amit Sharma', 30, '2015-03-15', 'amit.sharma@xyzmail.com', '9876543210', 1, 'Engineering', 75000.00, NULL, 'male'),
(2,	'Priya Patel',	28,	'2016-07-22',	'priya.patel@xyzmail.com',	'9876543211',	1,	'Marketing',	65000.00,	1,	'Female'),
(3,	'Ravi Kumar',	35,	'2012-10-10',	'ravi.kumar@xyzmail.com',	'9876543212',	0,	'Sales',	85000.00,	2,	'Male'),
(4,	'Neha Desai',	40,	'2010-01-25',	'neha.desai@xyzmail.com',	'9876543213', 	1,	'HR',	95000.00, NULL,	'Female'),
(5,'Vikram Reddy', 26, '2017-08-30',	'vikram.reddy@xyzmail.com',	'9876543214',	1,	'Engineering',	70000.00,	1,	'Male'),
(6,	'Sita Nair',	31,	'2014-05-18',	'sita.nair@xyzmail.com',	'9876543215',	1,	'Marketing',	72000.00,	2,	'Female'),
(7,	'Arun Singh',	38,	'2013-09-01',	'arun.singh@xyzmail.com',	'9876543216',	1,	'Sales',	80000.00,	3,	'Male'),
(8,	'Anjali Gupta',	29,	'2016-11-12',	'anjali.gupta@xyzmail.com',	'9876543217',	1,	'HR',	68000.00,	4,	'Female'),
(9,	'Kunal Verma',	45,	'2009-02-14',	'kunal.verma@xyzmail.com',	'9876543218',	0,	'Engineering',	95000.00, NULL,	'Male'),
(10, 'Isha Mehta',	33,	'2011-12-05',	'isha.mehta@xyzmail.com',	'9876543219',	1,	'Sales',	74000.00,	3,	'Female'),
(11, 'Rahul Joshi',	42,	'2008-06-17',	'rahul.joshi@xyzmail.com',	'9876543220', 	1,	'Engineering',	105000.00,	1,	'Male'),
(12, 'Simran Kaur',	27,	'2018-02-09',	'simran.kaur@xyzmail.com',	'9876543221', 	1,	'HR',	62000.00,	4, 'Female');

-- to see all the data that we inputed in the table we use select command
select * from emp;
select * from emp_info;
select * from emp_master;

-- to add a Column we use ALTER commad 
alter table emp ADD(location varchar(100));

-- to change the name off the newly added column we use change column name 
alter table emp 
change location address varchar(100);

-- To modify existing column we use modify command 
alter table emp MODIFY address varchar(300);

-- To drop  the column we use drop command 
alter table emp drop address;

-- Rename the entire table we use rename commnad 
RENAME table emp to emp_info;

-- the truncate command is use to remove all the entry present in the table 
truncate table emp_master;

-- update table single entry 
update emp_info set manager_id = 1 where id = 1;

-- the update command use to update multiple entry at once 
UPDATE emp_info SET age = 31 , salary = 85000.00 where id = 1;

-- Practice Test
-- add new column name experience_years
alter table emp_info add(
experience_years int
);

-- Update experience_years for Rahul Joshi to 15.
update emp_info set experience_years = 15 where id = 11;

-- incert a new emp to the table 
INSERT INTO emp_info
(id, name, age, hire_date, email, contact, is_active, department, salary, manager_id, gender,address,experience_years) 
VALUES
(13, 'Rohit Shetty', 34, '2019-05-21', 'rohit.shetty@xyzmail.com', '9876543222', 1, 'Marketing', 67000.00, 2, 'Male', NULL, 5);

-- Modify experience_years column to FLOAT to store decimals.
alter table emp_info modify experience_years float;

-- Change Rohit Shetty’s experience_years to 5.5.
update emp_info set experience_years = 5.5 where id = 13;

-- Rename emp_info to employee_master.
rename table emp_info to emp_master; 

-- Add a column status (VARCHAR(20)).
alter table emp_master ADD (status varchar(20));

-- Set status to 'Resigned' for Kunal Verma (id 9).
update emp_master set status = 'Resigned' where id = 9;

-- Drop the status column.
alter table emp_master drop status;

-- Truncate employee_master to clear all data.
truncate table emp_master;

-- Insert 1 new record to verify truncate works.
insert into emp_master(id,name,age,hire_date,email,contact,is_active,department,salary,manager_id,gender,address,experience_years)
values
(13,'Omkar Dhanke', 21, '2024-02-01','omkar@dhanke.in','1234567890',1,'HR',45000.00,2,'Male',null,10.5 );







