USE sales;

-- Câu 1
-- Lấy danh sách Region không trùng nhau.



-- Câu 2
-- Lấy các order thuộc North hoặc South bằng IN.



-- Câu 3
-- Lấy các order có total_amount là một trong các giá trị sau:
-- 1M 20M 22M
-- Sử dụng IN.



-- Câu 4
-- Lấy các customer có customer_id bắt đầu bằng C00.
-- Sử dụng LIKE.



-- Câu 5
-- Giả sử có thêm dữ liệu:
-- 
-- O011 | C011 | NULL | 3M O012 | C012 | North | 5M
-- 
-- Viết SQL lấy các order chưa có Region.



-- Câu 6
-- Viết SQL đếm:
-- 
-- tổng số orders
-- số orders có Region
-- số orders bị thiếu Region
-- Gợi ý: cần suy nghĩ về sự khác nhau giữa:
-- 
-- COUNT(*)
-- 
-- và
-- 
-- COUNT(region)



-- Câu 7 — Tư duy Data Analyst
-- Nếu database có:
-- 
-- region = NULL
-- 
-- Bạn có nên viết:
-- 
-- UPDATE orders
-- SET region = 'North'
-- WHERE region IS NULL;
-- 
-- ngay lập tức không?
-- 
-- Trả lời Có/Không + giải thích lý do.




