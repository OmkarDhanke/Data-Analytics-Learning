use practice;
-- Create the table
CREATE TABLE EmployeePerformance (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    RegionCode VARCHAR(5),
    PerformanceScore INT,
    ProjectsCompleted INT
);

-- Insert values
INSERT INTO EmployeePerformance (EmployeeID, FullName, Department, RegionCode, PerformanceScore, ProjectsCompleted)
VALUES(
(201, 'Anya Sharma', 'Sales', 'AS', 92, 12),
(202, 'Ben Carter', 'Support', 'NA', 78, 25),
(203, 'Chloe Davis', 'Engineering', 'EU', 85, 8),
(204, 'David Lee', 'Sales', 'NA', 65, 9),
(205, 'Eva Garcia', 'Support', 'EU', 95, 30),
(206, 'Frank Miller', 'Engineering', 'AS', 72, 6),
(207, 'Grace Hall', 'Sales', 'EU', 88, 11),
(208, 'Henry Ward', 'Support', 'AS', 61, 18),
(209, 'Isla Brooks', 'Engineering', 'NA', 98, 10),
(210, 'Jack Evans', 'Sales', 'AS', 45, 5),
(211, 'Kim Chen', 'Support', 'NA', 82, 22),
(212, 'Leo Martin', 'Engineering', 'EU', 59, 4),
(213, 'Mia Scott', 'Sales', 'EU', 99, 15),
(214, 'Noah Wright', 'Support', 'AS', 75, 28),
(215, 'Olivia King', 'Engineering', 'NA', 91, 9),
(216, 'Paul Adams', 'Sales', 'NA', 87, 13),
(217, 'Riya Mehta', 'Support', 'EU', 93, 27),
(218, 'Sam Wilson', 'Engineering', 'AS', 78, 7),
(219, 'Tina Brown', 'Sales', 'EU', 81, 10),
(220, 'Uma Patel', 'Support', 'AS', 69, 16),
(221, 'Victor Hughes', 'Engineering', 'NA', 84, 12),
(222, 'Wendy Flores', 'Sales', 'AS', 90, 14),
(223, 'Xavier Lopez', 'Support', 'EU', 58, 9),
(224, 'Yara Singh', 'Engineering', 'EU', 96, 11),
(225, 'Zack Turner', 'Sales', 'NA', 73, 8),
(226, 'Aarav Nair', 'Support', 'AS', 88, 20),
(227, 'Bella Clark', 'Engineering', 'NA', 67, 5),
(228, 'Carlos Gomez', 'Sales', 'EU', 94, 18),
(229, 'Diana Reed', 'Support', 'NA', 76, 24),
(230, 'Ethan Lewis', 'Engineering', 'AS', 62, 6));

SELECT * from EmployeePerformance;
-- The Searched CASE Statement
SELECT FullName,
Department,
	CASE 
		WHEN RegionCode = 'NA' THEN 'North America' 
        WHEN RegionCode = 'EU' THEN 'Europe'
        WHEN RegionCode = 'AS' THEN 'Asia'
	END AS WorkingRegion 
FROM employeeperformance ;

-- The Simple CASE Statement
SELECT FullName,
Department,
	CASE  RegionCode
		WHEN 'NA' THEN 'North America' 
        WHEN 'EU' THEN 'Europe'
        WHEN 'AS' THEN 'Asia'
	ELSE 'None'
	END AS WorkingRegion 
FROM employeeperformance ;

-- Using CASE with Aggregate Functions
SELECT 
    SUM(CASE WHEN PerformanceScore >= 90 THEN 1 ELSE 0 END) AS High_Performers,
    SUM(CASE WHEN PerformanceScore BETWEEN 70 AND 89 THEN 1 ELSE 0 END) AS Medium_Performers,
    SUM(CASE WHEN PerformanceScore < 70 THEN 1 ELSE 0 END) AS Low_Performers
FROM employeeperformance;

SELECT 
    RegionCode,
    AVG(CASE WHEN Department = 'Sales' THEN PerformanceScore END) AS Avg_Sales_Score,
    AVG(CASE WHEN Department <> 'Sales' THEN PerformanceScore END) AS Avg_NonSales_Score
FROM employeeperformance
GROUP BY RegionCode;

SELECT 
    SUM(CASE WHEN PerformanceScore >= 90 THEN ProjectsCompleted ELSE 0 END) AS Projects_High,
    SUM(CASE WHEN PerformanceScore BETWEEN 70 AND 89 THEN ProjectsCompleted ELSE 0 END) AS Projects_Medium,
    SUM(CASE WHEN PerformanceScore < 70 THEN ProjectsCompleted ELSE 0 END) AS Projects_Low
FROM employeeperformance;


-- Beginner (Q1–Q8) - Basic CASE Statements
-- Q1: Show FullName, RegionCode, and RegionName ('North America' for 'NA', 'Europe' for 'EU', 'Asia' for 'AS').
SELECT FullName, RegionCode,
	CASE RegionCode
		WHEN 'NA' THEN 'North America'
        WHEN 'EU' THEN 'Europ'
        WHEN 'AS' THEN 'Asia'
	END AS RegionName
FROM employeeperformance;

-- Q2: Show FullName, PerformanceScore, and PerformanceCategory ('Excellent' >90, 'Good' >70, 'Needs Improvement' <=70).
SELECT FullName, PerformanceScore,
	CASE 
		WHEN PerformanceScore > 90 THEN 'Excellent'
        WHEN PerformanceScore > 70 THEN 'Good' 
        WHEN PerformanceScore <= 70 THEN 'Needs Improvement'
	END AS PerformanceCategory
FROM employeeperformance;

-- Q3: Create BonusEligible column ('Yes' if PerformanceScore >80, else 'No').
SELECT FullName, PerformanceScore,
	CASE 
		When PerformanceScore > 80 THEN 'Yes'
        ELSE 'No'
	END AS BonusEligible
FROM employeeperformance;

-- Q4: Show FullName, Department, and DepartmentType ('Client-Facing' for Sales/Support, 'Technical' for Engineering).
SELECT EmployeeID,FullName, Department,
	CASE 
		WHEN Department IN ('Sales','Support') Then 'Client-Facing'
        WHEN Department = 'Engineering' THEN 'Technical'
	END AS DepartmentType
FROM employeeperformance;

-- Q5: Categorize employees by ProjectsCompleted into Workload ('High' >20, 'Medium' 10–20, 'Low' <10).
SELECT FullName,ProjectsCompleted,
	CASE
		WHEN ProjectsCompleted > 20 THEN 'High'
        WHEN ProjectsCompleted BETWEEN 10 and 20 THEN 'Medium' 
        WHEN ProjectsCompleted < 10 THEN 'Low'
	END AS Performance
FROM employeeperformance;

-- Q6: Create HighImpact flag ('True' if Department='Sales' AND PerformanceScore>90, else 'False').
SELECT FullName,Department,PerformanceScore,
	CASE
		WHEN Department = 'Sales' AND PerformanceScore > 90 THEN 'True'
        ELSE 'FALSE'
	END AS HighImpact_flag
FROM employeeperformance;

-- Q7: Show FullName of employees with PerformanceScore<60 and add ReviewPriority='High Priority'.
SELECT FullName,
	CASE 
		WHEN PerformanceScore < 60 Then 'High Priority'
        ELSE 'Normal'
	END AS ReviewPriority
From employeeperformance;

-- Q8: Show FullName, RegionCode, and IsDomestic ('USA' if RegionCode='NA', else 'International').
SELECT FullName, RegionCode,
	CASE RegionCode
		WHEN 'NA' Then 'USA'
        ELSE 'International'
	END AS IsDomestic
FROM employeeperformance;

-- Intermediate (Q9–Q17) - CASE with Aggregate Functions
-- Q9: Count employees in each PerformanceCategory ('Excellent','Good','Needs Improvement').
SELECT 
	COUNT(Case WHEN PerformanceScore > 80 THEN 1 END) as 'Excellent',
    COUNT(CASE WHEN PerformanceScore > 60 AND PerformanceScore <= 80 Then 1 END) as 'Good',
    COUNT(CASE WHEN PerformanceScore <= 60 THEN 1 END) as 'Needs Improvement'
From employeeperformance;

-- Q10: Return one row with Sales_Count, Support_Count, Engineering_Count (employees in each department).
SELECT 
	COUNT(CASE WHEN Department = 'Sales' THEN 1  END) as Sales_Count,
    COUNT(CASE WHEN Department = 'Support' THEN 1 END) as Sales_Count,
    COUNT(CASE WHEN Department = 'Engineering' THEN 1 END) as Sales_Count
FROM employeeperformance;

-- Q11: Calculate sum of ProjectsCompleted for 'NA' vs. 'Other' regions.
SELECT 
	SUM(CASE WHEN RegionCode = 'NA' THEN ProjectsCompleted ELSE 0 END) as NA,
    SUM(CASE WHEN RegionCode IN ('EU','AS') THEN ProjectsCompleted ELSE 0 END) as Other
from employeeperformance;

-- Q12: Calculate average PerformanceScore for Sales vs. non-Sales employees.
SELECT
	round(AVG(CASE WHEN Department = 'Sales' THEN PerformanceScore END), 2) as Avg_Performace_sales,
    round(AVG(CASE WHEN Department != 'Sales' THEN PerformanceScore END), 2) as Avg_Performance_non_sales
from practice.employeeperformance;

-- Q13: Group by Department and show number of 'Excellent' performers (PerformanceScore>90).
SELECT Department,
	COUNT(CASE WHEN PerformanceScore > 90 THEN 1 END) as 'Excellent'
FROM employeeperformance
GROUP BY Department;

-- Q14: For each region, find average PerformanceScore of employees with ProjectsCompleted>10.
SELECT RegionCode,
	ROUND(AVG(CASE WHEN ProjectsCompleted > 10 THEN PerformanceScore END), 2) as Avg_Performance
FROM employeeperformance
GROUP BY RegionCode;

-- Q15: For each Department, count employees with score>80 and score<=80.
SELECT Department,
	COUNT(CASE WHEN PerformanceScore > 80 THEN 1 END) as Above_avg,
    COUNT(CASE WHEN PerformanceScore <= 80 THEN 1 END) as Avg_employees
FROM employeeperformance
GROUP BY Department;

-- Q16: Calculate total ProjectsCompleted by employees from 'EU' vs. not from 'EU'.
SELECT 
	SUM(CASE WHEN RegionCode = 'EU' THEN ProjectsCompleted ELSE 0 END) as EU_Project,
    SUM(CASE WHEN RegionCode != 'EU' THEN ProjectsCompleted ELSE 0 END) as Other_Project
FROM employeeperformance;

-- Q17: Count employees whose FullName starts with A–M vs. N–Z into A_to_M_Count and N_to_Z_Count.
SELECT 
	COUNT(CASE WHEN left(FullName , 1) BETWEEN 'A' and 'M' THEN 1 END) as A_to_M_Count,
    COUNT(CASE WHEN left(FullName , 1) BETWEEN 'N' and 'Z' THEN 1 END) as N_to_Z_Count
FROM employeeperformance;

-- Advanced (Q18–Q25) - Complex Conditional Logic
-- Q18: List all employees ordered by Department ('Sales','Support','Engineering') then PerformanceScore desc.
SELECT FullName,Department,PerformanceScore FROM employeeperformance
ORDER BY 
		CASE Department
			WHEN 'Sales' THEN 1 
            WHEN 'Support' THEN 2
            When 'Engineering' THEN 3
		END,
	PerformanceScore DESC;
	
-- Q19: Show departments where count of employees with PerformanceScore<=70 ('Needs Improvement') is >=2.
SELECT Department FROM employeeperformance
GROUP BY Department
HAVING COUNT(CASE WHEN PerformanceScore <= 70 THEN 1 end) >=2;

-- Q20: Create ProjectBonus column (Sales=Projects*100, Support=Projects*50, Engineering=Projects*200).
SELECT FullName,Department,ProjectsCompleted,
CASE 
	WHEN Department = 'Sales' THEN ProjectsCompleted * 100
    WHEN Department = 'Support' THEN ProjectsCompleted * 50
    WHEN Department = 'Engineering' THEN ProjectsCompleted * 200
END as ProjectBonus
FROM employeeperformance;

-- Q21: Pivot data to show each Department as a row with employee counts in 'NA','EU','AS' columns.
SELECT Department,
	COUNT(CASE WHEN RegionCode = 'NA' then 1 end) as NA_count,
	COUNT(CASE WHEN RegionCode = 'EU' then 1 end) as EU_count,
    COUNT(CASE WHEN RegionCode = 'AS' then 1 end) as AS_count,
    COUNT(*) as Department_total
FROM employeeperformance
GROUP BY Department
ORDER BY Department;

-- Q22: Create PerformanceAndProjectRank ('Top Tier' if score>80 AND projects>10, 'Mid Tier' if either, else 'Standard Tier').
SELECT FullName,PerformanceScore,ProjectsCompleted,
	CASE 
		WHEN PerformanceScore > 80 and PerformanceScore > 10 THEN 'Top Tier'
        WHEN PerformanceScore > 80 or PerformanceScore > 10 THEN 'Mid Tier'
        ELSE 'Standard Tier'
	END as PerformanceAndProjectRank
FROM employeeperformance
ORDER BY
    PerformanceScore DESC, ProjectsCompleted DESC;
    
-- Q23: Calculate weighted ProjectsCompleted (NA=1, EU=1.5, AS=2) per Department.
SELECT Department,
	SUM(
		CASE RegionCode
			WHEN 'NA' Then ProjectsCompleted * 1
            WHEN 'EU' THEN ProjectsCompleted * 1.5
            WHEN 'AS' THEN ProjectsCompleted * 2
            ELSE 0.0
		END 
		)As weighted_ProjectsCompleted
FROM employeeperformance
GROUP BY Department; 

-- Q24: Find departments where avg score of employees with <10 projects is greater than avg score of those with >=10.
SELECT
    Department,
    -- Calculate Avg Score for employees with < 10 Projects
    AVG(CASE WHEN ProjectsCompleted < 10 THEN PerformanceScore END) AS Avg_LowProjects_Score,
    -- Calculate Avg Score for employees with >= 10 Projects
    AVG(CASE WHEN ProjectsCompleted >= 10 THEN PerformanceScore END) AS Avg_HighProjects_Score
FROM
    employeeperformance
GROUP BY
    Department
HAVING
    -- Filter groups where the Low Projects Avg is greater than the High Projects Avg
    AVG(CASE WHEN ProjectsCompleted < 10 THEN PerformanceScore END)
    >
    AVG(CASE WHEN ProjectsCompleted >= 10 THEN PerformanceScore END);
    
-- Q25: Identify employees needing improvement plan (Yes if Sales/Support score<70 OR Engineering score<60 AND projects<5, else No).
SELECT
    FullName,
    Department,
    PerformanceScore,
    ProjectsCompleted,
    CASE
        -- Condition 1: Sales/Support with low score
        WHEN Department IN ('Sales', 'Support') AND PerformanceScore < 70 THEN 'Yes'

        -- Condition 2: Engineering with very low score AND very few projects
        WHEN Department = 'Engineering' AND PerformanceScore < 60 AND ProjectsCompleted < 5 THEN 'Yes'

        -- Default Case: Everyone else is 'No'
        ELSE 'No'
    END AS NeedsImprovementPlan
FROM
    employeeperformance;
