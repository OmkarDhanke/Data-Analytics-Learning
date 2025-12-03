######################################################### Practice #########################################################
-- LED() Look Back
-- Calculate the difference in sales between "Today" and "Yesterday".
SELECT
	Date(sale_datetime) as Date,
    ifnull(sale_amount,0) as Sale,
    LAG(ifnull(sale_amount,0),1,0) OVER(ORDER BY Sale_datetime) as previous_Day_sale,
    ifnull(sale_amount,0) - LAG(ifnull(sale_amount,0),1,0) OVER(ORDER BY Sale_datetime) as daily_change
FROM
	analytics.sales;

-- MoM
SELECT 
*,
Sale - Mom as MoM_Change,
Round(CAST((Sale - Mom) as FLOAT)/MoM * 100,1)
from (
SELECT
	MONTH(sale_datetime) Sale_Month,
    Sum(sale_amount) as Sale,
    LAG(Sum(sale_amount),1,0) OVER(ORDER BY MONTH(sale_datetime)) as MoM
FROM
	analytics.sales
GROUP BY Sale_Month) t;

-- Customer Loyalty 
SELECT 
	customer_id,
    avg(Date_diff) as AVGDAY,
    RANK() OVER(ORDER BY avg(Date_diff)) Rank_avg
from (
		SELECT
			order_id,
			customer_id,
			order_date as CurrentDate,
			LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) as NextOrder,
			datediff(LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date),order_date) as Date_Diff
		FROM
			sales.orders
) T
GROUP BY customer_id
HAVING AVGDAY is NOT NULL;

-- FIRST_VALUE
SELECT
	sale_id,
    sale_amount,
    FIRST_VALUE(sale_amount) OVER(ORDER BY sale_datetime) as First_VAl
FROM
	analytics.sales;

-- LAST_VALUE
SELECT
	sale_id,
    sale_amount,
    FIRST_VALUE(sale_amount) OVER(ORDER BY sale_datetime) as First_VAl,
    LAST_VALUE(sale_amount) OVER(ORDER BY sale_amount ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as Last_Val
FROM
	analytics.sales;
######################################################### Practice #########################################################
/*
-------------------------------------------------------------------------
PRACTICE QUESTIONS: OFFSET FUNCTIONS (LEAD, LAG, etc.)
Database Context: analytics.sales, analytics.employees
-------------------------------------------------------------------------
*/

-- Q1: Using LAG(), create a column 'Previous_Sale_Amount' that shows the amount of the sale immediately preceding the current one.
--     Order by 'sale_datetime'.
SELECT 
	sale_id,
    sale_amount,
    LAG(sale_amount) OVER(ORDER BY Sale_id) as 'Previous_Sale_Amount' 
FROM
	analytics.sales;

-- Q2: Calculate the difference (Growth/Decline) between the current sale_amount and the previous sale_amount.
--     (Hint: sale_amount - LAG(sale_amount)...)
SELECT 
	sale_id,
    sale_amount,
    LAG(sale_amount) OVER(ORDER BY Sale_id) as 'Previous_Sale_Amount' ,
    sale_amount - LAG(sale_amount) OVER(ORDER BY Sale_id) as difference
FROM
	analytics.sales;

-- Q3: Using LEAD(), create a column 'Next_Sale_Date' that shows the date/time of the *next* sale.
--     Order by 'sale_datetime'.
SELECT	
	sale_id,
    sale_datetime,
    LEAD(sale_datetime) OVER(ORDER BY sale_datetime) as Next_Sale_Date
FROM
	analytics.sales;

-- Q4: Calculate the "Time Gap" (in days or hours) between the current sale and the next sale.
SELECT	
	sale_id,
    sale_datetime,
    timestampdiff(hour,sale_datetime, LEAD(sale_datetime) OVER(ORDER BY sale_datetime))as Time_Gap_Hours
FROM
	analytics.sales;

-- Q5: Write a query to compare each employee's salary to the employee immediately below them in terms of salary ranking.
--     Show Employee Name, Salary, and "Lower_Salary" (using LEAD ordered by Salary DESC).
SELECT 
	*,
    RANK() OVER(ORDER BY Lower_salary ) as Sal_rank
from(
	SELECT	
		first_name,
		salary,
		LEAD(salary) OVER(ORDER BY Salary DESC) AS Lower_salary
	FROM
		analytics.employees
) T
WHERE salary is NOt null;

-- Q6: Partition by 'region'. For every sale, show the Previous Sale Amount *within that specific region*.
--     Ensure the calculation resets when the region changes.
SELECT	
	sale_id,
    sale_amount,
    region,
    LAG(sale_amount) OVER(PARTITION BY region ORDER BY sale_amount) as region_sale
FROM
	analytics.sales;

-- Q7: Using LAG() with a default value (3rd argument), show the previous sale amount.
--     If there is no previous sale (first row), display 0 instead of NULL.
SELECT
	sale_id,
    sale_amount,
    LAG(sale_amount,3,0) OVER(ORDER BY sale_id) as 'previous sale'
FROM
	analytics.sales;

-- Q8: Using FIRST_VALUE(), create a column that shows the amount of the very first sale ever recorded.
--     Display this alongside every individual sale record.
SELECT	
	sale_id,
    sale_amount,
    FIRST_VALUE(sale_amount) OVER(ORDER BY sale_id) as First_sale
FROM
	analytics.sales;

-- Q9: Using LAST_VALUE(), try to show the amount of the very last sale recorded.
--     (Note: Watch out for the "Default Frame" issue here! You might need ROWS BETWEEN...).
SELECT	
	sale_id,
    sale_amount,
    LAST_VALUE(sale_amount) OVER(ORDER BY sale_id  ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as First_sale
FROM
	analytics.sales;

