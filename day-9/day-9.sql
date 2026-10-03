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

SELECT

/* 
Task 2
Tính total revenue theo Region.
*/



/* 
Task 3
Tính số orders theo Region.
*/



/* 
Task 4
Tính average order value theo Region.
*/



/* 
Task 5
Tìm revenue theo Region, nhưng chỉ tính các orders có:

total_amount > 10M
*/



/* 
Task 6
Manager hỏi:

“Ở mỗi Region, order nào có giá trị lớn nhất?”

Bạn chưa cần giải bài này hoàn chỉnh bằng SQL.
Hãy trả lời:
Bạn nghĩ GROUP BY + MAX() có đủ để lấy order_id của order lớn nhất không? Tại sao?
*/



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