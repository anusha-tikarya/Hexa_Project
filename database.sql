-- Create database 
CREATE DATABASE ECommerceDB;

USE ECommerceDB;


-- Create tables to store customer, product, and order data
CREATE TABLE customer_dim (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    location VARCHAR(255)
);

CREATE TABLE product_dim (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255)
);

CREATE TABLE order_fact (
    order_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    quantity INT,
    order_amount DECIMAL(10, 2),
    order_date DATETIME,
    FOREIGN KEY (product_id) REFERENCES product_dim(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id)
);

-- Inserting sample data
INSERT INTO product_dim VALUES (1, 'Phone', 'Electronics');
INSERT INTO product_dim VALUES (2, 'Laptop', 'Electronics');
INSERT INTO product_dim VALUES (3, 'Tablet', 'Electronics');

INSERT INTO customer_dim VALUES (2001, 'Anu', 'India');
INSERT INTO customer_dim VALUES (2002, 'Meena', 'Canada');
INSERT INTO customer_dim VALUES (2003, 'Tanisha', 'New York');

INSERT INTO order_fact VALUES (1001, 1, 2001, 1, 139.99, '2023-09-27 12:30:00');
INSERT INTO order_fact VALUES (1002, 2, 2002, 2, 934.99, '2023-09-27 14:45:00');
INSERT INTO order_fact VALUES (1003, 3, 2003, 1, 543.99, '2023-09-27 15:30:00');

-- Query data to analyze customer behavior and product interactions

-- 1. Retrieve all customer data
SELECT * FROM customer_dim;

-- 2. Retrieve all product data
SELECT * FROM product_dim;

-- 3. Retrieve all order data
SELECT * FROM order_fact;

-- 4. Finding the Highest Sales Day
SELECT
    CAST(order_date AS DATE) AS order_day,
    SUM(order_amount) AS total_sales
FROM order_fact
GROUP BY CAST(order_date AS DATE)
ORDER BY total_sales DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;  
