-- Đảm bảo hệ thống sạch trước khi chạy
CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- 1. Tạo bảng và chèn dữ liệu mẫu
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY, 
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY, 
    product_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    product_id INT
);

-- Xóa dữ liệu cũ nếu có để tránh trùng lặp
TRUNCATE TABLE Customers;
TRUNCATE TABLE Products;
TRUNCATE TABLE Orders;

-- Chèn dữ liệu mẫu
INSERT INTO Customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO Products VALUES (101, 'Laptop'), (102, 'Mouse'), (103, 'Keyboard');
INSERT INTO Orders VALUES (1001, 1, 101), (1002, 1, 102), (1003, 2, 101);

-- ===============================================================
-- LỖI 1 ĐÃ SỬA: Báo cáo Marketing (Giữ lại Charlie với 0 đơn hàng)
-- ===============================================================
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) as total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- ===============================================================
-- LỖI 2 ĐÃ SỬA: Báo cáo Kho vận (Tìm chính xác sản phẩm ế Keyboard)
-- ===============================================================
SELECT 
    p.product_id, 
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
