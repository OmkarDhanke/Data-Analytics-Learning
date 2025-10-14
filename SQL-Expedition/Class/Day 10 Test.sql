--  Create table Product
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10 , 2 ),
    StockQuantity INT
);

select * from products;

-- insert data in the Product
INSERT INTO Product(ProductID,ProductName,Category,Price,StockQuantity) values 
(1,'Laptop','Electronic', 1200.00,50),
(2,'Mouse','Electronic',25.00,200),
(3,'Keyboard','Electronic',75.00,150),
(4,'Desk Chair','Furniture',150.00,30),
(5,'Office Lamp', 'Furniture', 40.00,80),
(6,'Monitor','Electronic',300.00,70),
(7,'Notebook','Stationery',10.00,500),
(8,'Pen Set','Stationery',15.00,300);

-- create table orders
create table Orders(
OrderID int primary key,
CustomerID int,
OrderDate date,
OrderTotal decimal(10,2)
);

select * from Orders;

-- insert data in orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderTotal) values
(101, 1, '2024-01-15', 1250.00),
(102, 2, '2024-01-16', 75.00),
(103, 1, '2024-01-17', 300.00),
(104, 3, '2024-02-01', 15.00),
(105, 2, '2024-02-05', 150.00),
(106, 4, '2024-02-10', 40.00),
(107, 1, '2024-03-01', 1200.00),
(108, 5, '2024-03-05', 10.00);

-- MySql String fnction 
-- 1.1 (CONCAT, LEFT, UPPER)
 
select concat('Poducts',':',upper(ProductName)) as ProductName, upper(left(Category,3)) as Category from products;

-- 1.2 
select replace(ProductName, 'o', 'X') as ModifiedName, length(ProductName) as OriginalLength from Products;

-- 2.1 
select OrderID , OrderTotal, date_format(OrderDate, '%M %d,%Y') as Order_Date, year(OrderDate) as OrderYear, month(OrderDate) as OrderMonth from orders;

-- 2.2
select OrderID, OrderDate, timestampdiff(day,OrderDate,'2025-05-23') as DaysSinceOrder from orders;

-- 3.1 
select ProductName, round(Price * StockQuantity, 2) as ValueInStock, ceil(round(Price * StockQuantity, 2)) from Products;
