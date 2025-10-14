use companydata;

use omkar_db;
SELECT * from emp
WHERE id = 3;

-- Update
UPDATE emp 
SET is_active = 0
WHERE id = 3;

UPDATE emp
SET is_active = 1 , manager_id = 3
WHERE id = 3;

-- Delete
DELETE FROM orders
where orderid = 101;

-- TCL 

-- View the current data
SELECT * FROM employees;

-- Start a new transaction
START TRANSACTION;

-- Insert the first employee
INSERT INTO employees(emp_id, full_name, age, gender, salary, department_id) VALUES
(112, 'Omkar', 21, 'Male', 55000.00, 2);

-- Savepoint after first insert
SAVEPOINT sp_first_insert;


-- Insert multiple employees (Make sure emp_id values are unique)
INSERT INTO employees(emp_id, full_name, age, gender, salary, department_id) VALUES
(101, 'Anil', 30, 'Male', 60000.00, 1),
(102, 'Priya', 28, 'Female', 72000.00, 2),
(103, 'Rohit', 35, 'Male', 65000.00, 2),
(104, 'Neha', 26, 'Female', 58000.00, 3),
(105, 'Karan', 40, 'Male', 80000.00, 2),
(106, 'Sneha', 31, 'Female', 69000.00, 4),
(107, 'Ramesh', 45, 'Male', 85000.00, 5),
(108, 'Swati', 29, 'Female', 61000.00, 1),
(109, 'Manish', 33, 'Male', 78000.00, 3),
(110, 'Isha', 27, 'Female', 70000.00, 4),
(113, 'Ananya Sharma', 24, 'Female', 62000.00, 1),
(114, 'Ravi Deshmukh', 29, 'Male', 58000.00, 3),
(115, 'Sneha Patil', 26, 'Female', 61000.00, 2),
(116, 'Aditya Mehta', 31, 'Male', 67000.00, 4);

-- Savepoint after all inserts
SAVEPOINT sp_bulk_insert;

-- Update Omkar's name only
UPDATE employees
SET full_name = 'Omi Sharma'
WHERE emp_id = 112;

-- Savepoint after update
SAVEPOINT sp_after_update;

-- Delete one employee
DELETE FROM employees 
WHERE emp_id = 114;

-- ROLLBACK: Undo the DELETE only
ROLLBACK TO sp_after_update;

-- Final COMMIT to save all changes except the deleted row
COMMIT;

-- View final result
SELECT * FROM employees;
