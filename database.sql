
create database eproj;

-- Create a table for storing customer data
CREATE TABLE customer_dim (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    location VARCHAR(255)
);

-- Create a table for storing product data
CREATE TABLE product_dim (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255)
);

-- Create a fact table for storing order data
CREATE TABLE order_fact (
    order_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    quantity INT,
    order_amount DECIMAL(10, 2),
    order_date TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product_dim(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id)
);

-- Insert sample customer data
INSERT INTO customer_dim (customer_id, customer_name, location)
VALUES (1001, 'Alice', 'New York'), (1002, 'Bob', 'California');

-- Insert sample product data
INSERT INTO product_dim (product_id, product_name, category)
VALUES (1, 'Laptop', 'Electronics'), (2, 'Headphones', 'Accessories');

-- Insert an order into the order_fact table
INSERT INTO order_fact (order_id, product_id, customer_id, quantity, order_amount, order_date)
VALUES (101, 1, 1001, 2, 2000.00, CURRENT_TIMESTAMP);


-- Query to find all orders made by customers from California
SELECT o.order_id, c.customer_name, p.product_name, o.order_amount
FROM order_fact o
JOIN customer_dim c ON o.customer_id = c.customer_id
JOIN product_dim p ON o.product_id = p.product_id
WHERE c.location = 'California';

-- Query to calculate the total sales for each product
SELECT p.product_name, SUM(o.order_amount) AS total_sales
FROM order_fact o
JOIN product_dim p ON o.product_id = p.product_id
GROUP BY p.product_name;
