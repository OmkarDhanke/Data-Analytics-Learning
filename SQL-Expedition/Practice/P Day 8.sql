-- =============================================================
-- DAY 8: SQL PRACTICE SET - Date & Time Functions
-- Domain: "FitLife" Gym
-- Topics: DATEDIFF, DATE_ADD, TIMESTAMPDIFF, DAYNAME, NOW
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS FitLife_DB;
USE FitLife_DB;

-- Table 1: Members
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    date_of_birth DATE,
    join_date DATE
);

-- Table 2: Memberships (Tracks plan duration)
CREATE TABLE memberships (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    plan_type VARCHAR(20), -- 'Monthly', 'Annual'
    start_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Table 3: Check-in Logs (When they visited)
CREATE TABLE visits (
    visit_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    check_in_time DATETIME
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE visits;
TRUNCATE TABLE memberships;
TRUNCATE TABLE members;

INSERT INTO members (member_id, full_name, date_of_birth, join_date) VALUES
(1, 'John Doe', '1990-05-15', '2023-01-01'),
(2, 'Jane Smith', '1985-10-20', '2023-06-15'),
(3, 'Mike Ross', '2000-02-28', '2024-01-10');

INSERT INTO memberships (member_id, plan_type, start_date) VALUES
(1, 'Annual', '2023-01-01'),
(2, 'Monthly', '2024-03-01'),
(3, 'Monthly', '2024-01-10');

INSERT INTO visits (member_id, check_in_time) VALUES
(1, '2024-03-01 08:30:00'), -- Friday
(1, '2024-03-04 18:00:00'), -- Monday
(2, '2024-03-02 09:15:00'), -- Saturday
(2, '2024-03-03 10:00:00'), -- Sunday
(3, '2024-03-05 07:00:00'); -- Tuesday


-- 3. PRACTICE QUESTIONS
-- =============================================================

-- Question 1: Calculating Age (Precise)
-- We need to know how old each member is right now.
-- Select 'full_name' and 'Age'.
-- Hint: Use TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()).
SELECT
	full_name,
    date_of_birth,
    timestampdiff(Year,date_of_birth,Curdate()) as age
FROM
	fitlife_db.members;
    
-- Question 2: Membership Tenure
-- How many days has each member been with the gym?
-- Calculate the difference in days between 'join_date' and today (CURDATE()).
-- Hint: DATEDIFF(end_date, start_date).
SELECT
	full_name,
    datediff(CURDATE(),join_date) as 'Membership Tenure'
FROM
	fitlife_db.members;
-- Question 3: Expiry Projection (Future Dates)
-- We need to tell members when their current plan expires.
-- For 'Monthly' plans, the expiry is 30 days after 'start_date'.
-- For 'Annual' plans, the expiry is 1 year after 'start_date'.
-- Note: You can use a CASE statement to switch the logic, or just solve for Monthly first.
-- Hint: DATE_ADD(start_date, INTERVAL 30 DAY).
SELECT
	m.full_name,
	ms.start_date,
    CASE 
		WHEN ms.plan_type = 'Annual' THEN date_add(start_date, interval 30 day) 
        WHEN ms.plan_type = 'Monthly' THEN date_add(start_date, interval 1 year) 
	END as 'Plan Expiry'
FROM
	fitlife_db.memberships ms
JOIN fitlife_db.members m
ON m.member_id = ms.member_id;

-- Question 4: Analyzing Habits (Day of Week)
-- Which day of the week is busiest?
-- Group the 'visits' table by the name of the day (e.g., 'Monday').
-- Count the total visits per day name.
-- Hint: DAYNAME(check_in_time).
SELECT
	dayname(check_in_time) as Day_Name,
    COUNT(*) as visits_per_day
FROM fitlife_db.visits
GROUP BY Day_Name;

-- Question 5: Extracting Time
-- We want to know how many people check in BEFORE 9:00 AM (Early Birds).
-- Hint: You can use the HOUR() function or simple time comparison logic (check_in_time < ...).
SELECT
	visit_id,
    time(check_in_time) as Time
FROM fitlife_db.visits
WHERE
	hour(check_in_time) < 9.00;

-- Question 6: The "Anniversary" Check
-- Find members who joined in the month of January (regardless of the year).
-- Hint: MONTH(join_date) = 1.
SELECT
	full_name,
    monthname(join_date) as Join_Month
FROM	
	fitlife_db.members
WHERE MONTH(join_date) = 1;

-- Question 7: Duration Between Visits (Self-Join + Date Math)
-- (Tricky) John (ID 1) visited on March 1st and March 4th.
-- Calculate the number of days between his first visit and his last visit recorded in the system.
-- Hint: Find MIN(check_in_time) and MAX(check_in_time) for John, then use DATEDIFF.
SELECT
	m1.full_name,
    datediff(Min(v.check_in_time),MAX(v.check_in_time)) as 'Duration'
FROM
	fitlife_db.members m1
JOIN fitlife_db.visits v
ON m1.member_id  = v.member_id
GROUP BY m1.full_name;

-- Question 8: Formatting Dates
-- The default YYYY-MM-DD format is boring.
-- Select the visit check-in time formatted as "Day-Month-Year" (e.g., "01-03-2024").
-- Hint: DATE_FORMAT(column, '%d-%m-%Y').
SELECT
	date_format(check_in_time,'%d-%m-%Y') as New_Date
FROM
	fitlife_db.visits;
    
-- Question 9: Checking for "Expired" (Logic)
-- Assume today is '2024-04-01'.
-- Find any 'Monthly' memberships that started before '2024-03-01' (meaning they are now > 30 days old).
-- Hint: WHERE start_date < DATE_SUB('2024-04-01', INTERVAL 30 DAY).
SELECT
	member_id,
    plan_type
FROM	
	fitlife_db.memberships
WHERE
	start_date < date_sub('2024-04-01',interval 30 day)
    AND
    plan_type = 'monthly';
    
-- Question 10: Age Grouping
-- Count how many members are "Under 30" vs "30 and Over".
-- Hint: Combine your Age calculation (Q1) with a CASE statement or IF logic.
SELECT
	full_name,
    CASE
		WHEN timestampdiff(Year,date_of_birth,Curdate()) <= 30 THEN 'Under 30'
        WHEN timestampdiff(Year,date_of_birth,Curdate()) >= 30 THEN '30 and Over'
	END as 'Age Group'
FROM
	fitlife_db.members;