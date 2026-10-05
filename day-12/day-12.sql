USE sales;

CREATE TABLE customers (
    customer_id VARCHAR(10),
    customer_name VARCHAR(100),
    segment VARCHAR(20)
);

INSERT INTO customers VALUES
('C001', 'An', 'Premium'),
('C002', 'Binh', 'Normal'),
('C003', 'Chi', 'Premium'),
('C004', 'Dung', 'Normal');

-- Câu 1
-- Viết INNER JOIN để lấy:

-- order_id
-- customer_id
-- customer_name
-- total_amount

select 
	o.order_id,
	o.customer_id,
	c.customer_name,
	o.total_amount
from orders o
inner join customers c
on o.customer_id = c.customer_id;



-- Câu 2
-- Viết LEFT JOIN để lấy:

-- order_id
-- customer_name
-- segment

select 
	o.order_id,
	c.customer_name,
	c.segment
from customers c
left join orders o
on c.customer_id = o.customer_id;


select 
	o.order_id,
	c.customer_name,
	c.segment
from orders o
left join  customers c
on c.customer_id = o.customer_id;

-- Câu 3
-- Nếu orders có:

-- O011 | C999 | 3M

-- nhưng customers không có C999.

-- INNER JOIN sẽ trả về O011 không?

-- LEFT JOIN sẽ trả về O011 không?

-- Giải thích.

-- inner join thì chắc chắn không trả về, vì cả hai bảng match nhau mới trả về kết quả.
-- left join thì có khả năng sẽ trả về bản ghi O011, vì left join là bảng A và phần bảng B match.


-- Câu 4 — Quan trọng
-- Bạn muốn tìm:

-- Những order có customer_id không tồn tại trong bảng customers.

-- Viết SQL.

select o.*
from orders o
left join customers c
on o.customer_id = c.customer_id
where c.customer_id is null;


-- Câu 5 — Tư duy Data Analyst
-- Nếu sau khi JOIN bạn thấy:

-- Trước JOIN: 100 orders
-- Sau JOIN:    135 rows

-- Bạn có kết luận ngay rằng:

-- "JOIN bị duplicate dữ liệu."

-- Có hay không? Vì sao?

-- Không, vì join bị tăng bản ghi là bình thường, 
-- mối quan hệ giữa hai bảng là mối quan hệ 1:1 hay 1:N, 
-- kiểu join cũng ảnh hưởng đến số lượng bản ghi, nên chưa kết luận được ngay


