## Day 5 — Pivot Table

Đây là phần rất quan trọng với Junior Data Analyst vì Pivot giúp bạn trả lời nhanh các câu hỏi kiểu:

> “Doanh thu theo khu vực là bao nhiêu?”
> “Sản phẩm nào bán nhiều nhất?”
> “North và South khác nhau thế nào?”

### 1. Pivot Table là gì?

Hiểu đơn giản:

> **Pivot Table = công cụ tổng hợp dữ liệu theo các chiều khác nhau.**

Ví dụ dữ liệu:

| Order ID | Product | Region | Quantity | Revenue |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20M |
| O002 | Mouse | South | 2 | 1M |
| O003 | Laptop | North | 1 | 22M |
| O004 | Keyboard | South | 1 | 1M |
| O005 | Mouse | South | 2 | 1M |
| O006 | Laptop | North | 1 | 20M |
| O007 | Mouse | South | 3 | 1.5M |

Nếu muốn biết **doanh thu theo Region**, thay vì viết `SUMIF`, bạn có thể Pivot.

Cấu hình:

```
Rows:     Region
Values:   Sum of Revenue
```

Kết quả:

| Region | Sum of Revenue |
| --- | --- |
| North | 62M |
| South | 4.5M |
| **Grand Total** | **66.5M** |

---

## 2. 4 khu vực quan trọng của Pivot

Khi tạo Pivot Table, bạn thường sẽ gặp:

```
Filters
Columns
Rows
Values
```

### Rows

Dùng để **chia nhóm dữ liệu**.

Ví dụ:

```
Rows → Region
```

→ North, South.

Hoặc:

```
Rows → Product
```

→ Laptop, Mouse, Keyboard.

---

### Values

Dùng để **tính toán**.

Ví dụ:

```
Values → Revenue
```

Excel có thể tính:

- Sum
- Count
- Average
- Max
- Min

Ví dụ:

```
Rows   → Region
Values → Sum of Revenue
```

→ Doanh thu theo khu vực.

---

### Columns

Dùng để tạo **các nhóm theo chiều ngang**.

Ví dụ:

```
Rows    → Product
Columns → Region
Values  → Sum of Revenue
```

Có thể ra dạng:

| Product | North | South | Total |
| --- | --- | --- | --- |
| Keyboard | 0 | 1M | 1M |
| Laptop | 62M | 0 | 62M |
| Mouse | 0 | 3.5M | 3.5M |

Cách này rất hữu ích khi muốn **so sánh hai chiều**.

---

### Filters

Dùng để lọc toàn bộ Pivot.

Ví dụ:

```
Rows    → Product
Values  → Sum of Revenue
Filters → Region
```

Sau đó chọn:

```
Region = South
```

→ Pivot chỉ phân tích dữ liệu South.

---

# 3. Pivot Chart

Pivot Table cho bạn **con số**.

Pivot Chart giúp bạn **nhìn xu hướng / so sánh trực quan**.

Ví dụ:

```
Pivot Table

Region    Revenue
North     62M
South     4.5M
```

→ tạo Column Chart.

Bạn có thể nhìn ngay North cao hơn South rất nhiều.

Nhưng nhớ:

> **Chart không thay thế phân tích.**

Ví dụ thấy North có doanh thu cao hơn chưa có nghĩa North “tốt hơn”.

Có thể North có:

- nhiều đơn hàng hơn
- giá sản phẩm cao hơn
- nhiều khách hàng hơn
- số lượng bán cao hơn

DA phải tiếp tục đặt câu hỏi.

---

# 4. Slicer

Slicer là phần rất đáng học vì nó làm Dashboard tương tác.

Ví dụ Pivot có:

```
Product
Revenue
```

Thêm Slicer:

```
Region

[ North ] [ South ]
```

Click **South** → toàn bộ Pivot/Chart lọc South.

Click **North** → chuyển sang North.

Thay vì mở dropdown Filter, người dùng có nút trực quan để lọc.

---

# 5. Tư duy quan trọng nhất của Pivot

Đừng học theo kiểu:

> “Region kéo vào Rows, Revenue kéo vào Values.”

Hãy học theo:

> **Business Question → Dimension → Measure → Aggregation**

Ví dụ:

### Câu hỏi

**Doanh thu theo sản phẩm?**

```
Dimension = Product
Measure   = Revenue
Aggregation = SUM
```

Pivot:

```
Rows   → Product
Values → Sum of Revenue
```

---

### Câu hỏi

**Có bao nhiêu đơn hàng ở mỗi Region?**

```
Dimension = Region
Measure   = Order ID
Aggregation = COUNT
```

Pivot:

```
Rows   → Region
Values → Count of Order ID
```

⚠️ Nhưng quay lại Day 1:

Nếu một order có nhiều rows thì `Count of Order ID` **có thể sai**.

Đây chính là lý do **granularity** vẫn quan trọng khi dùng Pivot.

---

# Bài tập Day 5

Dùng dataset này:

| Order ID | Product | Region | Quantity | Revenue |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20M |
| O002 | Mouse | South | 2 | 1M |
| O003 | Laptop | North | 1 | 22M |
| O004 | Keyboard | South | 1 | 1M |
| O005 | Mouse | South | 2 | 1M |
| O006 | Laptop | North | 1 | 20M |
| O007 | Mouse | South | 3 | 1.5M |

### Câu 1

Manager hỏi:

> **Doanh thu theo Region là bao nhiêu?**

Bạn hãy trả lời:

```
Rows:
Values:
Aggregation:
```

và kết quả North/South.

---

### Câu 2

> **Số lượng sản phẩm bán ra theo Product?**

Bạn sẽ cấu hình Pivot thế nào?

---

### Câu 3

> **Doanh thu theo Product và Region?**

Điền:

```
Rows:
Columns:
Values:
Aggregation:
```

---

### Câu 4

Manager muốn xem **chỉ South**, nhưng vẫn muốn giữ Pivot để có thể chuyển lại North.

Bạn sẽ dùng:

**A. Filter thường của bảng dữ liệu**

**B. Pivot Filter**

**C. Slicer**

**D. Xóa dữ liệu North**

Chọn đáp án và giải thích ngắn.

---

### Câu 5 — quan trọng nhất

Dataset hiện tại có:

> **1 row = 1 order**

Nếu sau này dataset thay đổi thành:

| Order ID | Product | Quantity | Revenue |
| --- | --- | --- | --- |
| O001 | Laptop | 1 | 20M |
| O001 | Mouse | 2 | 1M |
| O002 | Laptop | 1 | 22M |

Manager hỏi:

> **Có bao nhiêu đơn hàng?**

Nếu bạn tạo Pivot:

```
Rows   → Region
Values → Count of Order ID
```

thì vấn đề gì có thể xảy ra?