# Day 8 — SQL Foundations: SELECT, FROM, WHERE

Week 1: học cách **phân tích dữ liệu bằng Excel**. Sang Week 2, mục tiêu là chuyển cùng tư duy đó sang **SQL**.

Điểm quan trọng: **SQL không phải học thuộc câu lệnh**, mà là cách dùng SQL để trả lời business question.

---

## 1. SQL dùng để làm gì?

Trong công việc DA, dữ liệu thường nằm trong database:

```
Database
│
├── customers
├── orders
├── order_items
└── products
```

Ví dụ bảng orders:

| order_id | order_date | customer_id | region | total_amount |
| --- | --- | --- | --- | --- |
| O001 | 2026-01-01 | C001 | North | 20M |
| O002 | 2026-01-02 | C002 | South | 1M |
| O003 | 2026-01-03 | C003 | North | 22M |
| O004 | 2026-01-04 | C004 | South | 1M |
| O005 | 2026-01-05 | C005 | South | 1M |

Manager hỏi:

> “Cho tôi danh sách các order ở North.”

Trong Excel, bạn có thể Filter.

Trong SQL:

SQL

```
SELECT *
FROM orders
WHERE region = 'North';
```

Kết quả:

| order_id | order_date | customer_id | region | total_amount |
| --- | --- | --- | --- | --- |
| O001 | 2026-01-01 | C001 | North | 20M |
| O003 | 2026-01-03 | C003 | North | 22M |

---

## 2. SELECT

SELECT nói cho database biết:

> **Tôi muốn lấy những column nào?**

Ví dụ:

SQL

```
SELECT order_id, region, total_amount
FROM orders;
```

Kết quả chỉ có:

| order_id | region | total_amount |
| --- | --- | --- |
| O001 | North | 20M |
| O002 | South | 1M |
| O003 | North | 22M |

### Lấy tất cả columns

SQL

```
SELECT *
FROM orders;
```

* nghĩa là lấy tất cả columns.

Nhưng khi làm analysis thực tế, không nên lúc nào cũng dùng SELECT *.

Nếu chỉ cần:


```
order_id
region
total_amount
```

thì nên viết:

SQL

```
SELECT order_id, region, total_amount
FROM orders;
```

Vừa rõ ràng vừa tránh lấy dữ liệu không cần thiết.

---

## 3. FROM

FROM xác định:

> **Lấy dữ liệu từ bảng nào?**

SQL

```
SELECT order_id
FROM orders;
```

Có thể đọc như:

> Lấy order_id từ bảng orders.

Cấu trúc cơ bản:

SQL

```
SELECT columns
FROM table;
```

---

## 4. WHERE

WHERE dùng để:

> **lọc những rows thỏa điều kiện.**

Ví dụ:

SQL

```
SELECT *
FROM orders
WHERE region = 'North';
```

Nghĩa là:

> Lấy các order có Region = North.

---

## 5. Các toán tử cơ bản

### Bằng

SQL

```
WHERE region = 'North'
```

### Khác

SQL

```
WHERE region <> 'North'
```

Có thể gặp:

SQL

```
WHERE region != 'North'
```

tùy database.

---

### Lớn hơn

SQL

```
WHERE total_amount > 10
```

### Nhỏ hơn

SQL

```
WHERE total_amount < 10
```

### Lớn hơn hoặc bằng

SQL

```
WHERE total_amount >= 10
```

### Nhỏ hơn hoặc bằng

SQL

```
WHERE total_amount <= 10
```

---

## 6. String và Number

Đây là lỗi người mới học SQL rất hay gặp.

String:

SQL

```
WHERE region = 'North'
```

có dấu ' '.

Number:

SQL

```
WHERE total_amount > 10000000
```

không có dấu ' '.

Không viết:

SQL

```
WHERE total_amount > '10000000'
```

dù một số database có thể tự convert.

Hãy tập thói quen dùng đúng data type.

---

## 7. AND

Khi cần **nhiều điều kiện cùng đúng**:

SQL

```
SELECT *
FROM orders
WHERE region = 'North'
  AND total_amount > 10000000;
```

Nghĩa là:

> Region phải là North **và** amount phải > 10M.

---

## 8. OR

Khi chỉ cần **một trong các điều kiện đúng**:

SQL

```
SELECT *
FROM orders
WHERE region = 'North'
   OR region = 'South';
```

→ lấy North hoặc South.

---

## AND và OR rất dễ nhầm

Ví dụ:

SQL

```
WHERE region = 'North'
  AND region = 'South'
```

Một row không thể đồng thời có:

Văn bản thuần túy

`region = North
AND
region = South`

→ gần như chắc chắn không có kết quả.

Trong khi:

SQL

```
WHERE region = 'North'
   OR region = 'South'
```

→ đúng.

---

## 9. ORDER BY

Sau khi lấy dữ liệu, bạn có thể sắp xếp.

### Tăng dần

SQL

```
SELECT *
FROM orders
ORDER BY total_amount ASC;
```

ASC = ascending.

### Giảm dần

SQL

```
SELECT *
FROM orders
ORDER BY total_amount DESC;
```

DESC = descending.

Ví dụ manager hỏi:

> “Cho tôi các order có giá trị cao nhất.”

Bạn có thể:

SQL

```
SELECT *
FROM orders
ORDER BY total_amount DESC;
```

---

## 10. LIMIT

Nếu chỉ muốn lấy một số dòng đầu:

SQL

```
SELECT *
FROM orders
ORDER BY total_amount DESC
LIMIT 3;
```

Đọc là:

> Sắp xếp amount từ cao xuống thấp, sau đó lấy 3 rows đầu.

→ Đây là cách rất phổ biến để tìm:

> Top 3 orders

---

## 11. Tư duy SQL giống Excel

Bạn đã học Excel nên có thể map như sau:

| Excel | SQL |
| --- | --- |
| Chọn columns | SELECT |
| Chọn bảng dữ liệu | FROM |
| Filter | WHERE |
| Sort | ORDER BY |
| Lấy vài dòng đầu | LIMIT |

Ví dụ Excel:

> Filter Region = North → Sort Revenue giảm dần → lấy 3 dòng đầu.

SQL:

SQL

```
SELECT order_id, region, total_amount
FROM orders
WHERE region = 'North'
ORDER BY total_amount DESC
LIMIT 3;
```

Đây chính là cách bạn nên học SQL:

> **Business question → SQL operations**

---

## 12. Một lưu ý rất quan trọng

SQL có thứ tự **viết** thường là:

SQL

```
SELECT
FROM
WHERE
ORDER BY
LIMIT
```

Ví dụ:

SQL

```
SELECT order_id, region, total_amount
FROM orders
WHERE region = 'North'
ORDER BY total_amount DESC
LIMIT 3;
```

Bạn nên nhớ thứ tự này trước.

Sau này khi học GROUP BY, HAVING, JOIN, chúng ta sẽ mở rộng nó.

---

## Bài tập Day 8

Dùng bảng:

### orders

| order_id | order_date | customer_id | region | total_amount |
| --- | --- | --- | --- | --- |
| O001 | 2026-01-01 | C001 | North | 20M |
| O002 | 2026-01-02 | C002 | South | 1M |
| O003 | 2026-01-03 | C003 | North | 22M |
| O004 | 2026-01-04 | C004 | South | 1M |
| O005 | 2026-01-05 | C005 | South | 1M |
| O006 | 2026-01-06 | C006 | North | 20M |
| O007 | 2026-01-07 | C007 | South | 1.5M |
| O008 | 2026-01-08 | C008 | North | 2M |
| O009 | 2026-01-09 | C009 | South | 21M |
| O010 | 2026-01-10 | C010 | North | 2.5M |

### Task 1

Lấy **tất cả dữ liệu** từ orders.

---

### Task 2

Chỉ lấy:

Văn bản thuần túy

`order_id
region
total_amount`

---

### Task 3

Lấy tất cả orders thuộc **North**.

---

### Task 4

Lấy các orders có:

Văn bản thuần túy

`total_amount > 10M`

---

### Task 5

Lấy các orders:

Văn bản thuần túy

`Region = South
AND
total_amount > 1M`

---

### Task 6

Lấy các orders thuộc:

Văn bản thuần túy

`North OR South`

---

### Task 7

Lấy **3 orders có total_amount cao nhất**.

---

### Task 8 — Business question

Manager hỏi:

> **“Cho tôi 3 đơn hàng có giá trị cao nhất ở North.”**

Viết một SQL query hoàn chỉnh.

---

### Task 9 — Tư duy

Giải thích sự khác nhau giữa:

SQL

```
WHERE total_amount > 10
```

và

SQL

```
WHERE total_amount > 10000000
```

nếu trong database total_amount được lưu bằng **VND**.

---
