# Day 11 — DISTINCT, IN, LIKE, NULL

Hôm nay mình học 4 thứ rất hay dùng khi viết SQL thực tế:

- DISTINCT → loại giá trị trùng
- IN → kiểm tra thuộc một nhóm giá trị
- LIKE → tìm kiếm theo pattern
- NULL → xử lý dữ liệu thiếu

---

## 1. DISTINCT

Ví dụ bảng orders có:

```
order_id | customer_id | region
O001     | C001        | North
O002     | C002        | South
O003     | C003        | North
O004     | C004        | South
```

Nếu:

```SQL
SELECT region
FROM orders;
```

Kết quả:

```
North
South
North
South
```

Nếu muốn lấy **các Region không trùng**:

```SQL
SELECT DISTINCT region
FROM orders;
```

Kết quả:

```
North
South
```

### DISTINCT trên nhiều cột

```SQL
SELECT DISTINCT region, customer_id
FROM orders;
```

Ở đây SQL loại các **combination trùng nhau**, không phải chỉ region.

---

## 2. IN

Thay vì:

```SQL
SELECT *
FROM orders
WHERE region = 'North'
   OR region = 'South';
```

Có thể viết:

```SQL
SELECT *
FROM orders
WHERE region IN ('North', 'South');
```

Dễ đọc hơn.

### Với số

```SQL
SELECT *
FROM orders
WHERE total_amount IN (1000000, 2000000, 20000000);
```

Nghĩa là:

> total_amount bằng **một trong ba giá trị** trên.

---

## 3. LIKE

LIKE dùng để tìm text theo pattern.

Ví dụ có customer:

```
C001
C002
C101
A001
```

### Bắt đầu bằng C

```SQL
WHERE customer_id LIKE 'C%'
```

% = bất kỳ chuỗi ký tự nào.

---

### Kết thúc bằng 01

```SQL
WHERE customer_id LIKE '%01'
```

---

### Có chứa 00

```SQL
WHERE customer_id LIKE '%00%'
```

---

## _ là gì?

_ đại diện cho **đúng một ký tự**.

Ví dụ:

```SQL
WHERE customer_id LIKE 'C_01'
```

Có thể match:

```
C101
C201
C001
```

Nhưng không match:

`C1001`

---

## 4. NULL

Đây là phần **rất quan trọng đối với Data Analyst**.

NULL nghĩa là:

> Không có giá trị / chưa có dữ liệu.

Ví dụ:

```
order_id | region
O001     | North
O002     | South
O003     | NULL
```

### Sai:

```SQL
WHERE region = NULL
```

Không dùng = để kiểm tra NULL.

### Đúng:

```SQL
WHERE region IS NULL
```

Muốn lấy những row **không NULL**:

```SQL
WHERE region IS NOT NULL
```

---

## NULL không phải 0

Đây là hai thứ hoàn toàn khác:

```
NULL → không có dữ liệu
0    → có dữ liệu và giá trị bằng 0
```

Ví dụ:

`quantity = NULL`

→ chưa biết quantity.

Trong khi:

`quantity = 0`

→ biết chắc quantity bằng 0.

**Không được tự động biến NULL thành 0** nếu chưa biết business meaning.

Điều này liên quan trực tiếp đến bài Excel Cleaning bạn đã học.

---

## Một lưu ý quan trọng: COUNT

Giả sử:

```
region
North
South
NULL
```

Thì:

```SQL
COUNT(region)
```

→ 2

vì COUNT(column)**không đếm NULL**.

Trong khi:

```SQL
COUNT(*)
```

→ 3

vì COUNT(*) đếm tất cả row.

Đây là một điểm rất hay gặp trong phân tích dữ liệu.

---

## Bài tập Day 11

Vẫn dùng bảng orders:

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

### Câu 1

Lấy danh sách **Region không trùng nhau**.

---

### Câu 2

Lấy các order thuộc **North hoặc South** bằng IN.

---

### Câu 3

Lấy các order có total_amount là một trong:

```
1M
20M
22M
```

Sử dụng IN.

---

### Câu 4

Lấy các customer có customer_id **bắt đầu bằng C00**.

Sử dụng LIKE.

---

### Câu 5

Giả sử có thêm dữ liệu:

```
O011 | C011 | NULL | 3M
O012 | C012 | North | 5M
```

Viết SQL lấy các order **chưa có Region**.

---

### Câu 6

Viết SQL đếm:

- tổng số orders
- số orders có Region
- số orders bị thiếu Region

Gợi ý: cần suy nghĩ về sự khác nhau giữa:

```SQL
COUNT(*)
```

và

```SQL
COUNT(region)
```

---

### Câu 7 — Tư duy Data Analyst

Nếu database có:

`region = NULL`

Bạn có nên viết:

```SQL
UPDATE orders
SET region = 'North'
WHERE region IS NULL;
```

ngay lập tức không?

**Trả lời Có/Không + giải thích lý do.**

Câu 7 rất quan trọng vì nó kiểm tra xem bạn đang **xử lý dữ liệu theo business logic** hay chỉ đơn giản là “lấp cho hết NULL”.
