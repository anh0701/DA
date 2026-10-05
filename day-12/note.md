# Day 12 — JOIN: Kỹ năng cực kỳ quan trọng

Đây là một bước rất quan trọng vì trong database thực tế, **dữ liệu hiếm khi nằm hết trong một bảng**.

Ví dụ thay vì một bảng orders chứa tất cả:

### orders

| order_id | customer_id | total_amount |
| --- | --- | --- |
| O001 | C001 | 20M |
| O002 | C002 | 1M |
| O003 | C003 | 22M |
| O004 | C001 | 1M |

### customers

| customer_id | customer_name | segment |
| --- | --- | --- |
| C001 | An | Premium |
| C002 | Bình | Normal |
| C003 | Chi | Premium |
| C004 | Dũng | Normal |

Muốn biết:

> Order O001 thuộc khách hàng nào?

Ta phải nối hai bảng.

---

## 1. INNER JOIN

```SQL
SELECT
    o.order_id,
    o.total_amount,
    c.customer_name
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;
```

SQL sẽ nối:

`orders.customer_id
        =
customers.customer_id`

Kết quả:

| order_id | total_amount | customer_name |
| --- | --- | --- |
| O001 | 20M | An |
| O002 | 1M | Bình |
| O003 | 22M | Chi |
| O004 | 1M | An |

### Cách đọc

```SQL
FROM orders o
```

→ lấy orders làm bảng chính, đặt alias o.

```SQL
JOIN customers c
```

→ nối với customers, alias c.

```SQL
ON o.customer_id = c.customer_id
```

→ điều kiện xác định hai record nào thuộc về nhau.

---

## 2. Tại sao JOIN nguy hiểm với Data Analyst?

Quay lại bài Day 1:

> **JOIN có thể làm tăng số lượng rows.**

Ví dụ:

customers:

| customer_id | name |
| --- | --- |
| C001 | An |

orders:

| order_id | customer_id |
| --- | --- |
| O001 | C001 |
| O002 | C001 |
| O003 | C001 |

Một customer có 3 orders.

Sau JOIN:

Văn bản thuần túy

`C001 → O001
C001 → O002
C001 → O003`

Customer An xuất hiện **3 lần**.

Điều này không phải duplicate sai. Nó phản ánh quan hệ:

```
1 Customer
    ↓
N Orders
```

---

## 3. LEFT JOIN

Đây là loại JOIN cực kỳ quan trọng.

```SQL
SELECT
    o.order_id,
    o.customer_id,
    c.customer_name
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id;
```

LEFT JOIN nghĩa là:

> **Giữ toàn bộ dữ liệu của bảng bên trái**, dù có tìm thấy dữ liệu bên phải hay không.

Ví dụ:

orders có:

```
O001 C001
O002 C002
O003 C999
```

Nhưng customers không có C999.

Kết quả:

| order_id | customer_id | customer_name |
| --- | --- | --- |
| O001 | C001 | An |
| O002 | C002 | Bình |
| O003 | C999 | NULL |

Đây là một tình huống cực kỳ thực tế.

Bạn có thể dùng:

```SQL
WHERE c.customer_id IS NULL
```

để tìm:

> Những order nào không tìm thấy customer tương ứng?

---

## 4. INNER vs LEFT

Nhớ bảng này:

| JOIN | Giữ gì? |
| --- | --- |
| INNER JOIN | Chỉ những record match cả hai bảng |
| LEFT JOIN | Tất cả record bảng trái + record match bảng phải |

Hình dung:

```
INNER JOIN

A ∩ B
```

Còn:

```
LEFT JOIN

Toàn bộ A
+ phần B match được
```

---

## Bài tập Day 12

Tạo thêm bảng:

```SQL
CREATE TABLE customers (
    customer_id VARCHAR(10),
    customer_name VARCHAR(100),
    segment VARCHAR(20)
);
```

Insert:

```SQL
INSERT INTO customers VALUES
('C001', 'An', 'Premium'),
('C002', 'Binh', 'Normal'),
('C003', 'Chi', 'Premium'),
('C004', 'Dung', 'Normal');
```

### Câu 1

Viết INNER JOIN để lấy:

```
order_id
customer_id
customer_name
total_amount
```

---

### Câu 2

Viết LEFT JOIN để lấy:

```
order_id
customer_name
segment
```

---

### Câu 3

Nếu orders có:

`O011 | C999 | 3M`

nhưng customers không có C999.

INNER JOIN sẽ trả về O011 không?

LEFT JOIN sẽ trả về O011 không?

Giải thích.

---

### Câu 4 — Quan trọng

Bạn muốn tìm:

> **Những order có customer_id không tồn tại trong bảng customers.**

Viết SQL.

---

### Câu 5 — Tư duy Data Analyst

Nếu sau khi JOIN bạn thấy:

```
Trước JOIN: 100 orders
Sau JOIN:    135 rows
```

Bạn có kết luận ngay rằng:

> "JOIN bị duplicate dữ liệu."

**Có hay không? Vì sao?**

Câu 5 đặc biệt quan trọng, vì nó nối trực tiếp với **granularity** mà bạn đã học ở Day 1.
