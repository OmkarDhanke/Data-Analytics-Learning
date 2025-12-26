CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department_id INT,
    status VARCHAR(20),
    country VARCHAR(50),
    email VARCHAR(200),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE salaries (
    employee_id INT,
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    currency VARCHAR(10),
    last_updated DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
################################################## Practice #######################################################
-- Create View
CREATE VIEW emp_data as (
	SELECT 
		employee_id,
		first_name,
		country,
		hire_date
	FROM
		viewdb.employees
);

SELECT * FROM emp_data;

-- Updating View 
CREATE or REPLACE VIEW emp_data as(
	
    	SELECT 
		employee_id,
		first_name,
		country
	FROM
		viewdb.employees

);
-- Renameing View
RENAME TABLE emp_data to Emp_data1;

-- Droping View 
DROP VIEW emp_data1;

################################################## Practice #######################################################
-- Q1: Create a view v_active_employee_directory that shows only:
--      employee_id, full_name (first_name + ' ' + last_name),
--      department_name, email, country
--      for employees whose status = 'Active'.
--      Then, write a SELECT query to read from this view.
CREATE or REPLACE VIEW v_active_employee_directory as (
	
    SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
        e.email,
        e.country
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
	WHERE
		status = 'Active'
);

SELECT * FROM viewdb.v_active_employee_directory;

-- Q2: Create a view v_us_employees that returns all columns from employees
--      but only for employees where country = 'USA' AND status = 'Active'.
--      Then, write a SELECT query to count how many rows this view returns.

CREATE VIEW v_us_employees as (

	SELECT 
		*
	FROM 
		viewdb.employees
	WHERE
		country = 'USA' AND
        status = 'Active'
);
-- Q3: Create a view v_employee_compensation that joins employees, departments,
--      and salaries to show:
--      employee_id, full_name, department_name, base_salary, bonus, currency.
--      Only include employees whose status = 'Active'.
--      Then, write a SELECT to get all rows from this view.
CREATE VIEW v_employee_compensation as (
	
	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
		s.base_salary,
        s.bonus,
        s.currency
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
        LEFT JOIN salaries as s
        ON e.employee_id = s.employee_id
	WHERE
		status = 'Active'
);

SELECT * FROM v_employee_compensation;

-- Q4: Create a view v_secure_hr_intern that:
--      - Joins employees, departments, salaries
--      - Returns employee_id, full_name, department_name, country, email
--      - DOES NOT return base_salary or bonus (hide salary details).
--      This view is meant to be safe for an HR intern.
--      Then, write a SELECT from this view to see all active employees in India.
CREATE VIEW v_secure_hr_intern as (

	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
		e.country,
        e.email
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
        LEFT JOIN salaries as s
        ON e.employee_id = s.employee_id
	WHERE
		status = 'Active'
);
SELECT * FROM v_secure_hr_intern;

-- Q5: Create a view v_department_salary_summary that shows, per department:
--      department_name, headcount (count of employees),
--      avg_base_salary, total_bonus.
--      Only include employees with status = 'Active'.
--      Then, write a SELECT on this view to find the department
--      with the highest avg_base_salary.

CREATE or REPLACE VIEW v_department_salary_summary as (

	SELECT
		d.department_name,
        count(*) as headcount,
        Round(AVG(s.base_salary),2) as avg_base_salary,
        SUM(s.bonus) as Total_bonus
	FROM	
		departments as d
        LEFT JOIN employees as e
        ON d.department_id = e.department_id
        LEFT JOIN salaries as s
        ON e.employee_id = s.employee_id
	WHERE status = 'Active'
	GROUP BY
		d.department_name
);

SELECT * FROM v_department_salary_summary;

-- Q6: Create a view v_inactive_employees that lists all employees
--      whose status = 'Inactive' with:
--      employee_id, full_name, department_name, country, hire_date.
--      Then, write a SELECT using this view to find how many inactive employees
--      exist in each country.
CREATE VIEW v_inactive_employees as (
	
	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
        e.country,
        e.hire_date
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
	WHERE
		status = 'Inactive'
);

SELECT * FROM v_inactive_employees;

-- Q7: Create a view v_recent_hires that returns employees hired on or after
--      '2022-01-01', with employee_id, full_name, department_name, hire_date.
--      Then, write a SELECT using this view to list recent hires in the 'Engineering' department.

CREATE VIEW v_recent_hires as (

	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
        e.country,
        e.hire_date
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
	WHERE
		hire_date >= '2022-01-01'
);

SELECT * FROM v_recent_hires
WHERE department_name = 'Engineering';

-- Q8: Simulatea schema change using views:
--      Step 1: Create a view v_employee_simple with columns:
--              emp_id (employee_id), emp_name (full_name), dept (department_name).
--      Step 2: Later, "change the logic" by recreating this view using
--              CREATE OR REPLACE VIEW so that it only shows Active employees.
--      Write both CREATE VIEW statements (original + modified) in order.

CREATE VIEW v_employee_simple as(
		SELECT 
			e.employee_id as emp_id,
			concat(e.first_name,' ',e.last_name) as emp_name,
			d.department_name as dept
		FROM	
			employees as e
			LEFT JOIN departments as d
			ON e.department_id = d.department_id
		);
        
CREATE or REPLACE VIEW v_employee_simple as(
		SELECT 
			e.employee_id as emp_id,
			concat(e.first_name,' ',e.last_name) as emp_name,
			d.department_name as dept
		FROM	
			employees as e
			LEFT JOIN departments as d
			ON e.department_id = d.department_id
		WHERE
			e.status = 'Active'
);

-- Q9: Create a view v_multi_currency_salary that returns employees
--      (only Active) whose currency is NOT 'INR', with:
--      employee_id, full_name, department_name, base_salary, bonus, currency.
--      Then, write a SELECT using this view to count how many employees
--      are paid in each currency.

CREATE VIEW v_multi_currency_salary as (
	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
		s.base_salary,
        s.bonus,
        s.currency
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
        LEFT JOIN salaries as s
        ON e.employee_id = s.employee_id
	WHERE
		status = 'Active' AND
        currency NOT IN ('INR')
);

SELECT  
	currency,
    COUNT(*) as head_count
FROM v_multi_currency_salary
GROUP BY currency;
	
-- Q10: Create a view v_high_earners that shows Active employees whose
--       base_salary is greater than a threshold (e.g., > 100000 in their currency),
--       with: employee_id, full_name, department_name, base_salary, currency.
--       Then, write a SELECT on this view to list high earners grouped by country.
CREATE VIEW v_high_earners as (
	SELECT 
		e.employee_id,
		concat(e.first_name,' ',e.last_name) as Full_name,
        d.department_name,
		s.base_salary,
        e.country,
        s.currency
	FROM 
		employees as e
		LEFT JOIN departments as d
		on e.department_id = d.department_id
        LEFT JOIN salaries as s
        ON e.employee_id = s.employee_id
	WHERE
		status = 'Active' AND
        base_salary > 100000.00
);
SELECT 
	country,
    COUNT(*) as High_erner_count
FROM
	v_high_earners
GROUP BY country;
