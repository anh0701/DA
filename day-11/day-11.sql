USE sales;

-- Câu 1
-- Lấy danh sách Region không trùng nhau.

select DISTINCT(region)
from orders ;

-- Câu 2
-- Lấy các order thuộc North hoặc South bằng IN.

select *
from orders
where region in ('North', 'South');

-- Câu 3
-- Lấy các order có total_amount là một trong các giá trị sau:
-- 1M 20M 22M
-- Sử dụng IN.

select *
from orders
where total_amount in (1000000, 20000000, 22000000);

-- Câu 4
-- Lấy các customer có customer_id bắt đầu bằng C00.
-- Sử dụng LIKE.

select *
from orders
where customer_id like 'C00%';

-- Câu 5
-- Giả sử có thêm dữ liệu:
-- 
-- O011 | C011 | NULL | 3M 
-- O012 | C012 | North | 5M
-- 
-- Viết SQL lấy các order chưa có Region.

insert into orders (order_id, customer_id, total_amount) 
values ('O011', 'C011', 3000000); 

insert into orders (order_id, customer_id, region, total_amount) 
values ('O012', 'C012', 'North', 5000000);

select *
from orders
where region is null;



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

SELECT
    COUNT(*) AS total_orders,
    COUNT(region) AS orders_with_region,
    COUNT(*) - COUNT(region) AS orders_without_region
FROM orders;

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


-- Không, nên hỏi lại business rule của vấn đề này, xác định nguyên nhân rồi mới đưa ra giải pháp

