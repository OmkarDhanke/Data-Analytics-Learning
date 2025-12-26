-- 1. Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Country VARCHAR(50),
    Email VARCHAR(100)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    StockQuantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
################################################### Practice ###################################################
DELIMITER $$

CREATE 	PROCEDURE FirstP()
	BEGIN 
		SELECT	
			CustomerID,
            FullName,
            Country,
            Email
		FROM 
			procedures.customers;
		END $$
        
DELIMITER ;

CALL FirstP;

-- Parameters (Dynamic Inputs)
DELIMITER $$

CREATE PROCEDURE get_summary(IN countryName VARCHAR(50))
BEGIN
    SELECT * FROM customers WHERE country = countryName;
END $$

DELIMITER ;

DROP PROCEDURE GetProductStock ;

################################################### Practice ###################################################

-- Q1: Create a simple procedure named 'GetAllProducts' that selects all columns from the Products table.
--     Execute it using CALL.

DELIMITER $$
	CREATE PROCEDURE GetAllProducts()
    BEGIN
		select * from products;
    END $$
DELIMITER ;

call GetAllProducts;

-- Q2: Create a procedure named 'GetCustomersByCountry'.
--     It should accept one input parameter (IN countryName VARCHAR(50)).
--     It returns all customers from that specific country.
DELIMITER $$
    CREATE PROCEDURE GetCustomersByCountry(In CountryName VARCHAR(50))
    BEGIN
        SELECT * FROM customers
        WHERE Country = CountryName;
    END $$
DELIMITER ;

call GetCustomersByCountry('India');


-- Q3: Create a procedure named 'GetProductStock'.
--     It accepts a ProductID.
--     It declares a variable 'currentStock', selects the StockQuantity into that variable, and then selects the variable to display it.
DELIMITER $$
    CREATE PROCEDURE GetProductStock(In ID Int)
    BEGIN
        SELECT StockQuantity as CurrentStock FROM products
        WHERE ProductID = ID;
    END $$
DELIMITER ;

call procedures.GetProductStock(102);
-- Q4: Create a procedure named 'UpdateProductPrice'.
--     Inputs: product_id INT, new_price DECIMAL.
--     Logic: Update the price of the specified product. After updating, select the new details of that product to confirm the change.
DELIMITER $$
    CREATE PROCEDURE UpdateProductPrice(IN ID Int, new_price float)
    Begin
		Update products set 
		Price = new_price
		where productid = ID;
	END $$
DELIMITER ;

-- Q5: (Control Flow - IF/ELSE) Create a procedure named 'CheckStockStatus'.
--     Input: product_id INT.
--     Logic: Get the stock for that product.
--            IF stock > 0, return 'In Stock'.
--            ELSE, return 'Out of Stock'.
DELIMITER $$

CREATE PROCEDURE CheckStockStatus(IN p_product_id INT)
		BEGIN
			DECLARE v_stock INT;
			SELECT StockQuantity 
			INTO v_stock
			FROM Products
			WHERE ProductID = p_product_id;
			IF v_stock > 0 THEN
				SELECT 'In Stock' AS Status;
			ELSE
				SELECT 'Out of Stock' AS Status;
			END IF;
		END$$
DELIMITER ;

call CheckStockStatus(103);

-- Q6: (Variables & Math) Create a procedure named 'CalculateOrderTotal'.
--     Inputs: product_id INT, quantity INT.
--     Logic:
--       1. Get the price of the product into a variable.
--       2. Calculate total (price * quantity) into a 'total_cost' variable.
--       3. Return the 'total_cost'.
DELIMITER $$
CREATE PROCEDURE CalculateOrderTotal(IN p_product_id INT, IN p_quantity INT)
		BEGIN
			DECLARE v_price DECIMAL(10,2);
			DECLARE v_total_cost DECIMAL(10,2);
			SELECT Price INTO v_price
			FROM Products
			WHERE ProductID = p_product_id;
			SET v_total_cost = v_price * p_quantity;
			SELECT v_total_cost AS total_cost;
		END$$

DELIMITER ;

-- Q7: (Logic & Updates) Create a procedure named 'PlaceOrder'.
--     Inputs: cust_id INT, prod_id INT, qty INT.
--     Logic:
--       1. Check if the product has enough stock (StockQuantity >= qty).
--       2. IF YES:
--            a. Insert a new row into Orders (TotalAmount = Price * qty).
--            b. Update Products table to subtract the stock.
--            c. Select 'Order Placed Successfully'.
--       3. IF NO:
--            Select 'Insufficient Stock'.
DELIMITER $$

CREATE PROCEDURE PlaceOrder(IN p_cust_id INT, IN p_prod_id INT, IN p_qty INT)
		BEGIN
			DECLARE v_stock INT;
			DECLARE v_price DECIMAL(10,2);
			DECLARE v_total DECIMAL(10,2);

			SELECT StockQuantity, Price INTO v_stock, v_price
			FROM Products
			WHERE ProductID = p_prod_id;
			IF v_stock >= p_qty THEN
				SET v_total = v_price * p_qty;

				INSERT INTO Orders(CustomerID, ProductID, Quantity, TotalAmount, OrderDate)
				VALUES (p_cust_id, p_prod_id, p_qty, v_total, NOW());

				-- Update product stock
				UPDATE Products
				SET StockQuantity = StockQuantity - p_qty
				WHERE ProductID = p_prod_id;

				SELECT 'Order Placed Successfully' AS Message;
			ELSE
				SELECT 'Insufficient Stock' AS Message;
			END IF;
		END$$
DELIMITER ;


-- Q8: (Error Handling) Create a procedure named 'SafeCustomerInsert'.
--     Inputs: cust_id INT, full_name VARCHAR, country VARCHAR.
--     Logic: Try to insert the new customer.
--     Handler: Declare an EXIT HANDLER for SQLEXCEPTION (or duplicate key error 1062).
--              If an error occurs, select 'Error: Customer ID already exists'.
DELIMITER $$
CREATE PROCEDURE SafeCustomerInsert(IN p_cust_id INT, IN p_full_name VARCHAR(100), IN p_country VARCHAR(50),P_email varchar(100))
		BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				SELECT 'Error: Customer ID already exists' AS Message;
			END;

			INSERT INTO Customers(CustomerID, FullName, Country,Email)
			VALUES (p_cust_id, p_full_name, p_country,P_email);

			SELECT 'Customer Inserted Successfully' AS Message;
		END$$


DELIMITER ;
-- Q9: (Aggregation) Create a procedure named 'GetCustomerStats'.
--     Input: cust_id INT.
--     Logic: Return the Customer's Name, Total Number of Orders, and Total Amount Spent (SUM) in a single row.
DELIMITER $$

CREATE PROCEDURE GetCustomerStats(IN p_cust_id INT)
		BEGIN
			SELECT c.FullName,
				   COUNT(o.OrderID) AS TotalOrders,
				   IFNULL(SUM(o.TotalAmount),0) AS TotalSpent
			FROM Customers c
			LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
			WHERE c.CustomerID = p_cust_id
			GROUP BY c.FullName;
		END$$
DELIMITER ;
-- Q10: (Maintenance) Create a procedure named 'ArchiveOldOrders'.
--      Input: cut_off_date DATE.
--      Logic:
--        1. Select count of orders older than the cut_off_date into a variable.
--        2. IF count > 0, DELETE those orders and return message "X Orders Deleted".
--        3. ELSE return "No orders found to archive".
DELIMITER $$
CREATE PROCEDURE ArchiveOldOrders(IN p_cut_off_date DATE)
		BEGIN
			DECLARE v_count INT;

			-- Count old orders
			SELECT COUNT(*) INTO v_count
			FROM Orders
			WHERE OrderDate < p_cut_off_date;
			IF v_count > 0 THEN
				DELETE FROM Orders
				WHERE OrderDate < p_cut_off_date;

				SELECT CONCAT(v_count, ' Orders Deleted') AS Message;
			ELSE
				SELECT 'No orders found to archive' AS Message;
			END IF;
		END$$
DELIMITER ;