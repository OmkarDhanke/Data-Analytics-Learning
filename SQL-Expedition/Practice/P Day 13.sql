-- =============================================================
-- DAY 13: REAL-WORLD ANALYTICS - Data Cleaning
-- Domain: Apex Solutions (CRM Migration)
-- Focus: String manipulation, Parsing, Deduplication, Formatting
-- =============================================================

-- 1. SETUP SCHEMA
-- =============================================================
CREATE DATABASE IF NOT EXISTS ApexSolutions_DB;
USE ApexSolutions_DB;

DROP TABLE IF EXISTS raw_leads;

CREATE TABLE raw_leads (
    lead_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(50),
    industry VARCHAR(50),
    signup_date VARCHAR(50) -- Notice this is a VARCHAR, not a DATE! (Very common in raw data)
);

-- 2. POPULATE THE "DIRTY" DATA
-- =============================================================
INSERT INTO raw_leads (full_name, email, phone_number, industry, signup_date) VALUES
('   john doe  ', 'JOHN.DOE@GMAIL.COM', '(555) 123-4567', 'tech', '2024-01-15'),
('Jane Smith', 'jane.smith@yahoo.com', '555-987-6543', ' Finance ', '2024/01/16'),
('michael scott', ' mscott@dunder.com ', '5551239999', 'Paper', '15-01-2024'),
('   john doe  ', 'JOHN.DOE@GMAIL.COM', '(555) 123-4567', 'tech', '2024-01-15'), -- Exact Duplicate
('Angela Martin', NULL, 'Ext 443', 'Accounting', '2024-02-01'), -- Missing email, bad phone
('Dwight K Schrute', 'beetfarmer@aol.com', '555.444.3333', ' agriculture', '2024-02-05'),
('jim HALPERT', 'jhalpert@dunder.com', NULL, 'Paper', '2024-02-06');


-- 3. THE BUSINESS REQUESTS (From your Marketing Manager)
-- =============================================================

-- Request 1: "Clean up the names for our email campaign."
-- Stakeholder Email: "Hey, I need a list of our leads to send an email blast. Can you give me a clean list of just their First Names? Also, some of the names have weird spaces and capitalization. Make sure the first letter is capitalized and the rest is lowercase (e.g., 'John', not '   john ' or 'JIM')."
-- Analytical Goal: Use TRIM, SUBSTRING_INDEX, UPPER, LOWER, and string concatenation.
SELECT
	concat(upper(left(SUBSTRING_INDEX(Trim(Full_Name),' ', 1), 1 )),
    Lower(substring(substring_index(Trim(Full_name),' ', 1),2))) as Name
FROM apexsolutions_db.raw_leads;


-- Request 2: "Standardize the emails and industries."
-- Stakeholder Email: "Our CRM needs all emails to be perfectly lowercase with no blank spaces around them. Also, the 'industry' column has random spaces and mixed casing. Can you make 'industry' properly capitalized (First letter only) and trim it?"
-- Analytical Goal: String standardizing using LOWER, TRIM, and combinations of LEFT/SUBSTRING.
SELECT
	Lower(Trim(email)) as  Mail,
	concat
		(upper(left(SUBSTRING_INDEX(Trim(industry),' ', 1), 1 )),
		Lower(substring(substring_index(Trim(industry),' ', 1),2))
        ) as Industry
FROM
	apexsolutions_db.raw_leads;

-- Request 3: "Find the duplicates."
-- Stakeholder Email: "I think the web form submitted some people twice. Can you write a query that identifies duplicate records based on the email address?"
-- Analytical Goal: Use GROUP BY and HAVING to find emails that appear more than once.
SELECT
	email,
    COUNT(email) as mail_count
FROM
	apexsolutions_db.raw_leads
GROUP BY email
HAVING mail_count > 1;

-- Request 4: "Remove the exact duplicates." (Advanced)
-- Stakeholder Email: "Okay, can you give me a master list of our leads with absolutely no exact duplicates? If John Doe is in there twice, I only want to see him once."
-- Analytical Goal: Use the ROW_NUMBER() window function partitioned by email/name to assign a 1 to the first instance and a 2 to the duplicate, then filter for only the 1s (using a CTE).
with dup as (
	SELECT
		lead_id,
		concat(upper(left(SUBSTRING_INDEX(Trim(Full_Name),' ', 1), 1 )),
    Lower(substring(substring_index(Trim(Full_name),' ', 1),2))) as Name,
    	Lower(Trim(email)) as  Mail,
	concat
		(upper(left(SUBSTRING_INDEX(Trim(industry),' ', 1), 1 )),
		Lower(substring(substring_index(Trim(industry),' ', 1),2))
        ) as Industry,
        REGEXP_REPLACE(phone_number,'[^0-9]', '') as phone_number,
        date_format(signup_date,'%Y-%m-%d') as signup_date,
        ROW_NUMBER() over(PARTITION BY email) as mail_count
	FROM
		apexsolutions_db.raw_leads
)
SELECT
	*
FROM dup
WHERE mail_count < 2;

-- Request 5: "Standardize the Phone Numbers." (Tough)
-- Stakeholder Email: "The phone numbers are a disaster. We have dashes, parentheses, dots, and some text. Can you strip out ALL characters so it's just a continuous string of numbers? E.g., '(555) 123-4567' becomes '5551234567'. If it doesn't look like a real 10-digit number after that, just leave it blank."
-- Analytical Goal: Use REPLACE() to nest multiple replacements (remove '(', ')', '-', '.', ' '). Then use a CASE statement with LENGTH() to NULL out the weird ones (like 'Ext 443').
SELECT
	CASE 
		WHEN LENGTH(REGEXP_REPLACE(phone_number,'[^0-9]', '')) = 10 
		THEN REGEXP_REPLACE(phone_number,'[^0-9]', '')
		ELSE NULL 
	END AS clean_phone
FROM
	apexsolutions_db.raw_leads;

-- Request 6: "Fix the Dates."
-- Stakeholder Email: "I tried to sort by signup date in Excel and it broke because the formats are all different (YYYY-MM-DD vs YYYY/MM/DD vs DD-MM-YYYY). Can you convert the 'signup_date' column into a proper SQL DATE format?"
-- Analytical Goal: Use STR_TO_DATE() combined with a CASE statement (using LIKE to identify the pattern) to parse the different string formats into a uniform DATE data type.
SELECT
	CASE
		WHEN signup_date LIKE '___/%/%' THEN str_to_date(signup_date, '%Y-%m-%D')
        WHEN signup_date LIKE '__-__-____' THEN str_to_date(signup_date, '%d-%m-%Y')
		ELSE str_to_date(signup_date, '%Y-%m-%d') 
END AS clean_signup_date
FROM 
	apexsolutions_db.raw_leads;