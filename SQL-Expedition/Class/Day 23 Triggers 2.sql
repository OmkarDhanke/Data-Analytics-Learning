CREATE DATABASE Test;
use Test;
-- The main table for our employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10, 2) NOT NULL
);

-- The table to store the history of salary changes
CREATE TABLE salary_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employees (first_name, last_name, position, salary) VALUES
('Aarav', 'Sharma', 'Software Engineer', 80000.00),
('Priya', 'Patel', 'Project Manager', 120000.00);

DELIMITER //

CREATE TRIGGER before_employee_salary_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit(employee_id, old_salary, new_salary)
        VALUES(OLD.employee_id, OLD.salary, NEW.salary);
    END IF;
END;
//

DELIMITER ;

UPDATE employees
SET salary = 120000.00
WHERE employee_id = 1;

SELECT * FROM employees;

SELECT * FROM salary_audit;

drop TABLE Join_data;

CREATE TABLE Join_data (
	Join_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    first_name VARCHAR(50),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * from Join_data;

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO Join_data (employee_id, first_name, change_timestamp)
    VALUES (NEW.employee_id, NEW.first_name, NOW());
END;
//

DELIMITER ;

INSERT INTO employees (first_name, last_name, position, salary) VALUES
('Omkar','Dhanke', 'HR', 100000.00);



SELECT id, name , department, avg(salary)
OVER (partition by name) as salary FROM emp ORDER BY id;


SELECT id,name , salary ,
RANK() OVER(ORDER BY salary DESC ) as rank_salary,
DENSE_RANK() OVER(ORDER BY salary DESC) as Dence_salary,
ROW_NUMBER() OVER(ORDER BY salary DESC ) as salry_amount
from emp; 


SELECT OrderID,CustomerID,OrderDate,OrderTotal,
LEAD(OrderTotal, 1) OVER(PARTITION BY CustomerID ) as order_p1,
LAG (OrderTotal, 1) OVER(PARTITION BY CustomerID ) as order_p2,
LAG (OrderTotal, 1) OVER(PARTITION BY CustomerID ) as order_p3
from orders;

SELECT OrderID,CustomerID,OrderDate,OrderTotal,
LAG (OrderTotal, 1) OVER(PARTITION BY CustomerID ) as order_price
from orders;

