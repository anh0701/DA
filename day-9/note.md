# Day 9 — Aggregate Functions & GROUP BY

Day 8 bạn mới lấy **các dòng dữ liệu**. Hôm nay chúng ta bắt đầu dùng SQL để **tính toán và tổng hợp dữ liệu**, tương đương với những gì bạn đã làm bằng SUM, COUNT, Pivot Table trong Excel.

---

## 1. Aggregate Function là gì?

Aggregate function là các hàm dùng để **tổng hợp nhiều rows thành một kết quả**.

5 hàm cơ bản cần nhớ:

```
COUNT()
SUM()
AVG()
MIN()
MAX()
```

Ví dụ bảng orders:

| order_id | region | total_amount |
| --- | --- | --- |
| O001 | North | 20M |
| O002 | South | 1M |
| O003 | North | 22M |
| O004 | South | 1M |
| O005 | South | 1M |

---

## 2. COUNT()

Dùng để đếm.

### Đếm số rows

```sql
SELECT COUNT(*)
FROM orders;
```

→ 5

COUNT(*) thường được hiểu là:

> Có bao nhiêu rows?

---

### Đếm một column

```sql
SELECT COUNT(order_id)
FROM orders;
```

Nếu order_id không NULL thì cũng ra 5.

Nhưng có một khác biệt quan trọng:

```text
COUNT(*)       → đếm rows
COUNT(column)  → đếm giá trị NOT NULL trong column
```

---

## 3. SUM()

Tính tổng.

```sql
SELECT SUM(total_amount)
FROM orders;
```

Nếu dữ liệu:

`20M + 1M + 22M + 1M + 1M`

→ **45M**

---

## 4. AVG()

Tính trung bình.

```sql
SELECT AVG(total_amount)
FROM orders;
```

Ví dụ:

`45M / 5 = 9M`

→ Average order value = **9M**

Điểm này rất quan trọng:

> Nếu bảng orders có **1 row = 1 order**, AVG(total_amount) là average order value.

Nhưng nếu bảng là order_items:

| order_id | product | revenue |
| --- | --- | --- |
| O001 | Laptop | 20M |
| O001 | Mouse | 1M |
| O002 | Laptop | 22M |

thì:

```sql
AVG(revenue)
```

là **average revenue per row/item**, không phải average revenue per order.

Bạn đã học đúng vấn đề này từ Day 1.

---

## 5. MIN() và MAX()

Giá trị nhỏ nhất:

```sql
SELECT MIN(total_amount)
FROM orders;
```

Giá trị lớn nhất:

```sql
SELECT MAX(total_amount)
FROM orders;
```

Ví dụ trên:

```
MIN = 1M
MAX = 22M
```

---

## 6. AS — đặt tên cho kết quả

Query này:

```sql
SELECT SUM(total_amount)
FROM orders;
```

có thể trả column name khá khó đọc.

Bạn có thể đặt alias:

```sql
SELECT SUM(total_amount) AS total_revenue
FROM orders;
```

Kết quả:

| total_revenue |
| --- |
| 45M |

Tương tự:

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    MIN(total_amount) AS min_order_value,
    MAX(total_amount) AS max_order_value
FROM orders;
```

→ Bạn có thể lấy nhiều metrics trong **một query**.

---

## 7. GROUP BY — phần quan trọng nhất hôm nay

Nếu chỉ viết:

```sql
SELECT SUM(total_amount)
FROM orders;
```

→ bạn nhận được **một tổng duy nhất**.

Nhưng manager hỏi:

> “Doanh thu theo Region?”

Ta cần chia dữ liệu thành từng group:

```
North
South
```

Sau đó tính SUM cho từng group.

SQL:

```sql
SELECT
    region,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY region;
```

Kết quả:

| region | revenue |
| --- | --- |
| North | 42M |
| South | 3M |

---

## 8. Tư duy của GROUP BY

Đây là cách bạn nên hình dung:

```
orders
   │
   ├── North
   │     ├── O001
   │     └── O003
   │
   └── South
         ├── O002
         ├── O004
         └── O005
```

Sau đó:

```
North → SUM()
South → SUM()
```

Đây chính là thứ bạn đã làm bằng **Pivot Table**.

Mapping:

| Excel Pivot | SQL |
| --- | --- |
| Rows → Region | GROUP BY region |
| Values → Sum Revenue | SUM(total_amount) |
| Values → Count | COUNT() |
| Values → Average | AVG() |

---

## 9. GROUP BY nhiều columns

Ví dụ manager hỏi:

> Doanh thu theo **Region và Product**?

```sql
SELECT
    region,
    product,
    SUM(revenue) AS total_revenue
FROM order_items
GROUP BY region, product;
```

SQL sẽ group theo combination:

```
North + Laptop
North + Mouse
South + Laptop
South + Mouse
...
```

Tương tự Pivot:

```
Rows    → Product
Columns → Region
Values  → Sum Revenue
```

---

## 10. GROUP BY phải đi cùng tư duy Dimension → Measure

Đây là một framework rất quan trọng:

> **Dimension = GROUP BY**

> **Measure = Aggregate Function**

Ví dụ:

### Revenue theo Region

```
Dimension = Region
Measure   = Revenue
```

```sql
SELECT
    region,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY region;
```

### Average order value theo Region

```
Dimension = Region
Measure   = Order Value
Aggregation = AVG
```

```sql
SELECT
    region,
    AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY region;
```

---

## 11. Một lỗi cực kỳ quan trọng

Bạn sẽ gặp query kiểu:

```sql
SELECT
    region,
    SUM(total_amount)
FROM orders;
```

SQL thường sẽ báo lỗi vì bạn đang lấy:

`region`

nhưng lại không nói muốn group region như thế nào.

Phải viết:

```sql
SELECT
    region,
    SUM(total_amount)
FROM orders
GROUP BY region;
```

Quy tắc đơn giản:

> Nếu SELECT có một column bình thường cùng với aggregate function, column đó thường phải nằm trong GROUP BY.

---

## 12. WHERE + GROUP BY

Bạn có thể filter **trước khi group**.

Ví dụ:

> Doanh thu theo Region, nhưng chỉ tính orders > 10M.

```sql
SELECT
    region,
    SUM(total_amount) AS revenue
FROM orders
WHERE total_amount > 10000000
GROUP BY region;
```

Tư duy:

```
FROM orders
      ↓
WHERE > 10M
      ↓
GROUP BY region
      ↓
SUM()
```

---

## Bài tập Day 9

Dùng bảng orders đầy đủ từ Day 8:

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

Tính:

- Total orders
- Total revenue
- Average order value
- Minimum order value
- Maximum order value

Viết **một query duy nhất**.

---

### Task 2

Tính **total revenue theo Region**.

---

### Task 3

Tính **số orders theo Region**.

---

### Task 4

Tính **average order value theo Region**.

---

### Task 5

Tìm **revenue theo Region**, nhưng chỉ tính các orders có:

`total_amount > 10M`

---

### Task 6

Manager hỏi:

> “Ở mỗi Region, order nào có giá trị lớn nhất?”

Bạn chưa cần giải bài này hoàn chỉnh bằng SQL.

Hãy trả lời:

**Bạn nghĩ GROUP BY + MAX() có đủ để lấy order_id của order lớn nhất không? Tại sao?**

Câu này mình cố tình hỏi để kiểm tra tư duy, vì đây là chỗ người mới học SQL rất dễ tưởng rằng:

```sql
SELECT region, MAX(total_amount)
...
GROUP BY region
```

là đã lấy được **order tương ứng**.

---

### Task 7 — Business thinking

Viết SQL để trả lời:

> **“Region nào có tổng doanh thu cao hơn?”**

Bạn không cần tìm một “winner” theo kiểu đánh giá business; chỉ cần query ra **revenue của từng Region và sắp xếp giảm dần**.

Gợi ý: kết hợp:

```
GROUP BY
+
SUM()
+
ORDER BY
```