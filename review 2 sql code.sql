CREATE DATABASE OnlineShoppings;
USE OnlineShoppings;

CREATE TABLE CATEGORY (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50)
);

CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200)
);



CREATE TABLE ADMIN (
    Admin_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100)
);

CREATE TABLE PRODUCT (
    Product_ID INT PRIMARY KEY,
    Category_ID INT,
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (Category_ID)
        REFERENCES CATEGORY(Category_ID)
);

CREATE TABLE SHOPPING_CART (
    Cart_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT,
    FOREIGN KEY (Customer_ID)
        REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES PRODUCT(Product_ID)
);



CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    Status VARCHAR(30),
    FOREIGN KEY (Customer_ID)
        REFERENCES CUSTOMER(Customer_ID)
);


CREATE TABLE PAYMENT (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Payment_Method VARCHAR(30),
    Payment_Date DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID)
	REFERENCES orders(Order_ID)
);



CREATE TABLE DELIVERY (
    Delivery_ID INT PRIMARY KEY,
    Order_ID INT,
    Status VARCHAR(30),
    FOREIGN KEY (Order_ID)
        REFERENCES ORDERS(Order_ID)
);


CREATE TABLE SUPPLIER (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE REVIEW (
    Review_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Rating INT,
    Comment VARCHAR(200),
    FOREIGN KEY (Customer_ID)
        REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES PRODUCT(Product_ID)
);

INSERT INTO CATEGORY VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books');

INSERT INTO CUSTOMER VALUES
(101, 'Prasanna', 'prasanna@gmail.com', '9876543210', 'Rajahmundry'),
(102, 'Aishwarya', 'aishwarya@gmail.com', '9876543211', 'Kakinada'),
(103, 'Majahar', 'majahar@gmail.com', '9876543212', 'Vijayawada');

INSERT INTO ADMIN VALUES
(1, 'Admin1', 'admin1@gmail.com', 'admin123'),
(2, 'Admin2', 'admin2@gmail.com', 'admin456');


INSERT INTO PRODUCT VALUES
(201, 1, 'Smartphone', 20000, 10),
(202, 2, 'Kurti', 1200, 20),
(203, 3, 'DBMS Book', 500, 15);

INSERT INTO SHOPPING_CART VALUES
(601, 101, 201, 1),
(602, 102, 202, 2);

INSERT INTO ORDERS VALUES
(301, 101, '2026-09-28', 20000, 'Confirmed'),
(302, 102, '2026-09-28', 1200, 'Delivered');

INSERT INTO PAYMENT VALUES
(401, 301, 'UPI', '2026-09-28', 20000),
(402, 302, 'Cash', '2026-09-28', 1200);

INSERT INTO DELIVERY VALUES
(501, 301, 'Shipped'),
(502, 302, 'Delivered');

INSERT INTO SUPPLIER VALUES
(701, 'ABC Suppliers', '9876500001', 'abc@gmail.com'),
(702, 'XYZ Suppliers', '9876500002', 'xyz@gmail.com');

INSERT INTO REVIEW VALUES
(801, 101, 201, 5, 'Good Product'),
(802, 102, 202, 4, 'Nice Quality');

SELECT * FROM CUSTOMER;

SELECT * FROM PRODUCT;

SELECT * FROM CATEGORY;

SELECT * FROM ORDERS;

SELECT * FROM PAYMENT;

SELECT * FROM DELIVERY;

SELECT
    CUSTOMER.Name,
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    ORDERS.Total_Amount,
    ORDERS.Status
FROM CUSTOMER
JOIN ORDERS
ON CUSTOMER.Customer_ID = ORDERS.Customer_ID;

SELECT
    PRODUCT.Product_Name,
    PRODUCT.Price,
    CATEGORY.Category_Name
FROM PRODUCT
JOIN CATEGORY
ON PRODUCT.Category_ID = CATEGORY.Category_ID;

SELECT
    ORDERS.Order_ID,
    ORDERS.Total_Amount,
    PAYMENT.Payment_Method,
    PAYMENT.Amount
FROM ORDERS
JOIN PAYMENT
ON ORDERS.Order_ID = PAYMENT.Order_ID;

SELECT
    Category_ID,
    COUNT(*) AS Total_Products
FROM PRODUCT
GROUP BY Category_ID;

SELECT
    AVG(Price) AS Average_Price,
    MAX(Price) AS Maximum_Price,
    MIN(Price) AS Minimum_Price
FROM PRODUCT;


SELECT COUNT(*) AS Total_Products
FROM PRODUCT;


UPDATE PRODUCT
SET Price = 22000
WHERE Product_ID = 201;

DELETE FROM REVIEW
WHERE Review_ID = 802;


CREATE VIEW Order_Details AS
SELECT
    CUSTOMER.Name,
    ORDERS.Order_ID,
    ORDERS.Order_Date,
    ORDERS.Total_Amount,
    ORDERS.Status
FROM CUSTOMER
JOIN ORDERS
ON CUSTOMER.Customer_ID = ORDERS.Customer_ID;

-- DISPLAY VIEW
SELECT * FROM Order_Details