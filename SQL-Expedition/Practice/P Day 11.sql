-- =============================================================
-- DAY 11: SQL PRACTICE SET - Interview Patterns (Product Analytics)
-- Domain: "VibeCheck" Social Media App
-- Topics: DISTINCT counting, Rolling Metrics, Lead/Lag, Retention
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS VibeCheck_DB;
USE VibeCheck_DB;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    country VARCHAR(50)
);

CREATE TABLE user_logins (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    login_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE user_logins;
TRUNCATE TABLE users;

INSERT INTO users (user_id, signup_date, country) VALUES
(1, '2024-03-01', 'USA'),
(2, '2024-03-01', 'UK'),
(3, '2024-03-02', 'USA'),
(4, '2024-03-05', 'Canada'),
(5, '2024-03-10', 'UK');

-- Note: Users might log in multiple times a day, but for DAU we only care IF they logged in.
INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2024-03-01'), (1, '2024-03-02'), (1, '2024-03-03'), (1, '2024-03-04'), -- User 1 is very active
(2, '2024-03-01'), (2, '2024-03-01'), (2, '2024-03-05'), -- User 2 logged in twice on day 1
(3, '2024-03-02'), (3, '2024-03-15'), 
(4, '2024-03-05'), (4, '2024-03-06'), 
(5, '2024-03-10'); -- User 5 only logged in on signup day


-- 3. INTERVIEW QUESTIONS
-- ============================================================
-- Question 1: Daily Active Users (DAU) - [Classic Phone Screen Question]
-- Calculate the number of unique users who logged in on each day.
-- Output: login_date, DAU_Count.
-- Vague Hint: Grouping by date is easy, but make sure you don't double-count users who log in twice a day.
select 
	login_date,
    count(DISTINCT user_id) as DAU_Count
from
	vibecheck_db.user_logins
GROUP BY login_date
ORder by login_date;

-- Question 2: Monthly Active Users (MAU) approximation
-- Calculate the total number of unique users who logged in during the month of March 2024.
-- Vague Hint: Filter for the month, and count the unique identities.
SELECT
	COUNT(DISTINCT user_id) as MAU
FROM
	vibecheck_db.user_logins
WHERE
	month(login_date) = 3;

-- Question 3: "Time to First Action"
-- For each user, find out how many days it took them to make their VERY FIRST login after signing up.
-- Output: user_id, days_to_first_login.
-- Vague Hint: Find the earliest login date per user (aggregate or window), join it to the users table, and do date math.
SELECT
	u.user_id,
    datediff(l.login_date,u.signup_date) as days_to_first_login
FROM
	vibecheck_db.users as u
    INNER JOIN vibecheck_db.user_logins as l
    ON u.user_id = l.user_id
ORDER BY days_to_first_login DESC;

-- Question 4: "One-and-Done" Users (Churn Risk)
-- Find the user_ids of people who have only logged into the app on exactly ONE distinct date.
-- Vague Hint: Group the logins by user, count their distinct login dates, and filter the grouped result.
SELECT
	user_id,
    count(DISTINCT login_date) as Days
FROM 
	vibecheck_db.user_logins
GROUP BY user_id
HAVING Days = 1;

-- Question 5: Super Users (Frequency)
-- Find users who have logged in on 3 or more DISTINCT days. 
-- Vague Hint: Very similar logic to Question 4, just changing the threshold condition.
SELECT
	user_id,
    count(DISTINCT login_date) as Days
FROM 
	vibecheck_db.user_logins
GROUP BY user_id
HAVING Days >= 3;

-- Question 6: Consecutive Logins (The "Streak" Problem) - [Very Common Interview Q]
-- Find user_ids of people who logged in on consecutive days (e.g., logged in on March 1 AND March 2).
-- Vague Hint: You can solve this by Self-Joining the login table to itself where Date2 = Date1 + 1 day, OR by using the LEAD() window function to look at the next row's date.
SELECT DISTINCT user_id
FROM
	(
		SELECT
			user_id,
            login_date,
            LEAD(login_date) OVER(PARTITION BY user_id ORDER BY login_date) as next_login
		FROM
			vibecheck_db.user_logins
    ) d
WHERE
	datediff(next_login,login_date) = 1;
    
-- Question 7: Day 1 Retention (Product Analytics Classic)
-- "Day 1 Retention" asks: "Did the user log in exactly 1 day after they signed up?"
-- Calculate how many users successfully hit their Day 1 Retention. (Output just a single number).
-- Vague Hint: Join users and logins. Filter for rows where the login_date is exactly 1 day after the signup_date. Then count them.
with Retention as (
SELECT
	u.user_id,
    datediff(l.login_date,u.signup_date) as days_to_first_login
FROM
	vibecheck_db.users as u
    INNER JOIN vibecheck_db.user_logins as l
    ON u.user_id = l.user_id
ORDER BY days_to_first_login DESC)
SELECT
	user_id,
    days_to_first_login
FROM
	Retention 
WHERE
	days_to_first_login = 1;
    
-- Question 8: Total Logins per User (Including Zeroes)
-- List ALL users and the total number of times they have logged in. 
-- If a user has never logged in, show 0.
-- Vague Hint: You need a specific type of Join from the users table, and when you count, make sure you count a column from the right table, not '*'.
SELECT
	u.user_id,
    count(l.login_date) as Total_login
FROM
	vibecheck_db.users as u
    LEFT JOIN vibecheck_db.user_logins as l
    ON u.user_id = l.user_id
GROUP BY u.user_id;
	
-- Question 9: Rolling 3-Day Average of Logins
-- This is a tough one. List each login_date and the total number of logins that happened on that day.
-- Next to it, add a column showing the average number of logins over the trailing 3 days (Current Day + 2 Preceding days).
-- Vague Hint: Create a CTE that gets the daily totals first. Then, run a Window Function over that CTE using a ROWS BETWEEN frame.
WITH daily_logins AS (
    SELECT 
        login_date,
        COUNT(*) AS total_logins
    FROM vibecheck_db.user_logins
    GROUP BY login_date
)
SELECT 
    login_date,
    total_logins,
    AVG(total_logins) OVER (
        ORDER BY login_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3day_avg
FROM daily_logins
ORDER BY login_date;

-- Question 10: Reactivation (Gaps in engagement)
-- Find any instance where a user logged in, but their PREVIOUS login was more than 5 days ago.
-- Output: user_id, login_date, days_since_last_login.
-- Vague Hint: You must use the LAG() window function to look at the previous chronological row for that specific user, then calculate the difference.
 WITH login_history AS (
    SELECT 
        user_id,
        login_date,
        LAG(login_date) OVER (
            PARTITION BY user_id 
            ORDER BY login_date
        ) AS prev_login
    FROM vibecheck_db.user_logins
)
SELECT 
    user_id,
    login_date,
    DATEDIFF(login_date, prev_login) AS days_since_last_login
FROM login_history
WHERE prev_login IS NOT NULL
  AND DATEDIFF(login_date, prev_login) > 5
ORDER BY user_id, login_date;