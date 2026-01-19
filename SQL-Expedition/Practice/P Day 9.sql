-- =============================================================
-- DAY 9: SQL PRACTICE SET - CTEs & Views
-- Domain: "NextGen" Recruitment
-- Topics: WITH (CTE), Multiple CTEs, CREATE VIEW
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS NextGen_DB;
USE NextGen_DB;

-- Table 1: Candidates (The Talent)
CREATE TABLE candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    primary_skill VARCHAR(50), -- 'Python', 'SQL', 'Management'
    years_experience INT,
    expected_salary INT
);

-- Table 2: Jobs (The Openings)
CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(50),
    required_skill VARCHAR(50),
    min_experience INT,
    offered_salary INT
);

-- Table 3: Applications (The Link)
CREATE TABLE applications (
    app_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    candidate_id INT,
    app_date DATE,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id)
);

-- 2. POPULATE DATA
-- =============================================================
TRUNCATE TABLE applications;
TRUNCATE TABLE jobs;
TRUNCATE TABLE candidates;

INSERT INTO candidates (full_name, primary_skill, years_experience, expected_salary) VALUES
('John Dev', 'Python', 2, 60000),
('Jane Data', 'SQL', 5, 85000),
('Mike Manager', 'Management', 10, 120000),
('Sarah Senior', 'Python', 8, 110000),
('Newbie Nick', 'SQL', 1, 40000);

INSERT INTO jobs (job_title, required_skill, min_experience, offered_salary) VALUES
('Jr Python Dev', 'Python', 1, 65000),
('Sr Data Analyst', 'SQL', 4, 90000),
('Tech Lead', 'Management', 8, 130000),
('Sr Python Dev', 'Python', 6, 115000);

INSERT INTO applications (job_id, candidate_id, app_date) VALUES
(1, 1, '2024-01-10'), -- John applies for Jr Python
(4, 1, '2024-01-11'), -- John applies for Sr Python (Unqualified?)
(2, 2, '2024-01-12'), -- Jane applies for Sr Analyst
(3, 3, '2024-01-15'), -- Mike applies for Tech Lead
(2, 5, '2024-01-20'), -- Nick applies for Sr Analyst (Unqualified?)
(4, 4, '2024-01-22'); -- Sarah applies for Sr Python


-- 3. PRACTICE QUESTIONS
-- =============================================================
-- 

-- Question 1: Your First CTE (Simple)
-- We want to analyze "Senior" candidates only.
-- Step 1: Create a CTE named 'Seniors' that selects candidates with > 4 years of experience.
-- Step 2: Select all columns from that CTE.
-- Hint: Start with "WITH Seniors AS (SELECT ... ) SELECT * FROM Seniors".

-- Question 2: CTE for Aggregation
-- We want to count how many applications each job has received.
-- Step 1: Create a CTE named 'AppCounts' that Groups By 'job_id' and counts applications.
-- Step 2: Join that CTE with the 'jobs' table to show the Job Title and the Count.
-- Hint: WITH AppCounts AS (...) SELECT ... FROM jobs JOIN AppCounts ON ...

-- Question 3: The "Perfect Match" Logic (Complex Filtering)
-- We want to find applications where the candidate is actually qualified.
-- Step 1: Create a CTE that joins Candidates, Jobs, and Applications.
-- Step 2: Filter the result to show only rows where (candidate_exp >= job_min_exp).
-- Hint: Do the heavy lifting (Joins) inside the CTE, then do the filtering in the main SELECT.

-- Question 4: Multiple CTEs (Chain of Logic)
-- We want to compare the Average Expected Salary of candidates vs Average Offered Salary of jobs.
-- Step 1: Create CTE 'AvgCand' (calculates avg expected salary).
-- Step 2: Create CTE 'AvgJob' (calculates avg offered salary).
-- Step 3: Select both values in the final query (using a cross join or comma).
-- Hint: WITH AvgCand AS (...), AvgJob AS (...) SELECT ...

-- Question 5: Creating a VIEW (Virtual Table)
-- We frequently need to see a "clean" list of applications with Names and Titles (no IDs).
-- Create a VIEW named 'view_application_details' that joins all three tables and selects:
-- Candidate Name, Job Title, App Date.
-- Hint: CREATE VIEW view_name AS SELECT ...

-- Question 6: Using a VIEW
-- Now that you created the view in Q5, write a simple query to find all applications for 'Python' jobs.
-- Hint: Treat the view exactly like a normal table. SELECT * FROM view_name WHERE ...

-- Question 7: CTE vs Subquery (Readability Challenge)
-- Find the name of the candidate with the highest expected salary.
-- Do this using a CTE to find the Max Salary first, then join/filter.
-- Hint: WITH MaxSal AS (SELECT MAX(...) ...) SELECT ... WHERE salary = (SELECT ... FROM MaxSal).

-- Question 8: Analyzing "Reach" Jobs (CTE)
-- A "Reach" job is when a candidate applies for a job that pays MORE than they expected.
-- Use a CTE to join the tables, and return the Candidate Name and the Difference (Offered - Expected).
-- Filter for where Offered > Expected.

-- Question 9: Recursive CTE Concept (Bonus/Intro)
-- (Just for fun/exposure, try this simple hierarchy logic)
-- We don't have a hierarchy table here, so let's generate numbers 1 to 5 using a Recursive CTE.
-- Hint: WITH RECURSIVE NumberGen AS (SELECT 1 UNION SELECT n+1 FROM NumberGen WHERE n<5) ...

-- Question 10: Dropping a View
-- We are done with the view from Q5. Remove it from the database.
-- Hint: DROP VIEW ...