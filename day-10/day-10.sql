USE sales;

-- Câu 1
-- Viết SQL lấy Region có tổng doanh thu > 50M.

SELECT region, sum(total_amount) as sum_revenue
FROM orders
GROUP BY region 
HAVING SUM(total_amount) > 50000000;

-- Câu 2
-- Viết SQL lấy Region có ít nhất 3 đơn hàng.

-- Gợi ý: COUNT() + GROUP BY + HAVING.

SELECT region, COUNT(distinct(order_id))
FROM orders
GROUP BY region 
HAVING COUNT(distinct(order_id)) >= 3;

-- Câu 3
-- Viết SQL phân loại từng order:
-- >= 20M → High
-- >= 10M → Medium
-- < 10M → Low
-- Output:
-- order_id | total_amount | order_level

SELECT order_id, total_amount, 
	CASE 
		WHEN total_amount >= 20000000 THEN "High"
		WHEN total_amount >= 10000000 THEN "Medium"
		ELSE "Low"
	END as order_level
FROM orders;



-- Câu 4
-- Viết SQL tính tổng doanh thu của các đơn hàng High.

-- cach 1

SELECT SUM(total_amount) AS total_high_revenue
FROM (
    SELECT total_amount,
           CASE 
               WHEN total_amount >= 20000000 THEN 'High'
               WHEN total_amount >= 10000000 THEN 'Medium'
               ELSE 'Low'
           END AS order_level
    FROM orders
) AS categorized_orders
WHERE order_level = 'High';

-- cach 2

SELECT SUM(total_amount) AS total_high_revenue
FROM orders
WHERE total_amount >= 20000000;

-- Câu 5 — Quan trọng
-- Phân biệt 2 yêu cầu sau và cho biết dùng WHERE hay HAVING:
-- A. Chỉ lấy các order có total_amount > 10M.
-- B. Chỉ lấy các Region có SUM(total_amount) > 50M.
-- Trả lời và viết SQL cho cả A và B.

-- A: dùng Where

SELECT *
FROM orders
WHERE total_amount > 10000000;

-- B: dùng having

SELECT region, SUM(total_amount) as sum_revenue
FROM orders
GROUP BY region
HAVING SUM(total_amount) > 50000000;


