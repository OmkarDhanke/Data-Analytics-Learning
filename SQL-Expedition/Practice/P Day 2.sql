-- Question 1: Pattern Matching (The "Wildcard")
-- Find all items that have the word "Tea" anywhere in their name.
SELECT
	item_name
FROM
	coffeeshop_db.menu_items
WHERE 
	item_name LIKE "%Tea%";

-- Question 2: Lists (IN Operator)
-- Find all items that are either 'Espresso', 'Latte', or 'Bagel'.
SELECT	
	*
FROM		
	coffeeshop_db.menu_items
WHERE
	item_name IN ('Espresso', 'Latte', 'Bagel');


-- Question 3: Ranges (BETWEEN)
-- Find all items with calories between 100 and 300 (inclusive).
SELECT	
	item_name,calories
FROM
	coffeeshop_db.menu_items
WHERE 
	calories BETWEEN 100 and 300;
    
-- Question 4: Counting Rows
-- How many distinct items do we have on the menu in total?
SELECT 
	COUNT(*) as items
FROM
	coffeeshop_db.menu_items;
    
-- Question 5: Conditional Counting
-- How many items on the menu are Gluten Free?
SELECT
	COUNT(*) as 'Gluten Free Item'
FROM
	coffeeshop_db.menu_items
WHERE
	is_gluten_free = 1;

-- Question 6: Summing Up
-- Looking at the 'daily_sales' table, what is the total number of items sold today?
SELECT
	SUM(quantity_sold) as daily_sales
FROM
	coffeeshop_db.daily_sales;

-- Question 7: Averages
-- What is the average price of an item on our menu?
SELECT
	Round(AVG(price),2) as average_price
FROM	
	coffeeshop_db.menu_items;
    
-- Question 8: NOT Logic
-- Find all payment methods in 'daily_sales' that were NOT 'Cash'.
SELECT
	payment_method
FROM
	coffeeshop_db.daily_sales
WHERE
	payment_method NOT LIKE 'Cash';

-- Question 9: Combining Logic (Medium)
-- Find all 'Coffee' items that cost more than $4.00.
SELECT
	* 
FROM
	coffeeshop_db.menu_items
WHERE
	category = 'Coffee' AND price > 4.00;
    
-- Question 10: Formatting (Challenge)
-- Select the item_name and the price, but rename the price column to 'Cost_in_Dollars' in the output.
SELECT
	item_name,concat('$'," ",price) as Cost_In_Dollars
FROM
	coffeeshop_db.menu_items;