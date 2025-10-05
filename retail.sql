CREATE DATABASE RETAIL;
USE RETAIL;
CREATE TABLE Customers (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE Products(
     p_id INT PRIMARY KEY,
     p_name VARCHAR(50),
     price DECIMAL(8,2),
     stock INT   );
     
CREATE TABLE Orders (
   o_id INT PRIMARY KEY,
   c_id INT,
   o_date DATE,
   total_amount DECIMAL(8,2),
   FOREIGN KEY (c_id) REFERENCES Customers(c_id)); 
     
 CREATE TABLE OrderDetails(  
       d_id INT PRIMARY KEY,
       o_id INT,
       p_id INT,
       quantity INT,
       price DECIMAL(8,2),
       FOREIGN KEY(o_id) REFERENCES Orders(o_id),
       FOREIGN KEY(p_id) REFERENCES Products(p_id)); 
     
     INSERT INTO Customers 
     VALUES
     (1,'VAISHNAVI','vaishnavi307@gmail.com','9999956589','Mumbai'),
	 (2,'KARISHMA','karishna65@gmail.com','9999956589','Amravati'),
     (3,'SWATI','swati90007@gmail.com','9999956589','Pune'),
     (4,'TURPTI','trupt698i@gmail.com','9999956589','Nashik'),
     (5,'KASHISH','kasish43@gmail.com','9999956589','Pune'),
     (6,'KAJAL','kajal00@gmail.com','9999956589','Mumbai'),
     (7,'VANDANA','vandana10@gmail.com','9999956589','Amravati'),
     (8,'SARALA','sarala543@gmail.com','9999956589','Pune');
 
     INSERT INTO Products VALUES
(101, 'Laptop', 50000.00, 10),
(102, 'Mobile', 20000.00, 15),
(103, 'Headphones', 1500.00, 30),
(104, 'Keyboard', 1200.00, 25),
(105, 'Mouse', 800.00, 40);

INSERT INTO Orders VALUES
(1001, 1, '2025-10-01', 52000.00),
(1002, 2, '2025-10-02', 20800.00),
(1003, 1, '2025-10-03', 3000.00),
(1004, 3, '2025-10-04', 25000.00),
(1005, 4,'2025-10-05', 68000.00),
(1006, 5,'2025-10-06', 58900.00),
(1007, 6, '2025-10-09', 66500.00),
(1008, 7, '2025-10-13', 79000.00);

TRUNCATE TABLE OrderDetails;

INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1, 50000.00),
(2, 1001, 105, 2, 1000.00),
(3, 1002, 102, 1, 20000.00),
(4, 1002, 105, 1, 800.00),
(5, 1003, 103, 2, 3000.00);

SELECT o.o_id, c.c_name AS customer, o.o_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.c_id = c.c_id;

SELECT o.o_id, c.c_name AS customer, p.p_name AS product, od.quantity, od.price
FROM OrderDetails od
JOIN Orders o ON od.o_id = o.o_id
JOIN Customers c ON o.c_id = c.c_id
JOIN Products p ON od.p_id = p.p_id;


SELECT c.c_name AS customer, COUNT(o.o_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.c_id = o.c_id
GROUP BY c.c_name;

SELECT o.o_id, c.c_name AS customer, o.total_amount
FROM Orders o
JOIN Customers c ON o.c_id = c.c_id
WHERE o.total_amount > 50000;

SELECT * 
FROM Products
WHERE stock < 20;

SELECT p.p_name, SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.p_id = p.p_id
GROUP BY p.p_name;

SELECT c.c_name, COUNT(o.o_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.c_id = o.c_id
GROUP BY c.c_name
HAVING total_orders > 1;

SELECT o.o_id, MAX(od.price) AS max_price
FROM OrderDetails od
JOIN Orders o ON od.o_id = o.o_id
GROUP BY o.o_id;

UPDATE Products p
JOIN OrderDetails od ON p.p_id = od.p_id
SET p.stock = p.stock - od.quantity
WHERE od.o_id = 1001;





