create DATABASE TimeDB;

use timedb;
-- =============================================================
-- DATASET SETUP: Logistics & Shipping Database
-- =============================================================
-- 1. Create Shipments Table
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,              -- The day the order was placed (No time)
    ShipmentTime DATETIME,       -- The exact moment it left the warehouse
    DeliveryTime DATETIME,       -- The exact moment it arrived
    Status VARCHAR(50)
);

-- 2. Create DriverShifts Table (For Time-based analysis)
CREATE TABLE DriverShifts (
    ShiftID INT PRIMARY KEY,
    DriverName VARCHAR(50),
    ShiftStart DATETIME,
    ShiftEnd DATETIME
);

-- 3. Insert Bulk Data (Covering 2023, 2024, 2025, Leap Years, End of Months)
INSERT INTO Shipments VALUES
(1001, 'Acme Corp', '2023-01-15', '2023-01-16 08:30:00', '2023-01-18 14:20:00', 'Delivered'),
(1002, 'Globex', '2023-02-28', '2023-02-28 23:45:00', '2023-03-02 10:00:00', 'Delivered'), -- End of Feb
(1003, 'Soylent', '2024-02-28', '2024-02-29 09:00:00', '2024-03-01 11:30:00', 'Delivered'), -- Leap Year Check
(1004, 'Initech', '2024-05-15', '2024-05-15 14:00:00', NULL, 'In Transit'),
(1005, 'Umbrella', '2024-08-20', '2024-08-20 18:55:45', '2024-08-22 09:15:00', 'Delivered'),
(1006, 'Stark Ind', '2024-10-31', '2024-11-01 08:00:00', '2024-11-03 16:45:00', 'Delivered'), -- Halloween/Month End
(1007, 'Wayne Ent', '2024-12-25', '2024-12-26 10:30:00', '2024-12-31 23:59:59', 'Delivered'), -- End of Year
(1008, 'Cyberdyne', '2025-01-01', '2025-01-01 00:01:00', NULL, 'Processing'), -- New Year
(1009, 'Massive D', '2025-02-14', '2025-02-14 12:00:00', NULL, 'Shipped'),
(1010, 'Hooli', '2025-03-15', '2025-03-16 06:30:00', '2025-03-18 08:00:00', 'Delivered'),
(1011, 'Pied Piper', '2025-04-01', '2025-04-01 09:00:00', '2025-04-05 17:00:00', 'Delivered'),
(1012, 'E Corp', '2025-08-20', '2025-08-20 22:30:00', NULL, 'Processing'),
(1013, 'Tyrell', '2025-09-30', '2025-10-01 08:15:00', '2025-10-03 12:00:00', 'Delivered'),
(1014, 'Wallace', '2025-11-20', '2025-11-21 14:45:00', NULL, 'Shipped'),
(1015, 'Dharma', '2025-12-31', '2026-01-02 09:00:00', NULL, 'Processing');

INSERT INTO DriverShifts VALUES
(1, 'John Doe', '2025-08-20 06:00:00', '2025-08-20 14:00:00'), -- Morning Shift
(2, 'Jane Smith', '2025-08-20 14:00:00', '2025-08-20 22:00:00'), -- Afternoon Shift
(3, 'Bob Brown', '2025-08-20 22:00:00', '2025-08-21 06:00:00'), -- Night Shift
(4, 'Alice White', '2025-08-21 09:00:00', '2025-08-21 17:00:00'),
(5, 'Charlie Black', '2025-12-24 18:00:00', '2025-12-25 02:00:00'); -- Holiday Shift

####################################################### Practice #######################################################
-- Sources of date and time
SELECT 	
	orderdate,
    '2025-02-13' as Hard_coded_date,
    curdate() as Show_Current_date,
    curtime() as Show_Current_time,
    now() As Both_time_and_date,
    current_timestamp() as time_and_date
FROM 
	timedb.shipments;

-- 1. Simple Extractors (YEAR, MONTH, DAY)
SELECT 	
	Year(ShiftStart) as Year,
    Month(ShiftStart) as Month,
    Day(ShiftStart) as Day,
    HOUR(ShiftStart) as Hour,
    minute(ShiftStart) as 'MIN',
    second(ShiftStart) as 'SEC'
From timedb.drivershifts;

-- 2. EXTRACT (The Flexible Extractor)
-- EXTRACT With Date
SELECT extract(Week from OrderDate) as week 
from timedb.shipments;

SELECT EXTRACT(quarter from OrderDate) as Quarter
from timedb.shipments;

SELECT EXTRACT(Month from OrderDate) as Month
from timedb.shipments;

-- EXTRACT With Time
SELECT EXTRACT(hour from DeliveryTime) as hour
from timedb.shipments;

SELECT EXTRACT(minute from DeliveryTime) as minute
from timedb.shipments;

SELECT EXTRACT(second from DeliveryTime) as second
from timedb.shipments;

-- 3. Name Extractors (MONTHNAME, DAYNAME)
SELECT monthname(orderdate) as Month
from shipments; 	

SELECT dayname(OrderDate) as Day 
from timedb.shipments;

SELECT monthname(orderdate) as Month,dayname(OrderDate) as Day 
from shipments; 	

-- 4. Date Formatting 
SELECT date_format(OrderDate, '%y-%m-%d') as Date
from timedb.shipments;

SELECT date_format(DeliveryTime, '%M-%d at %h:%i') as Date
from timedb.shipments;

-- Turn 2025-08-20 into "Aug 20th, 2025".
SELECT date_format(Orderdate, '%b %D, %Y') as Date
FROM timedb.shipments;

-- Reset a date to the first of the month (2025-08-01) so you can group data.
SELECT date_format(Orderdate, '%Y-%m-01') as date
FROM timedb.shipments;

-- Time Format
-- Turn 14:30:00 into "02:30 PM".
SELECT date_format(DeliveryTime, '%h:%i %p') as Time
FROM timedb.shipments;

SELECT Time_format(DeliveryTime, '%h:%i %p') as Time
FROM timedb.shipments;

-- A user-friendly timestamp: "Aug 20th, 2025 at 02:30 PM".

SELECT date_format(DeliveryTime, '%b %D, %Y at %h:%i %p') as Datetime
from timedb.shipments;
 
SELECT date_format(DeliveryTime, '%b-%D-%Y') as Datetime
from timedb.shipments;

-- 5. LAST_DAY (End of Month)
SELECT LAST_DAY(DeliveryTime)
from timedb.shipments;

-- Date_add
SELECT Orderdate,date_add(Orderdate, interval 1 month) as date,date_add(Orderdate, interval 1 year) as Year,
date_add(Orderdate, interval 1 day) as Day , date_add(Orderdate, interval  1 Week) as Week, date_add(Orderdate, interval 1 quarter) quarter
from timedb.shipments;

SELECT Orderdate,date_sub(Orderdate, interval 1 month) as date,date_add(Orderdate, interval 1 year) as Year,
date_sub(Orderdate, interval 1 day) as Day , date_sub(Orderdate, interval  1 Week) as Week, date_sub(Orderdate, interval 1 quarter) quarter
from timedb.shipments;

-- Datdiff
SELECT datediff(Now(),Orderdate) as Time
from timedb.shipments;

SELECT datediff(ShipmentTime,Orderdate) as Day,datediff(DeliveryTime,ShipmentTime) as Day2
FROM timedb.shipments;

-- Timestampdiff
SELECT Orderdate,timestampdiff(Month,Orderdate,Now()) as Time
from timedb.shipments;

SELECT timestampdiff(Year,'2004-06-17', NOW()) as age;

-- STR_TO_DATE
SELECT str_to_date('2 may 2022', '%Y-%M-%d') as 'Clean Date';
####################################################### Practice #######################################################
-- =============================================================
-- PRACTICE QUESTIONS (Baseind on Module: Date & Time Functions)
-- =============================================================

-- PART I: Simple Extractors (YEAR, MONTH, DAY)
-- =============================================================

-- Q1: Write a query to list the CustomerName and the exact Year the order was placed (using OrderDate).
SELECT CustomerName, Year(OrderDate) as Year
from timedb.shipments;

-- Q2: Write a query to find all Shipments that were placed in the Month of 'August' (Month 8), regardless of the year.
SELECT * FROM timedb.shipments
WHERE month(OrderDate) = 8;

-- Q3: Write a query to display the ShipmentID and the Day of the month (number) that the shipment left the warehouse (ShipmentTime)..
SELECT ShipmentID, Month(ShipmentTime) as Month
FROM timedb.shipments;

-- PART II: DATEPART (The Versatile Number)
-- =============================================================
-- Q4: Using the DriverShifts table, determine which Hour of the day each shift started.
SELECT hour(ShiftStart) as ShiftStart, hour(ShiftEnd) as ShiftEnd 
FROM timedb.drivershifts;

-- Q5: We need to analyze quarterly performance. Write a query to extract the Quarter (1-4) from the DeliveryTime in the Shipments table.
SELECT 
	extract(quarter from DeliveryTime) as Delivery_quarter
FROM timedb.shipments;

-- Q6: Find the Week of the Year (1-52) for every shipment that has a status of 'Delivered'.
SELECT *, week(orderdate) as Week from timedb.shipments
WHERE Status = 'Delivered';
-- PART III: DATENAME (The Human String)
-- =============================================================

-- Q7: Generate a report showing CustomerName and the full Name of the Month (e.g., 'January') the OrderDate occurred in.
SELECT CustomerName,monthname(OrderDate) as Month
from timedb.shipments
where monthname(OrderDate) = 'January';

-- Q8: We pay drivers more on weekends. Write a query to display the DriverName and the Day of the Week (e.g., 'Saturday', 'Monday') their shift started.
SELECT * from timedb.drivershifts
where dayname(ShiftStart) BETWEEN 'Saturday' and 'Monday';


-- Q9: Write a query to display the ShipmentID and the Month Name for the DeliveryTime. Ensure you handle rows where DeliveryTime is NULL (they won't appear or will show NULL).
SELECT shipmentID, month(DeliveryTime) as Month , monthname(DeliveryTime) M_name
FROM timedb.shipments
WHERE DeliveryTime is Not Null;

-- PART IV: DATETRUNC (Rolling up Dates)
-- =============================================================

-- Q10: We want to count shipments per month. Use DATETRUNC to round every OrderDate to the first day of its respective month (e.g., '2024-05-15' becomes '2024-05-01').
SELECT date_format(OrderDate, '%Y-%m-01') as date
FROM timedb.shipments;

-- Q11: (Advanced) Using the result from Q10, COUNT how many orders were placed in each truncated month.
SELECT date_format(OrderDate, '%Y-%m-01') as date, Count(*) as Order_count
FROM timedb.shipments
GROUP BY date;
-- Q12: For the DriverShifts table, use DATETRUNC to find the start of the Hour for every ShiftEnd time (ignoring minutes/seconds).

-- PART V: EOMONTH (End of Month Logic)
-- =============================================================
-- Q13: Financial reporting is due at the end of the month. Write a query that calculates the last day of the month for every OrderDate.
SELECT last_day(orderdate) as Last_day, COUNT(*) from timedb.shipments
GROUP BY Last_day;

-- Q14: A special promotion ends on the last day of the month a shipment was delivered. Find the EOMONTH for all DeliveryTime values.
SELECT last_day(orderdate) as last_day
from timedb.shipments;

-- PART VI: System Time & Filtering Best Practices
-- =============================================================

-- Q15: Write a query to select the current date and time of the system right now.
SELECT curdate() as Date_current , Curtime() as time_current;

-- Q16: Filter the Shipments table to show only orders placed in the Year 2024. Use the "Good/Performant" method (numeric comparison), not string conversion.
SELECT * from timedb.shipments
WHERE OrderDate >= '2024-01-01' and orderdate < '2025-01-01';

-- Q17: Filter the DriverShifts table to find shifts that started between 14:00 (2 PM) and 18:00 (6 PM). Hint: Use DATEPART(hour, ShiftStart).
SELECT * from timedb.drivershifts
WHERE hour(ShiftStart) BETWEEN 14 and 18;

SELECT (ShiftStart) as Hour from timedb.drivershifts;

SELECT extract(hour from ShiftStart) from timedb.drivershifts;

-- =============================================================
-- PRACTICE QUESTIONS: Date Arithmetic (MySQL Syntax)
-- Dataset: Shipments, DriverShifts
-- =============================================================

-- PART 1: Adding & Subtracting Time (DATE_ADD)
-- Q1: We promise a standard shipping time of 7 days. Write a query to display the OrderDate and a new column 'ExpectedDelivery' that adds 7 DAYS to the OrderDate.
SELECT orderdate, date_add(Orderdate, interval 7 day) as ExpectedDelivery
FROM timedb.shipments;

-- Q2: A customer wants to return an item. Valid returns must be initiated within 30 days of delivery. Add 30 DAYS to the DeliveryTime to show the 'ReturnDeadline'.
SELECT DeliveryTime, DATE_ADD(Orderdate, interval 30 day) as ReturnDeadline
FROM timedb.shipments;

-- Q3: We need to check the inventory status 2 months before an order was placed. Subtract 2 MONTHS from the OrderDate (using INTERVAL -2 MONTH).
SELECT date_sub(orderdate, interval 2 month) as sub_date
FROM timedb.shipments;
-- PART 2: Calculating Difference in Days (DATEDIFF)
-- Note: MySQL DATEDIFF is DATEDIFF(Date1, Date2) -> Returns Date1 - Date2

-- Q4: Calculate the "Order-to-Delivery" lead time in days. Calculate the difference between DeliveryTime and OrderDate.
SELECT ShipmentID,datediff(DeliveryTime,OrderDate) as 'Order-to-Delivery'
FROM timedb.shipments WHERE DeliveryTime is not null;

-- Q5: Find all shipments that took longer than 5 days to get delivered (from OrderDate to DeliveryTime).
SELECT ShipmentID,datediff(DeliveryTime,OrderDate) as 'Order-to-Delivery'
FROM timedb.shipments WHERE
datediff(DeliveryTime,OrderDate) > 5
and
DeliveryTime is not null;

-- PART 3: Calculating Difference in Other Units (TIMESTAMPDIFF)
-- Note: MySQL TIMESTAMPDIFF is TIMESTAMPDIFF(Unit, Start, End)
-- Q6: Calculate the exact duration of each driver's shift in HOURS. Use ShiftStart and ShiftEnd.
SELECT timestampdiff(hour,ShiftStart,ShiftEnd) as "driver's shift "
FROM timedb.drivershifts;

-- Q7: We need to know exactly how long items sit on the truck. Calculate the difference between ShipmentTime (leaving warehouse) and DeliveryTime (arrival) in MINUTES.
SELECT ShipmentID,timestampdiff(Minute,ShipmentTime,DeliveryTime) as 'Time'
FROM timedb.shipments WHERE DeliveryTime is not null;

-- Q8: For auditing purposes, calculate how many MONTHS have passed since the OrderDate compared to the current system time (NOW()).
SELECT *,timestampdiff(Day,Orderdate,NOW()) as 'Time'
FROM timedb.shipments 
WHERE Status = 'Delivered';