create database task ;

use task ;

-- Create table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

-- Insert sample data
INSERT INTO sales (sale_date, customer_name, product_name, quantity, unit_price)
VALUES
('2025-08-01', 'John Smith', 'Laptop', 2, 55000.00),
('2025-08-02', 'Priya Sharma', 'Smartphone', 1, 32000.00),
('2025-08-03', 'David Lee', 'Tablet', 3, 15000.00),
('2025-08-04', 'Aisha Khan', 'Wireless Earbuds', 5, 2500.00),
('2025-08-05', 'Raj Patel', 'Monitor', 2, 12000.00),
('2025-08-06', 'Sophia Williams', 'Keyboard', 4, 1500.00);

select * from sales ;

SELECT customer_name, product_name, total_amount
FROM sales
WHERE total_amount > 30000;

SELECT customer_name, product_name, total_amount
FROM sales
ORDER BY total_amount DESC;

SELECT product_name, SUM(total_amount) AS total_sales
FROM sales
GROUP BY product_name;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'John Smith', 'Delhi'),
(2, 'Priya Sharma', 'Mumbai'),
(3, 'David Lee', 'Bangalore');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Smartphone', 'Electronics'),
(103, 'Tablet', 'Electronics');

INSERT INTO sales (sale_date, customer_id, product_id, quantity, unit_price) VALUES
('2025-08-01', 1, 101, 2, 55000.00),
('2025-08-02', 2, 102, 1, 32000.00),
('2025-08-03', 3, 103, 3, 15000.00),
('2025-08-04', 4, 102, 1, 32000.00);

ALTER TABLE sales
ADD COLUMN customer_id INT;

ALTER TABLE sales
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE sales
ADD COLUMN product_id INT;

ALTER TABLE sales
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

INSERT INTO customers (customer_id, customer_name, city)
VALUES (4, 'Aisha Khan', 'Hyderabad');

select * from customers ;

select * from sales ;

select * from products ;

SELECT s.sale_id, s.sale_date, c.customer_name, p.product_name, s.quantity, s.unit_price
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id;

SELECT s.sale_id, s.sale_date, c.customer_name, p.product_name
FROM sales s
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN products p ON s.product_id = p.product_id;

SELECT s.sale_id, c.customer_name, p.product_name
FROM sales s
RIGHT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN products p ON s.product_id = p.product_id;

SELECT SUM(quantity * unit_price) AS total_sales_amount
FROM sales;

SELECT p.product_name,
       SUM(s.quantity * s.unit_price) AS total_sales,
       AVG(s.quantity * s.unit_price) AS avg_sales
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

CREATE VIEW product_sales_summary AS
SELECT p.product_name,
       SUM(s.quantity * s.unit_price) AS total_sales,
       AVG(s.quantity * s.unit_price) AS avg_sales
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

select * from product_sales_summary ;

CREATE VIEW customer_sales_summary AS
SELECT c.customer_name,
       SUM(s.quantity * s.unit_price) AS total_spent,
       COUNT(s.sale_id) AS total_orders
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;

select * from customer_sales_summary ;

CREATE INDEX idx_sales_customer_id ON sales(customer_id);
CREATE INDEX idx_sales_product_id ON sales(product_id);

CREATE INDEX idx_sales_date ON sales(sale_date);

CREATE INDEX idx_customer_date ON sales(customer_id, sale_date);

SHOW INDEXES FROM sales;

SELECT c.customer_name, SUM(s.quantity * s.unit_price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.sale_date >= '2025-08-01'
GROUP BY c.customer_name
ORDER BY total_spent DESC;











