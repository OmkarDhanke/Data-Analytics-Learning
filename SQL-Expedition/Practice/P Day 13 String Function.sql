CREATE DATABASE Data;

USE Data;

-- 1. Create the Table
CREATE TABLE Messy_CRM_Data (
    LeadID INT PRIMARY KEY,
    FirstName VARCHAR(100),   -- Contains messy casing: 'joHN', '  ALICE '
    LastName VARCHAR(100),    -- Contains messy casing
    Email VARCHAR(150),       -- Contains mixed domains and NULLs
    PhoneNumber VARCHAR(50),  -- Contains dashes, dots, parentheses: '123-456', '(123) 456'
    JoinDate_Text VARCHAR(20),-- DATES STORED AS TEXT (e.g. '2023-01-15') - Nightmare scenario!
    PurchaseAmount VARCHAR(20),-- NUMBERS STORED AS TEXT (e.g. '150.00')
    LastLoginDate DATE        -- Real Date format (contains NULLs)
);

-- 2. Insert Dirty Data
INSERT INTO Messy_data VALUES
(1, '  john ', 'DOE', 'john.doe@gmail.com', '123-456-7890', '2022-01-15', '1500.50', '2025-01-01'),
(2, 'Sarah', 'sMITH', 'sarah.smith@yahoo.com', '(555) 987-6543', '2023-06-20', '200.00', '2024-12-15'),
(3, 'mIKE', 'brown', NULL, '444.555.6666', '2021-11-05', '50.00', NULL),
(4, 'Emily', '   White', 'emily.w@company.net', NULL, '2024-02-14', '0', '2025-01-20'),
(5, 'DAVID', 'Lee', 'david.lee@gmail.com', '111-222-3333', '2023-09-10', '999.99', '2024-11-30'),
(6, '  Jessica', 'Davis', NULL, 'N/A', '2022-05-05', NULL, NULL),
(7, 'robert', 'miller', 'robert.m@outlook.com', '777-888-9999', '2020-12-25', '12500', '2023-01-01'),
(8, 'Linda', 'Wilson', 'linda.wilson@tech.io', '(321) 654-0987', '2024-01-01', '300.50', '2025-02-10'),
(9, 'JAMES', 'moore', 'james.moore@gmail.com', '555-000-1111', '2023-03-15', '75.25', '2024-10-20'),
(10, 'William', 'Taylor  ', NULL, NULL, '2022-08-08', '500', NULL),
(11, 'Barbra', 'Streisand', 'babs@music.com', '555-123-4567', '2021-01-20', '25000.00', '2025-01-15'),
(12, 'tom', 'hanks', 'tom@castaway.com', '999.888.7777', '2020-01-10', '100', '2022-05-20'),
(13, '   Julia', 'Roberts', 'j.roberts@movie.org', NULL, '2023-12-01', NULL, '2025-02-18'),
(14, 'chris', 'EVANS', 'cap@marvel.com', '123-123-1234', '2019-07-04', '50.00', '2023-07-04'),
(15, 'Tony', 'Stark', 'ironman@stark.net', NULL, '2018-05-02', '1000000', '2025-02-20');

SELECT * FROM data.Messy_Data;
################################################### Practice ###################################################
# Sring Function
-- Manipulation 
-- CONCAT
SELECT CONCAT(Firstname,' ',Lastname) AS Fullname FROM data.Messy_data;

-- Lower & Upper
SELECT 
	UPPER(Firstname) AS FirstName ,
    LOWER(Lastname) AS LAstname
FROM 
	data.messy_data;
    
-- Trim
SELECT TRIM(Firstname) AS Trim_Name FROM data.messy_data;

SELECT Trim(lastname) as lastname from data.messy_data;

SELECT firstname , length(Firstname) Len,
	length(trim(firstname)) as trim_len,
    length(Firstname)  -
	length(trim(firstname)) as len
FROM data.messy_data;

-- REPLACE
SELECT replace(PhoneNumber,'-','') as CleanNumber
from data.messy_data;

-- nested rplace
SELECT 
	replace(
		replace(
			replace(
				replace
					(PhoneNumber,'-',''),'(',''),'.',''),')','') as Clean_Number
FROM data.messy_data;

-- Calculation 
-- LEN
SELECT length(FirstName) as Name_Len 
FROM data.messy_data
where length(FirstName) > 5;

-- LEFT
SELECT 
Firstname,
left(Firstname, 3) as First_3_chr
from data.messy_data;

SELECT 
lastname,
right(Lastname, 3) as Last_3_chr 
from data.messy_data;
 SELECT lpad(LeadID,3,0) as ID From data.messy_data;
 
 -- SUBSTRING
 SELECT email,substring(Email,4,length(email)) as email from data.messy_data;
 
 SELECT substring(trim(Firstname),2,6) as name from data.messy_data;
 
 -- Substring Index
 
SELECT email,substring_index(email,'.',1) as Left_, substring_index(email,'.',-2) as RIGHT_ from data.messy_data;
 
SELECT email,substring_index(email,'@',1) as Left_, substring_index(email,'@',-1) as RIGHT_ from data.messy_data;


 
################################################### Practice ###################################################
-- =============================================
-- 20 STRING FUNCTION PRACTICE QUESTIONS
-- Table: Messy_CRM_Data
-- =============================================

-- 1. CONCAT: Write a query to create a column 'ContactInfo' that reads: "Firstname Lastname - Email" (e.g., "John Doe - john@gmail.com").
SELECT concat(concat(Lower(Trim(FirstName)),' ',Lower(Trim(Lastname))),' - ',Email) as Contact_Info
FROM data.messy_data
where email is Not null;

-- 2. UPPER/LOWER: Display the FirstName in all lowercase and the LastName in all uppercase.
SELECT lower(Firstname) as Lower_name , upper(Lastname) as Upper_Lastname
FROM data.messy_data;

-- 3. TRIM: Write a query to select the FirstName, but remove all leading and trailing spaces.
SELECT trim(Firstname)  as Clear_name 
from data.messy_data;

-- 4. LENGTH Calculation: Find out how many extra spaces are in the 'FirstName' column by calculating (Original Length - Trimmed Length).
SELECT length(Firstname) - length(Trim(Firstname)) as Extra_space
from data.messy_data
WHERE length(Firstname) - length(Trim(Firstname)) > 0;

-- 5. REPLACE (Basic): The 'PhoneNumber' column has dashes ('-'). Replace all dashes with spaces.
SELECT replace(PhoneNumber,'-','') as PhoneNumber
FROM data.messy_data;
-- 6. REPLACE (Nested): The 'PhoneNumber' contains '(', ')', '.', and '-'. Write a nested replace to remove ALL these characters so only numbers remain.
SELECT 
	replace(
		replace(
			replace(
				replace
					(PhoneNumber,'-',''),'(',''),'.',''),')','') as Clean_Number
FROM data.messy_data
WHERE PhoneNumber is NOT NULL and PhoneNumber != 'N/A';

-- 7. LEFT: Extract the first 3 characters of the 'PhoneNumber' (representing the Area Code).
SELECT left(replace(PhoneNumber,'(',''),3) as Area_code 
from data.messy_data;

-- 8. RIGHT: Extract the last 4 characters of the 'PhoneNumber'.
SELECT right(replace(PhoneNumber,'-',''),4) as Area_code 
from data.messy_data;

-- 9. LPAD: The 'LeadID' is a single digit (e.g., 1, 2). Display it as a 5-digit code padded with zeros (e.g., '00001').
SELECT lpad(LeadID,5,0) as Padded_id
from data.messy_data;

-- 10. SUBSTRING (Fixed): The 'JoinDate_Text' is stored as 'YYYY-MM-DD'. Use SUBSTRING to extract just the Year (first 4 characters).
SELECT substring(JoinDate_Text,1,4) as Year
FROM data.messy_data;

-- 11. SUBSTRING (Position): Extract the text from the 'Email' column starting from the 3rd character onwards.
SELECT substring(Email,3,length(Email)) as Mail
from data.messy_data;

-- 12. SUBSTRING_INDEX (Domain): Extract only the domain name (everything to the right of '@') from the 'Email' column.
SELECT substring_index(Email,'@',-1) as Domain
from data.messy_data
WHERE Email IS NOT NULL;

-- 13. SUBSTRING_INDEX (Username): Extract only the username (everything to the left of '@') from the 'Email' column.
SELECT substring_index(Email,'@',1) as Username
from data.messy_data
WHERE Email IS NOT NULL;

-- 14. CONCAT + SUBSTRING (Initials): Generate the user's initials (First letter of FirstName + First letter of LastName).
SELECT concat(substring(Firstname,1,1),'',substring(LAstname,1,1)) as Initials
from data.messy_data;

-- 15. REVERSE (or Logic): Find the First Name, then display the First Name spelled backwards (if your SQL supports REVERSE, otherwise skip).
SELECT reverse(Trim(Lower(Firstname))) as Rev_name
from data.messy_data;

-- 16. MASKING (Left/Right/Concat): Create a 'MaskedPhone' column that shows 'XXX-XXX-' followed by the last 4 digits of the phone number.
SELECT PhoneNumber,
concat('XXX-XXX-',Right(PhoneNumber,4)) as MaskedPhone
from data.messy_data;

-- 17. SUBSTRING (Middle): The 'JoinDate_Text' is 'YYYY-MM-DD'. Extract just the Month (characters 6 and 7).
SELECT substring(JoinDate_Text,6,2	) as Month 
from data.messy_data;

-- 18. PROPER CASE CHALLENGE: Convert the 'FirstName' so the first letter is Uppercase and the rest are Lowercase (e.g., turns 'joHN' into 'John').
--     (Hint: Combine CONCAT, UPPER, LEFT, LOWER, and SUBSTRING).
SELECT 
    CONCAT(
        TRIM(UPPER(LEFT(Firstname, 1))), 
        TRIM(SUBSTRING(LOWER(Firstname), 2))
    ) AS ProperCase
FROM data.messy_data;

-- 19. LENGTH Filter: Find all employees whose Trimmed FirstName is longer than 5 characters.
SELECT Trim(Firstname) as Trimname
from data.messy_data
WHERE length(Firstname) - length(Trim(Firstname)) > 4;

SELECT Trim(Firstname) as Trimname
from data.messy_data
WHERE length(Trim(Firstname)) > 5;

-- 20. Hard Cleaning: Trim the FirstName, UpperCase it, and then concat it with the LastName (Trimmed and Lowercased).
SELECT concat(Upper(Trim(FirstName)),' ',Lower(Trim(Lastname))) as Contact_Info
FROM data.messy_data
where email is Not null;
