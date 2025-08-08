Ecommerce Sales Analysis – SQL Project
📌 Project Overview
This project demonstrates SQL skills for data extraction, analysis, optimization, and reporting using a sample e-commerce sales dataset.
The task includes creating tables, inserting data, performing queries with filtering and aggregation, joining related tables, creating views, and optimizing performance with indexes.

🗂 Database & Tables
Database Created:

sql
Copy
Edit
CREATE DATABASE task;
USE task;
Tables Created:
sales → Stores sales transactions.
customers → Stores customer details.
products → Stores product details.

Example:

sql
Copy
Edit
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);
📊 Queries & Outcomes
1. Data Retrieval
Basic Selection:

sql
Copy
Edit
SELECT * FROM sales;
Retrieves all records from the sales table.

Filtering with WHERE:

sql
Copy
Edit
SELECT customer_name, product_name, total_amount
FROM sales
WHERE total_amount > 30000;
Outcome: Returns sales transactions where the total amount exceeded ₹30,000.

Sorting with ORDER BY:

sql
Copy
Edit
SELECT customer_name, product_name, total_amount
FROM sales
ORDER BY total_amount DESC;
Outcome: Displays sales from highest to lowest amount.

2. Aggregation
Group by Product:

sql
Copy
Edit
SELECT product_name, SUM(total_amount) AS total_sales
FROM sales
GROUP BY product_name;
Outcome: Shows total sales revenue for each product.

Aggregate Functions:

sql
Copy
Edit
SELECT SUM(quantity * unit_price) AS total_sales_amount FROM sales;
Outcome: Gives the overall revenue generated.

3. Joins
INNER JOIN:

sql
Copy
Edit
SELECT s.sale_id, s.sale_date, c.customer_name, p.product_name
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id;
Outcome: Shows only sales with matching customers and products.

LEFT JOIN:
Retrieves all sales, showing NULL where customer/product info is missing.

RIGHT JOIN:
Shows all customers, even those without sales.

4. Views for Analysis
Product Sales Summary View:

sql
Copy
Edit
CREATE VIEW product_sales_summary AS
SELECT p.product_name,
       SUM(s.quantity * s.unit_price) AS total_sales,
       AVG(s.quantity * s.unit_price) AS avg_sales
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;
Outcome: Summarizes total and average sales per product.

Customer Sales Summary View:
Shows total spend and total orders per customer.

5. Query Optimization
Indexes Created:

sql
Copy
Edit
CREATE INDEX idx_sales_customer_id ON sales(customer_id);
CREATE INDEX idx_sales_product_id ON sales(product_id);
CREATE INDEX idx_sales_date ON sales(sale_date);
CREATE INDEX idx_customer_date ON sales(customer_id, sale_date);
Outcome: Improves performance for joins, filters, and aggregations.

6. Final Analytical Query
sql
Copy
Edit
SELECT c.customer_name, SUM(s.quantity * s.unit_price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.sale_date >= '2025-08-01'
GROUP BY c.customer_name
ORDER BY total_spent DESC;
Outcome: Ranks customers by total spending since 1st Aug 2025.

📈 Skills Demonstrated
SQL DDL (Create, Alter Tables)
SQL DML (Insert, Select, Update)
Filtering & Sorting (WHERE, ORDER BY)
Aggregations (SUM, AVG, GROUP BY)
Joins (INNER, LEFT, RIGHT)
Views for reusable analysis
Indexing for performance optimization

✅ Conclusion
This task demonstrates the complete workflow of data preparation, querying, joining, aggregating, and optimizing an e-commerce sales dataset using SQL.
The results can be used to generate sales reports, customer insights, and product performance metrics, supporting business decision-making.