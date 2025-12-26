
SELECT 	
	sale_id,
    sale_amount,
    sum(sale_amount) OVER(
							ORDER BY sale_datetime 
							ROWS BETWEEN UNBOUNDED PRECEDING 
							AND CURRENT ROW
                         ) as Running_total
FROM
	analytics.sales;
    
    
SELECT 	
	sale_id,
    sale_amount,
    round(avg(sale_amount) OVER(
							ORDER BY sale_datetime 
							ROWS BETWEEN CURRENT ROW
							AND 1 FOLLOWING
                         ),2) as Running_total
FROM
	analytics.sales;
    
    
SELECT 	
	sale_id,
    sale_amount,
   avg(sale_amount) OVER(
							ORDER BY sale_datetime 
							rows between 2 PRECEDING and CURRENT ROW
                         ) as Running_total
FROM
	analytics.sales;
    
SELECT 	
	sale_id,
    sale_amount,
   avg(sale_amount) OVER(
						ORDER BY sale_datetime 
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
						) as Running_total
FROM
	analytics.sales;
/*
-------------------------------------------------------------------------
PRACTICE QUESTIONS: RUNNING TOTALS & FRAMES (Day 17)
Database Context: analytics.sales
-------------------------------------------------------------------------
*/

-- Q1: Calculate a simple Running Total of 'sale_amount' ordered by 'sale_datetime'.
--     (Rely on the Default Frame).
SELECT 
	sale_id,
    sale_amount,
    Date(sale_datetime) as Date,
    sum(sale_amount) OVER (ORDER BY sale_datetime) as Runnig_total
FROM
	analytics.sales;

-- Q2: Explicitly write out the Frame Clause (ROWS BETWEEN...) for the Running Total in Q1.
--     Verify that the results are identical to Q1.
SELECT 
	sale_id,
    sale_amount,
    Date(sale_datetime) as Date,
    sum(sale_amount) OVER (ORDER BY sale_datetime ROWS BETWEEN
     UNBOUNDED PRECEDING and CURRENT ROW) as Runnig_total
FROM
	analytics.sales;
	

-- Q3: Calculate a "3-Sale Moving Average" of the 'sale_amount'.
--     The window should include the current sale and the previous 2 sales.
--     Order by 'sale_datetime'.
SELECT 
	sale_id,
    sale_amount,
    avg(sale_amount) OVER(ORDER BY sale_datetime ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as "3-Sale Moving Average"
FROM 
	analytics.sales;
    
-- Q4: Calculate a Running Total of sales, but PARTITION it by 'region'.
--     The total should reset to 0 whenever the region changes.
SELECT 
	sale_id,
    region,
    sale_amount,
    sum(sale_amount) OVER(PARTITION BY region ORDER BY sale_datetime) as Region_Running_Total
FROM 
	analytics.sales;

-- Q5: Calculate a "Centered Moving Average" for 'sale_amount'.
--     The window should include 1 sale before, the current sale, and 1 sale after.
--     Order by 'sale_datetime'.
SELECT 
	sale_id,
    sale_amount,
    avg(sale_amount) OVER(ORDER BY sale_datetime ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as "Centered Moving Avg"
FROM 
	analytics.sales;

-- Q6: Calculate the Cumulative Sum of sales for each 'product' category separately.
--     Order the data by 'sale_datetime' within each product partition.
SELECT 
	sale_id,
    product,
    sale_amount,
    sum(sale_amount) OVER(PARTITION BY product ORDER BY sale_datetime) as Product_Cumulative_Sum
FROM 
	analytics.sales;

-- Q7: We want to compare each sale to the "Previous 4 Sales" (Total of 5 sales including current).
--     Calculate the SUM of 'sale_amount' for this 5-sale sliding window.
SELECT 
	sale_id,
    sale_amount,
    sum(sale_amount) OVER(ORDER BY sale_datetime ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) as "5-Sale Window Sum"
FROM 
	analytics.sales;

-- Q8: Calculate a Running Count of sales (how many sales have happened so far)
--     ordered by 'sale_datetime'.
SELECT 
	sale_id,
    Date(sale_datetime) as Date,
    count(*) OVER(ORDER BY sale_datetime) as Running_Count
FROM 
	analytics.sales;

-- Q9: (Advanced Frame) Calculate the Maximum sale amount seen "so far" (Running Max)
--     and the Minimum sale amount seen "so far" (Running Min) in the same query.
--     Order by 'sale_datetime'.
SELECT 
	sale_id,
    sale_amount,
    MAX(sale_amount) OVER(ORDER BY sale_datetime) as Running_Max,
    MIN(sale_amount) OVER(ORDER BY sale_datetime) as Running_Min
FROM 
	analytics.sales;

-- Q10: (Frame Logic Check) Write a query that calculates the SUM of 'sale_amount'
--      looking ONLY at the "Next 2 Sales" (1 FOLLOWING and 2 FOLLOWING), excluding the current row.
--      (Hint: ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING).
SELECT 
	sale_id,
    sale_amount,
    sum(sale_amount) OVER(ORDER BY sale_datetime ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING) as Next_2_Sales_Sum
FROM 
	analytics.sales;