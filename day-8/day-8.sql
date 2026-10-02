CREATE DATABASE sales;
USE sales;

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATETIME,
    customer_id VARCHAR(50),
    region VARCHAR(50),
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, order_date, customer_id, region, total_amount)
VALUES ('O001', '2026-01-01 00:00:00', 'C001', 'North', 20000.00),
		('O002', '2026-01-02 00:00:00', 'C002', 'South', 1000.00),
		('O003', '2026-01-03 00:00:00', 'C003', 'North', 22000.00),
		('O004', '2026-01-04 00:00:00', 'C004', 'South', 10000.00),
		('O005', '2026-01-05 00:00:00', 'C005', 'South', 1000.00),
		('O006', '2026-01-06 00:00:00', 'C006', 'North', 20000.00),
		('O007', '2026-01-07 00:00:00', 'C007', 'South', 1500.00),
		('O008', '2026-01-08 00:00:00', 'C008', 'North', 2000.00),
		('O009', '2026-01-09 00:00:00', 'C009', 'South', 21000.00),
		('O010', '2026-01-10 00:00:00', 'C010', 'North', 2500.00)
;

-- Task 1: Lấy tất cả dữ liệu từ orders.

-- Task 2: Chỉ lấy: order_id, region, total_amount

-- Task 3: Lấy tất cả orders thuộc North.

-- Task 4: Lấy các orders có: total_amount > 10M

-- Task 5: Lấy các orders: Region = South AND total_amount > 1M

-- Task 6: Lấy các orders thuộc: North OR South

-- Task 7: Lấy 3 orders có total_amount cao nhất.

-- Task 8: Manager hỏi:
-- 
-- “Cho tôi 3 đơn hàng có giá trị cao nhất ở North.”
-- 
-- Viết một SQL query hoàn chỉnh.

-- Task 9: Giải thích sự khác nhau giữa:
--
-- WHERE total_amount > 10
-- 
-- và
-- 
-- WHERE total_amount > 10000000
-- 
-- nếu trong database total_amount được lưu bằng VND.



