
-- Create Database
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

-- Author Table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT
);

-- Book Language Table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100)
);

-- Publisher Table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150),
    contact_email VARCHAR(100)
);

-- Book Table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    isbn VARCHAR(20),
    publisher_id INT,
    language_id INT,
    publication_year YEAR,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book Author (many-to-many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY(book_id, author_id),
    FOREIGN KEY(book_id) REFERENCES book(book_id),
    FOREIGN KEY(author_id) REFERENCES author(author_id)
);

-- Country Table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- Address Table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY(country_id) REFERENCES country(country_id)
);

-- Address Status Table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- Customer Address Table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY(customer_id, address_id),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(address_id) REFERENCES address(address_id),
    FOREIGN KEY(status_id) REFERENCES address_status(status_id)
);

-- Shipping Method Table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(8,2)
);

-- Order Status Table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- Customer Order Table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    status_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY(status_id) REFERENCES order_status(status_id)
);

-- Order Line Table
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY(order_id, book_id),
    FOREIGN KEY(order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY(book_id) REFERENCES book(book_id)
);

-- Order History Table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME,
    FOREIGN KEY(order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY(status_id) REFERENCES order_status(status_id)
);

-- User Management
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'securePass123';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'bookstore_admin'@'localhost';

CREATE USER 'bookstore_reader'@'localhost' IDENTIFIED BY 'readOnly456';
GRANT SELECT ON BookstoreDB.* TO 'bookstore_reader'@'localhost';
