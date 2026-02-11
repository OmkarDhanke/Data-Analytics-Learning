-- =============================================================
-- FIX: GRAND HOTEL SCHEMA (Clean Slate)
-- =============================================================

CREATE DATABASE IF NOT EXISTS GrandHotel_DB;
USE GrandHotel_DB;

-- 1. CREATE TABLES (In Strict Dependency Order)
-- =============================================================

-- Level 1: Independent Tables (Create these first)
CREATE TABLE guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    vip_status BOOLEAN DEFAULT 0
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number INT,
    type VARCHAR(20),
    price_per_night DECIMAL(10,2),
    floor INT
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50),
    salary INT,
    manager_id INT
);

-- Level 2: Dependent Tables (Must be created AFTER Level 1)
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    status VARCHAR(20),
    -- These links will fail if 'guests' or 'rooms' don't exist yet
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Level 3: Highly Dependent Tables (Must be created AFTER Level 2)
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    method VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- 3. INSERT DATA (Run this ONLY after tables are created)
-- =============================================================

-- Guests
INSERT INTO guests (first_name, last_name, email, city, vip_status) VALUES
('John', 'Wick', 'john@continental.com', 'New York', 1),
('Sarah', 'Connor', 'sarah@resistance.org', 'Los Angeles', 0),
('James', 'Bond', '007@mi6.gov', 'London', 1),
('Bruce', 'Wayne', 'batman@gotham.com', 'Gotham', 1),
('Peter', 'Parker', 'spidey@queens.com', 'New York', 0);

-- Rooms
INSERT INTO rooms (room_number, type, price_per_night, floor) VALUES
(101, 'Standard', 150.00, 1),
(102, 'Standard', 150.00, 1),
(201, 'Deluxe', 300.00, 2),
(301, 'Suite', 800.00, 3),
(404, 'Standard', 100.00, 4); 

-- Staff 
INSERT INTO staff (name, role, salary, manager_id) VALUES
('Alice', 'General Manager', 90000, NULL),
('Bob', 'Receptionist', 40000, 1),
('Charlie', 'Concierge', 45000, 1),
('Dave', 'Intern', 25000, 2); 

-- Bookings
INSERT INTO bookings (guest_id, room_id, check_in_date, check_out_date, status) VALUES
(1, 4, '2024-05-01', '2024-05-05', 'Completed'), -- Note: Using ID 4 (Suite) not room number 301
(2, 1, '2024-06-01', '2024-06-03', 'Confirmed'), 
(3, 3, '2024-06-10', '2024-06-15', 'Cancelled'), 
(4, 4, '2024-07-01', '2024-07-02', 'Confirmed'), 
(5, 2, '2024-05-10', '2024-05-11', 'Completed'); 

-- Payments
INSERT INTO payments (booking_id, amount, payment_date, method) VALUES
(1, 3200.00, '2024-05-05', 'Card'),
(2, 300.00, '2024-06-01', 'Cash'),
(4, 800.00, '2024-07-01', 'Transfer'),
(5, 150.00, '2024-05-11', 'Card');
-- Note: Booking 3 (Bond) has no payment because it was cancelled.


-- 3. THE 30-QUESTION CHALLENGE
-- =============================================================

-- ==========================================
-- LEVEL 1: REFRESHER (Days 1-3)
-- Topics: Select, Filter, Sort, Aggregate
-- ==========================================

-- Q1: List all guests who live in 'New York'.
SELECT * FROM grandhotel_db.guests;

-- Q2: Find all rooms that are 'Standard' type AND cost less than $200.
SELECT	
	room_number
FROM
	grandhotel_db.rooms
WHERE
	type = 'Standard' and price_per_night < 200;
    
-- Q3: Find all staff members whose name starts with 'C' (Pattern Matching).
SELECT
	name
    
FROM
	grandhotel_db.staff
WHERE
	name LIKE "C%";
    
-- Q4: Count how many 'Suite' type rooms we have in the hotel.
SELECT
	COUNT(*) as Suite_RoomCount
FROM
	grandhotel_db.rooms
WHERE
	type = "Suite";
    
-- Q5: What is the average price of a room? (Round to 2 decimals).
SELECT
	Type,
	round(avg(price_per_night),2) as avg_price_per_room
FROM
	grandhotel_db.rooms
GROUP BY Type;

-- Q6: List all unique cities where our guests come from.
SELECT
	DISTINCT city
FROM
	grandhotel_db.guests;
    
-- Q7: Find the most expensive room price in the hotel (MAX).
SELECT
	Type as RoomType,
    MAX(price_per_night) as expensive_room
FROM
	grandhotel_db.rooms
GROUP BY type
ORDER BY expensive_room DESC
LIMIT 1;

-- Q8: Calculate the total revenue from all payments made by 'Card'.
SELECT
	concat('$',' ', SUM(amount)) as Total_revenue_By_Card
FROM	
	grandhotel_db.payments
WHERE 
	method = 'Card';
    
-- Q9: List the Guests (First Name) sorted by their Last Name (A-Z).
SELECT
	first_name
FROM
	grandhotel_db.guests
ORDER BY last_name ASC;

-- Q10: Count how many bookings exist for each status ('Confirmed', 'Completed', etc.).
SELECT
	status,
    COUNT(*) as Total_Booking
FROM
	grandhotel_db.bookings
GROUP BY status;

-- ==========================================
-- LEVEL 2: INTERMEDIATE (Days 4-6)
-- Topics: Joins, Subqueries, Logic
-- ==========================================

-- Q11: (Inner Join) List Booking IDs and the name of the Guest who made them.
SELECT
	b.booking_id,
    g.first_name
FROM
	grandhotel_db.bookings as b
	LEFT JOIN guests As g
    ON b.guest_id = g.guest_id;
    
-- Q12: (Left Join) List all Room Numbers and the Guest Name if booked. Include rooms that have NEVER been booked (NULLs).
SELECT
	r.room_number,
    g.first_name
FROM
	grandhotel_db.bookings b
    LEFT JOIN rooms r
    ON b.room_id = r.room_id
    LEFT JOIN guests g
    ON b.guest_id = g.guest_id;
    
-- Q13: (Calculation) Calculate total Booking Cost for Booking ID 1. (Hint: DATEDIFF(checkout, checkin) * Room_Price).
SELECT
	datediff(b.check_out_date,b.check_in_date) * r.price_per_night as Total_Cost
FROM grandhotel_db.bookings b
LEFT JOIN rooms r
on b.room_id = r.room_id
WHERE booking_id = 1;

-- Q14: (Subquery) Find the details of the room that has the lowest price in the entire hotel.
SELECT * 
FROM 
	grandhotel_db.rooms
WHERE 
	price_per_night = 
					(
						SELECT Min(price_per_night) 
                        FROM grandhotel_db.rooms
					);
                    
-- Q15: (Subquery IN) Find names of guests who have made a booking for a 'Suite'.
SELECT
	*
FROM
	grandhotel_db.guests
WHERE
	guest_id IN (
					SELECT 
						guest_id
                    FROM 
						grandhotel_db.bookings 
                    WHERE 
						room_id =
								(
									SELECT 
										room_id
									FROM 
										grandhotel_db.rooms
									WHERE
										type = 'Suite'
								)
                );
	
-- Q16: (NOT IN) Find guests who have registered but NEVER made a booking. (Hint: No guests fit this currently, insert one to test if you want!).
SELECT
	*
FROM
	grandhotel_db.guests
WHERE
	guest_id NOT IN 
					(
					SELECT 
						guest_id
                    FROM 
						grandhotel_db.bookings 
					);
                    
-- Q17: (Case) List Room Numbers and a 'Category' column: 'Luxury' if price > 500, else 'Regular'.
SELECT	
	room_number,
    CASE
		WHEN price_per_night > 500 THEN 'Luxury'
        ELSE 'Regular'
	END as Category
FROM
	grandhotel_db.rooms;
    
-- Q18: (Conditional Aggregation) Count the number of 'VIP' vs 'Non-VIP' guests in a single row.
SELECT
	COUNT(CASE WHEN vip_status = 1 THEN 1 END) as VIP,
    COUNT(CASE When	vip_status = 0 THEN 1 END) as 'Non-VIP'
FROM
	grandhotel_db.guests;
    
-- Q19: (Join + Filter) Find the total amount paid by Guest 'John Wick'.
SELECT
	g.first_name,
    p.amount
FROM
	grandhotel_db.bookings b 
    LEFT JOIN guests g
    ON b.guest_id = g.guest_id
    LEFT JOIN payments p
    ON b.booking_id = p.booking_id
WHERE
	first_name = 'John';
    
-- Q20: (Having) Find which payment methods have processed a TOTAL amount greater than $1000.
SELECT
	method,
    SUM(amount) TotalAount
FROM
	grandhotel_db.payments
GROUP BY method
HAVING TotalAount > 1000;

-- ==========================================
-- LEVEL 3: ADVANCED (Days 7-9)
-- Topics: Complex Joins, Dates, CTEs, Views
-- ==========================================

-- Q21: (Self-Join) List Staff Name and their Manager's Name.
-- Q22: (COALESCE) Repeat Q21, but if the manager is NULL, display 'CEO'.
-- Q23: (Date Math) Calculate the length of stay (in days) for every completed booking.
-- Q24: (Date Functions) Find all bookings that are scheduled for the month of July (Month 7).
-- Q25: (Anti-Join) Find bookings that have NOT been paid for yet (Bookings with no matching Payment).
-- Q26: (CTE) Create a CTE that calculates 'TotalRevenue' per Guest. Select guests who spent > $0.
-- Q27: (CTE Chain) CTE 1: Filter 'Completed' bookings. CTE 2: Join with Rooms. Final: Select Room Type and Count of completed bookings.
-- Q28: (View) Create a View named 'active_bookings' that shows Guest Name, Room Number, and Check-In Date for 'Confirmed' bookings only.
-- Q29: (Window Function/Logic) Find the booking with the latest Check-In Date. (Use ORDER BY ... LIMIT 1 or MAX).
-- Q30: (Complex Logic) Calculate the "Occupancy Rate" (Percentage) of our rooms. 
--      (Hint: Count DISTINCT room_ids in bookings / Total count of rooms * 100).