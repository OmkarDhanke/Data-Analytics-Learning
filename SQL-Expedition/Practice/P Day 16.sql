CREATE DATABASE IF NOT EXISTS saas_analytics;
USE saas_analytics;

DROP TABLE IF EXISTS user_subscriptions;

CREATE TABLE user_subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    plan_type VARCHAR(50),
    monthly_revenue DECIMAL(10,2),
    status VARCHAR(20),
    signup_date DATE,
    cancellation_date DATE
);

INSERT INTO user_subscriptions VALUES
(1001, 'Acme Corp', 'Enterprise', 1500.00, 'Active', '2023-01-15', NULL),
(1002, 'Beta LLC', 'Pro', 299.00, 'Active', '2023-03-22', NULL),
(1003, 'Charlie Inc', 'Basic', 49.00, 'Cancelled', '2023-05-10', '2023-11-01'),
(1004, 'Delta Co', 'Enterprise', 1500.00, 'Active', '2023-08-05', NULL),
(1005, 'Echo Startup', 'Basic', 49.00, 'Active', '2023-12-01', NULL),
(1006, 'Foxtrot Ltd', 'Pro', 299.00, 'Cancelled', '2022-11-20', '2023-02-15'),
(1007, 'Internal Test Account', 'Enterprise', 0.00, 'Active', '2022-01-01', NULL),
(1008, 'Golf Brothers', 'Pro', NULL, 'Pending', '2024-01-10', NULL);


-- =============================================================
-- DAY 16 ASSIGNMENTS: The Foundation
-- Domain: SaaS Subscriptions
-- =============================================================
SELECT * FROM saas_analytics.user_subscriptions;

-- Task 1 (Marketing Team):
-- "We need a clean list of all our customers and the plan they are on. 
-- Rename the columns to 'Company Name' and 'Subscription Tier'."
-- Write your query below:
SELECT	
	customer_name as "Company Name",
    plan_type as 'Subscription Tier'
FROM
	saas_analytics.user_subscriptions;

-- Task 2 (Sales Director):
-- "Pull a list of all 'Active' customers who pay more than $200 a month. 
-- Exclude any internal test accounts (where revenue is exactly $0.00)."
-- Write your query below:
SELECT
	customer_name,
    monthly_revenue,
    status
FROM
	saas_analytics.user_subscriptions
WHERE
	status = 'Active' AND monthly_revenue >= 200 ;
    
-- Task 3 (Customer Success):
-- "Give me a list of all customers who have 'Cancelled' their subscriptions. 
-- I want the most recent cancellations at the very top of the list."
-- Write your query below:
SELECT
	subscription_id,
    customer_name,
    cancellation_date
FROM
	saas_analytics.user_subscriptions
WHERE 
	cancellation_date is NOt Null
ORDER BY cancellation_date DESC;

-- Task 4 (Finance Team):
-- "Find any accounts where the 'monthly_revenue' is missing entirely from the system (NULL). 
-- I just need the company names."
-- Write your query below:
SELECT
	subscription_id,
    customer_name,
    monthly_revenue
FROM	
	saas_analytics.user_subscriptions
WHERE
	monthly_revenue IS NULL;
    
-- Task 5 (Interview-Style Challenge):
-- "Get me the details of our top 3 highest-paying 'Active' subscriptions. 
-- If there is a tie in revenue, sort them by who signed up first (oldest accounts at the top)."
-- Write your query below:
SELECT
	customer_name,
    monthly_revenue,
    status
FROM
	saas_analytics.user_subscriptions
WHERE
	status = 'Active' 
ORDER BY monthly_revenue DESC
LIMIT 3;
