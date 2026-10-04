# Day 10 — HAVING + CASE WHEN

Hôm nay học 2 thứ rất quan trọng trong SQL phân tích dữ liệu.

## 1. WHERE vs HAVING

Đây là điểm cần nhớ:

> **WHERE lọc từng row trước khi GROUP BY.**

> **HAVING lọc kết quả của từng group sau GROUP BY.**

Ví dụ:

### WHERE

Muốn lấy các đơn hàng **trên 10 triệu** rồi tính doanh thu theo Region:

```SQL
SELECT
    region,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE total_amount > 10000000
GROUP BY region;
```

Luồng xử lý:

```
orders
 ↓
WHERE total_amount > 10M
 ↓
GROUP BY region
 ↓
SUM()
```

---

### HAVING

Muốn:

> Gom nhóm theo Region → tính tổng doanh thu → chỉ lấy Region có doanh thu > 50M.

```SQL
SELECT
    region,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY region
HAVING SUM(total_amount) > 50000000;
```

Luồng:

```
orders
 ↓
GROUP BY region
 ↓
SUM()
 ↓
HAVING total_revenue > 50M
```

### Cách nhớ

| Muốn lọc | Dùng |
| --- | --- |
| Từng dòng | WHERE |
| Kết quả sau GROUP BY | HAVING |

Ví dụ:

```SQL
WHERE total_amount > 10M
```

→ lọc **order**

```SQL
HAVING SUM(total_amount) > 50M
```

→ lọc **region**

---

## 2. CASE WHEN

CASE WHEN trong SQL gần giống IF/IFS trong Excel.

Ví dụ muốn phân loại đơn hàng:

- ≥ 20M → High
- ≥ 10M → Medium
- còn lại → Low

```SQL
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 20000000 THEN 'High'
        WHEN total_amount >= 10000000 THEN 'Medium'
        ELSE 'Low'
    END AS order_level
FROM orders;
```

Kết quả sẽ kiểu:

| order_id | total_amount | order_level |
| --- | --- | --- |
| O001 | 20M | High |
| O002 | 1M | Low |
| O003 | 22M | High |
| O007 | 1.5M | Low |
| O009 | 21M | High |

**Thứ tự WHEN rất quan trọng.**

Ví dụ:

```SQL
CASE
    WHEN total_amount >= 10000000 THEN 'Medium'
    WHEN total_amount >= 20000000 THEN 'High'
END
```

Sai logic, vì 20M đã thỏa điều kiện >= 10M nên sẽ bị xếp vào Medium.

Phải đặt điều kiện lớn hơn trước:

```SQL
CASE
    WHEN total_amount >= 20000000 THEN 'High'
    WHEN total_amount >= 10000000 THEN 'Medium'
    ELSE 'Low'
END
```

---

## Bài tập Day 10

Vẫn dùng bảng orders cũ.

### Câu 1

Viết SQL lấy **Region có tổng doanh thu > 50M**.

---

### Câu 2

Viết SQL lấy **Region có ít nhất 3 đơn hàng**.

Gợi ý: COUNT() + GROUP BY + HAVING.

---

### Câu 3

Viết SQL phân loại từng order:

- `>= 20M → High`
- `>= 10M → Medium`
- `< 10M → Low`

Output:

`order_id | total_amount | order_level`

---

### Câu 4

Viết SQL tính **tổng doanh thu của các đơn hàng High**.

---

### Câu 5 — Quan trọng

Phân biệt 2 yêu cầu sau và cho biết dùng WHERE hay HAVING:

**A.** Chỉ lấy các order có total_amount > 10M.

**B.** Chỉ lấy các Region có SUM(total_amount) > 50M.

Trả lời và viết SQL cho cả A và B.