-- ===========================
-- 1) Employees Table
-- ===========================
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(12,2),
    department VARCHAR(100),
    hire_date DATE
);

-- ===========================
-- 2) Audit Logs Table
-- ===========================
CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    action_message VARCHAR(255),
    action_date DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

delimiter $$
	CREATE TRIGGER log_new_hire
    after insert on employees
    for each row
		begin
			insert INTO audit_logs(employee_id,action_message,action_date) values
            (NEW.employee_id,'New Employee Hire',Now());
		END $$
Delimiter ;

INSERT INTO employees
(first_name,last_name,salary,department,hire_date) VALUES
('Omkar','Dhanke',60000.00,'Analyst',curdate());

delimiter $$
	CREATE TRIGGER Salary_Log_change
    after Update on employees
    for each row
		begin
			If 
			old.salary <> new.salary THEN
				insert INTO audit_logs(employee_id,action_message,action_date) values(
				old.employee_id,Concat('Salary Change','Old:',old.salary,'New:',New.salary),Now()
                );
			END IF;
        END $$
Delimiter ;

UPDATE employees set salary = 40000.00 WHERE employee_id = 11;
/*
-------------------------------------------------------------------------
PRACTICE QUESTIONS: TRIGGERS (MySQL)
Database Context: employees, audit_logs
-------------------------------------------------------------------------
Note: Remember to use DELIMITER $$ ... END $$ for triggers.
*/

-- Q1: (Basic Logging) Create a trigger named 'LogNewHire'.
--     Timing: AFTER INSERT on the 'employees' table.
--     Logic: Insert a record into 'audit_logs'.
--            Message: 'New employee hired'.
--            Employee_ID: Use the NEW.employee_id.
--            Action_Date: NOW().
Delimiter $$
	CREATE TRIGGER log_new_hire
    after insert on employees
    for each row
		BEGIN
			insert INTO audit_logs(employee_id,action_message,action_date) values
            (NEW.employee_id,'New Employee Hire',Now());
		END $$
Delimiter ;

-- Q2: (Data Cleaning) Create a trigger named 'FormatDepartment'.
--     Timing: BEFORE INSERT on the 'employees' table.
--     Logic: Automatically convert the 'department' name to UPPERCASE before it gets saved.
--     (Hint: SET NEW.department = UPPER(NEW.department)).
Delimiter $$
	CREATE TRIGGER FormatDepartment
    BEFORE insert on employees
    for each row
		begin
			SET NEW.department = upper(NEW.department);
		END $$
Delimiter ;

-- Q3: (Conditional Logging) Create a trigger named 'LogSalaryChange'.
--     Timing: AFTER UPDATE on the 'employees' table.
--     Logic: Check IF the salary has changed (NEW.salary <> OLD.salary).
--            If yes, insert into 'audit_logs' with message: 'Salary Updated'.
Delimiter $$
	CREATE TRIGGER LogSalaryChange
    AFTER UPDATE on employees
    for each row
		begin
			if old.salary <> new.salary Then
				INSERT INTO audit_logs(action_message) VALUES
			(
				'Salary Updated'
			);
			end IF;
		END $$
Delimiter ;

-- Q4: (Detailed Auditing) Create a trigger named 'LogSalaryDetails'.
--     Timing: AFTER UPDATE on the 'employees' table.
--     Logic: Insert a log message that includes the specific numbers.
--            Message format: "Salary changed from [OLD Amount] to [NEW Amount]".
--            (Hint: Use CONCAT).
Delimiter $$
	CREATE TRIGGER LogSalaryDetails
    AFTER UPDATE on employees
    for each row
		begin
			IF old.salary <> New.Salary Then
				INSERT INTO audit_logs(old.employee_id,action_message,action_date) VALUES
                (
					OLD.employee_id,concat('Salary Chaged From',Old.salary,'To',New.salary),now()
                );
            END IF;
		END $$
Delimiter ;

-- Q5: (Validation / Protection) Create a trigger named 'PreventNegativeSalary'.
--     Timing: BEFORE INSERT on the 'employees' table.
--     Logic: IF the NEW.salary is less than 0, stop the insert.
--     (Hint: Use SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative').
Delimiter $$
	CREATE TRIGGER PreventNegativeSalary
    BEFORE INSERT on employees
    for each row
		BEGIN
			IF New.Salary < 0 THEN
				SIGNAL SQLSTATE '45000' SET Message_TEXT = 'Salary cannot be negative';
            END IF;
		END $$
Delimiter ;


-- Q6: (Business Logic Enforcement) Create a trigger named 'NoSalaryReduction'.
--     Timing: BEFORE UPDATE on the 'employees' table.
--     Logic: Check if NEW.salary < OLD.salary.
--            If true, generate an error (SIGNAL SQLSTATE) to block the update.
Delimiter $$
	CREATE TRIGGER NoSalaryReduction
    BEFORE UPDATE on employees
    for each row
		begin
			IF NEW.salary < OLD.Salary Then
				SIGNAL SQLSTATE '45000' set message_text  = 'New Salay cannot be Lower Than the Old salary';
            END IF;
		END $$
Delimiter ;


-- Q7: (Default Values) Create a trigger named 'SetDefaultHireDate'.
--     Timing: BEFORE INSERT on the 'employees' table.
--     Logic: IF the NEW.hire_date is NULL, automatically set it to the current date (CURDATE).
Delimiter $$
	CREATE TRIGGER SetDefaultHireDate
    BEFORE INSERT on employees
    for each row
		begin
			IF new.hire_date is null Then
				set new.hire_date = curdate();
            END IF;
		END $$
Delimiter ;

-- Q8: (Formatting) Create a trigger named 'CleanNames'.
--     Timing: BEFORE INSERT on the 'employees' table.
--     Logic: Ensure the first_name and last_name have no leading/trailing spaces (use TRIM).
Delimiter $$
	CREATE TRIGGER CleanNames
    BEFORE INSERT on employees
    for each row
		begin
			set new.first_name = trim(new.first_name) and 
            New.last_name = trim(New.last_name);
		END $$
Delimiter ;

-- Q9: (Department Logic) Create a trigger named 'LogDeptTransfer'.
--     Timing: AFTER UPDATE on the 'employees' table.
--     Logic: IF the department has changed (OLD.department != NEW.department),
--            Insert a log message: "Transferred from [Old Dept] to [New Dept]".
Delimiter $$
	CREATE TRIGGER LogDeptTransfer
    AFTER UPDATE on employees
    for each row
		begin
			IF OLD.department != NEW.department THEN
            INSERT INTO audit_logs(old.employee_id,action_message,action_date) VALUES
            (
				old.employee_id,
                concat('Transferred from',OLD.department, 'TO', NEW.department),
                now()
            );
            END IF;
		END $$
Delimiter ;

-- Q10: (Deletion Protection) Create a trigger named 'ProtectCEO'.
--      Timing: BEFORE DELETE on the 'employees' table.
--      Logic: IF the OLD.department is 'Executive' (or 'CEO'), block the deletion with an error message.
Delimiter $$
	CREATE TRIGGER ProtectCEO
    BEFORE UPDATE on employees
    for each row
		begin
			IF OLD.department in ('Executive','CEO') Then
				SIGNAL SQLSTATE '45000' set message_text  = 'Cannot Execte the Query';
            END IF;
		END $$
Delimiter ;