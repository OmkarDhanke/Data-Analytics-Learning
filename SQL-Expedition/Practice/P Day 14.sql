-- =============================================================
-- DAY 14: REAL-WORLD ANALYTICS - Cohort Analysis & Retention
-- Domain: "CloudSync" SaaS Platform
-- Focus: Date extraction, Month Indexing, CTEs, Pivot Tables
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS CloudSync_DB;
USE CloudSync_DB;

DROP TABLE IF EXISTS user_activity;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE
);

-- Tracks any day a user logs in and uses the software
CREATE TABLE user_activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2. POPULATE DATA (Spanning Jan, Feb, March 2024)
-- =============================================================
-- 3 Users signed up in January, 2 signed up in February
INSERT INTO users (user_id, signup_date) VALUES
(1, '2024-01-05'),
(2, '2024-01-15'),
(3, '2024-01-20'),
(4, '2024-02-02'),
(5, '2024-02-10');

-- User 1: Active in Jan (Month 0), Feb (Month 1), Mar (Month 2)
-- User 2: Active in Jan (Month 0), Feb (Month 1) - Churned in March
-- User 3: Active in Jan (Month 0) - Churned immediately
-- User 4: Active in Feb (Month 0), Mar (Month 1)
-- User 5: Active in Feb (Month 0) - Churned in March
INSERT INTO user_activity (user_id, activity_date) VALUES
(1, '2024-01-05'), (1, '2024-01-28'), (1, '2024-02-15'), (1, '2024-03-10'),
(2, '2024-01-15'), (2, '2024-02-20'), 
(3, '2024-01-20'), 
(4, '2024-02-02'), (4, '2024-03-05'), (4, '2024-03-25'),
(5, '2024-02-10'), (5, '2024-02-12');


-- 3. THE BUSINESS REQUESTS (Building the Cohort step-by-step)
-- =============================================================

-- Request 1: "Define the Cohorts"
-- We define a cohort by the Year and Month a user signed up (e.g., '2024-01').
-- Write a query that shows every user_id and their 'cohort_month'.
-- Vague Hint: Use a date formatting function that outputs just the Year and Month from the signup_date.
SELECT
	user_id,
	date_format(signup_date,'%Y-%m') cohort_month
FROM
	cloudsync_db.users;
    
-- Request 2: "Map Activity to Cohorts"
-- Join the `users` and `user_activity` tables. 
-- Show the user_id, their 'cohort_month' (from Q1), and the Year-Month of their activity (let's call it 'activity_month').
-- Vague Hint: Standard INNER JOIN, applying the date formatting function to both the signup_date and the activity_date.
SELECT
	u1.user_id,
    date_format(u2.activity_date,'%Y-%m') 'activity_month'
FROM 
	cloudsync_db.users as u1
    INNER JOIN cloudsync_db.user_activity as u2
    ON u1.user_id = u2.user_id;
    
-- Request 3: "Calculate the Month Index (The offset)"
-- We need to know if an activity happened in "Month 0" (Signup month), "Month 1" (First month after signup), etc.
-- Using the joined data from Q2, calculate the difference in months between the activity_date and the signup_date. Call this 'month_index'.
-- Vague Hint: Look up the TIMESTAMPDIFF() function specifically for MONTHS.
SELECT
	u1.user_id,
    DATE_FORMAT(u1.signup_date, '%Y-%m') AS Cohort_Month,
	TIMESTAMPDIFF(MONTH, u1.signup_date, u2.activity_date) AS month_index
FROM 
	cloudsync_db.users as u1
    INNER JOIN cloudsync_db.user_activity as u2
    ON u1.user_id = u2.user_id;

-- Request 4: "Get Distinct Active Users per Cohort/Month"
-- We don't care if User 1 logged in 5 times in February; we just care that they logged in at least once.
-- Group your data by 'cohort_month' and 'month_index'. Count the number of DISTINCT users for each grouping.
-- Vague Hint: Build a CTE using your code from Q3, then group that CTE and count unique user_ids.
WITH CTE_1 AS (
	SELECT
		monthname(activity_date) AS Month_Name,
        count(DISTINCT user_id) as USER_COUNT
	FROM 
		cloudsync_db.user_activity
	GROUP BY Month_Name
)
SELECT
	*
FROM
	CTE_1
ORDER BY Month_Name ;

-- Request 5: "The Final Pivot (The Cohort Retention Table)" (Advanced)
-- Take the data from Q4 and pivot it so it looks like a real business report!
-- Your output should have these columns: 
-- `Cohort_Month`, `Month_0_Users`, `Month_1_Users`, `Month_2_Users`.
-- Vague Hint: Use the conditional aggregation trick (SUM + CASE WHEN) you learned on Day 12. Check if the 'month_index' equals 0, 1, or 2.
WITH CohortBase AS (
	SELECT
		u1.user_id,
		DATE_FORMAT(u1.signup_date, '%Y-%m') AS Cohort_Month,
		TIMESTAMPDIFF(MONTH, u1.signup_date, u2.activity_date) AS month_index
	FROM 
		cloudsync_db.users as u1
		INNER JOIN cloudsync_db.user_activity as u2
		ON u1.user_id = u2.user_id
)
SELECT 
    Cohort_Month,
    -- Month 0 (The month they signed up)
    COUNT(DISTINCT CASE WHEN month_index = 0 THEN user_id END) AS Month_0_Users,
    
    -- Month 1 (One month later)
    COUNT(DISTINCT CASE WHEN month_index = 1 THEN user_id END) AS Month_1_Users,
    
    -- Month 2 (Two months later)
    COUNT(DISTINCT CASE WHEN month_index = 2 THEN user_id END) AS Month_2_Users
FROM 
    CohortBase
GROUP BY 
    Cohort_Month
ORDER BY 
    Cohort_Month;
    
