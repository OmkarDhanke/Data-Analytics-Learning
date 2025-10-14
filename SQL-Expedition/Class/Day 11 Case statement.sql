
-- simple case statement
SELECT 
    *
FROM
    products;
SELECT 
    productname,
    category,
    CASE category
        WHEN 'Electronic' THEN 'Gadgets & Gizmos'
        WHEN 'Furniture' THEN 'Tables & Accessories'
        WHEN 'Stationery' THEN 'Books & Material'
        ELSE 'Miscellaneous Items'
    END AS category_description
FROM
    products;

-- Searched CASE Statement
SELECT 
    orderid,
    ordertotal,
    CASE
        WHEN ordertotal < 50.00 THEN 'No Discount'
        WHEN
            ordertotal >= 50.00
                AND ordertotal < 100.00
        THEN
            '5% Discount'
        WHEN
            ordertotal >= 100.00
                AND ordertotal < 200.00
        THEN
            '10% Discount'
        ELSE '20% Discount'
    END AS Discount_tier
FROM
    orders;
		
    
-- Q1
SELECT 
    ProductName,
    Price,
    CASE
        WHEN price < 50.00 THEN 'Low'
        WHEN price BETWEEN 50.00 AND 200.00 THEN 'Medium'
        WHEN price > 200.00 THEN 'High'
    END AS PriceRange
FROM
    products;
    
    
-- 2
SELECT 
    ProductName,
    StockQuantity,
    CASE
        WHEN StockQuantity = 0 THEN 'Out Of Stock'
        WHEN StockQuantity < 50.00 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS Stock_Status
FROM
    products;
    
-- Q3
SELECT 
    ProductName,
    Category,
    Price,
    CASE
        WHEN Category = 'Electronic' THEN '10% Off'
        WHEN Category = 'Furniture' THEN '5% Off'
        ELSE 'No Discount'
    END AS DiscountCategory
FROM
    products;
	
    
    
-- Q4

SELECT 
    OrderID,
    OrderTotal,
    CASE
        WHEN OrderTotal < 100 THEN 'Small Order'
        WHEN OrderTotal BETWEEN 100 AND 500 THEN 'Medium Order'
        ELSE 'Large Order'
    END AS Order_Quntity
FROM
    orders;
    
-- Q5
SELECT 
    ProductName,
    CASE
        WHEN
            Category = 'Electronic'
                AND price > 500.00
        THEN
            'Premium Electronic Item'
        WHEN
            Category = 'Stationery'
                AND price <= 20.00
        THEN
            'Affordable Stationery'
        WHEN Category = 'Furniture' THEN 'Furniture Deal'
        ELSE 'Other'
    END AS Message
FROM
    products;

-- Q6 
SELECT 
    OrderID,
    OrderDate,
    CASE
        WHEN
            WEEKDAY(OrderDate) = 5
                OR WEEKDAY(OrderDate) = 6
        THEN
            'Weekend'
        ELSE 'Weekday'
    END AS Day_of_week
FROM
    orders;
    
-- Q7 
SELECT 
    ProductName,
    Category,
    CASE
        WHEN Category = 'Electronic' THEN '18%'
        WHEN Category = 'Furniture' THEN '12%'
        WHEN Category = 'Stationery' THEN '5%'
    END AS TaxRate
FROM
    products;
    
-- Q8 
