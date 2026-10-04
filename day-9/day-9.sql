USE sales;

/* 
Task 1
Tính:

Total orders
Total revenue
Average order value
Minimum order value
Maximum order value
Viết một query duy nhất.
*/

SELECT COUNT(order_id) as total_orders,
	SUM(total_amount) as total_revenue,
	AVG(total_amount) as avg_order_value,
	MIN(total_amount) as min_order_value,
	MAX(total_amount) as max_order_value
FROM orders;

/* 
Task 2
Tính total revenue theo Region.
*/

SELECT
    region,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY region;

/* 
Task 3
Tính số orders theo Region.
*/

SELECT COUNT(order_id), region
FROM orders
GROUP BY region;

/* 
Task 4
Tính average order value theo Region.
*/

SELECT AVG(total_amount) AS avg_order_value, region
FROM orders
GROUP BY region;

/* 
Task 5
Tìm revenue theo Region, nhưng chỉ tính các orders có:

total_amount > 10M
*/

SELECT SUM(total_amount), region
FROM orders
WHERE total_amount > 10000000
GROUP BY region;

/* 
Task 6
Manager hỏi:

“Ở mỗi Region, order nào có giá trị lớn nhất?”

Bạn chưa cần giải bài này hoàn chỉnh bằng SQL.
Hãy trả lời:
Bạn nghĩ GROUP BY + MAX() có đủ để lấy order_id của order lớn nhất không? Tại sao?
*/

-- Mỗi Region có giá trị đơn hàng lớn nhất là bao nhiêu? thì GROUP BY + MAX() là đủ
-- Nhưng nếu hỏi order_id nào thì GROUP BY + MAX() chưa đủ, vì nó không trả về order_id, lúc này cần JOIN.

SELECT o.order_id, o.region, o.total_amount
FROM orders o
INNER JOIN (
    SELECT region, MAX(total_amount) AS max_amount
    FROM orders
    GROUP BY region
) m ON o.region = m.region AND o.total_amount = m.max_amount;

/* 
Task 7 — Business thinking
Viết SQL để trả lời:

“Region nào có tổng doanh thu cao hơn?”

Bạn không cần tìm một “winner” theo kiểu đánh giá business; chỉ cần query ra revenue của từng Region và sắp xếp giảm dần.

Gợi ý: kết hợp:

GROUP BY
+
SUM()
+
ORDER BY
*/

SELECT 
 	SUM(total_amount) AS total_revenue, region
FROM orders
GROUP BY region
ORDER BY SUM(total_amount) desc;












