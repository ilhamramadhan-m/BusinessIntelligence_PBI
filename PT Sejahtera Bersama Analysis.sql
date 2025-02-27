# Create and use Database
CREATE DATABASE IF NOT EXISTS rakamin;
USE rakamin;

# Create Table
-- Customers Table
CREATE TABLE customers (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    cust_email VARCHAR(100) UNIQUE NOT NULL,
    cust_phone VARCHAR(15) NOT NULL,
    cust_address VARCHAR(255),
    cust_city VARCHAR(50),
    cust_state VARCHAR(50),
    cust_zip VARCHAR(10)
);

-- Product Category Table
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_abbreviation VARCHAR(10) NOT NULL
);

-- Products Table
CREATE TABLE products (
    prod_number VARCHAR(20) PRIMARY KEY,
    prod_name VARCHAR(100) NOT NULL,
    category INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_category FOREIGN KEY (category) REFERENCES product_category(category_id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    cust_id INT NOT NULL,
    prod_number VARCHAR(20) NOT NULL,
    quantity INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT fk_customers FOREIGN KEY (cust_id) REFERENCES customers(cust_id) ON DELETE CASCADE,
    CONSTRAINT fk_products FOREIGN KEY (prod_number) REFERENCES products(prod_number) ON DELETE CASCADE
);

# Check database
SHOW TABLES;

# Importing dataset into the table using Import Wizard from CSV file

# Check dataset
SELECT * FROM orders LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM product_category LIMIT 10;
SELECT * FROM customers LIMIT 10;

/*
Create a master table containing customer transaction data using JOIN statement
Columns: Email, City, Date, Quantity, Product, Price, Category, Total Sales  
Data is sorted by transaction date in ascending order  
*/
SELECT
	c.cust_email AS CustomerEmail,
    c.cust_city AS CustomerCity,
    o.order_date AS OrderDate,
    o.quantity AS OrderQty,
    p.prod_name AS ProductName,
    p.price AS ProductPrice,
    pc.category_name AS ProductCategoryName,
    (p.price * o.quantity) AS TotalSales
FROM
	orders o 
JOIN
	customers c ON o.cust_id = c.cust_id
JOIN
	products p ON o.prod_number = p.prod_number
JOIN
	product_category pc ON p.category = pc.category_id
ORDER BY OrderDate ASC
;
