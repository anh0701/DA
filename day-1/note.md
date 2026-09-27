# DAY 1 — Data Analyst Mindset

**Mục tiêu:** Hiểu được một Data Analyst thực sự làm gì, và phân biệt được **data / metric / KPI / dimension / measure / granularity**.

---

## 1. Data Analyst thực sự làm gì?

Một hiểu lầm phổ biến là:

> Data Analyst = biết SQL + biết Power BI.

SQL và Power BI chỉ là **tools**.

Công việc cốt lõi là:

```
Business Question
       ↓
Understand Data
       ↓
Query / Collect Data
       ↓
Clean Data
       ↓
Analyze
       ↓
Find Insight
       ↓
Visualize
       ↓
Communicate
```

Ví dụ công ty hỏi:

> "Doanh thu tháng này giảm. Tại sao?"

Bạn không nên lập tức mở SQL rồi `SELECT SUM(revenue)`.

Bạn cần suy nghĩ:

```
Revenue giảm?
      ↓
So với thời gian nào?
      ↓
Giảm bao nhiêu?
      ↓
Do số lượng đơn giảm?
      ↓
Hay giá trị mỗi đơn giảm?
      ↓
Region nào giảm?
      ↓
Product nào giảm?
      ↓
Customer segment nào giảm?
      ↓
Có nguyên nhân nào khác?
```

Đó chính là **analytical thinking**.

---

## 2. Khái niệm đầu tiên: Data

**Data** là những dữ liệu thô được ghi nhận từ hoạt động của hệ thống/business.

Ví dụ một bảng `orders`:

| order_id | date | customer | product | quantity | price | region |
| --- | --- | --- | --- | --- | --- | --- |
| O001 | 2026-01-02 | C001 | Laptop | 1 | 20M | North |
| O002 | 2026-01-02 | C002 | Mouse | 2 | 500K | South |
| O003 | 2026-01-03 | C001 | Keyboard | 1 | 1M | North |

Đây là **raw transactional data**.

Từ nó, chúng ta có thể tạo ra:

```
Total Revenue
Total Orders
Average Order Value
Revenue by Region
Revenue by Product
```

---

## 3. Measure là gì?

**Measure** là một giá trị có thể đo lường/tính toán từ dữ liệu.

Ví dụ:

```
Revenue
Quantity
Profit
Orders
Customers
Cost
```

Ví dụ:

```
Quantity = 1,250
Revenue = 250,000,000
Orders = 532
```

Đó là các **measures**.

Một measure thường có aggregation:

```
SUM
COUNT
AVG
MIN
MAX
```

Ví dụ:

```
SUM(revenue)
COUNT(order_id)
AVG(price)
```

---

## 4. Dimension là gì?

Nếu **measure** trả lời:

> "Bao nhiêu?"

thì **dimension** thường giúp trả lời:

> "Theo cái gì?"

Ví dụ:

```
Region
Product
Category
Customer
Date
Gender
Department
```

Ví dụ:

```
Revenue
```

là measure.

Nhưng:

```
Revenue by Region
```

thì:

```
Revenue → Measure
Region  → Dimension
```

---

### Cách nhớ

```
Dimension                  Measure

Region                     Revenue
Product                    Quantity
Category                   Profit
Customer                   Orders
Date                       Cost
```

Có thể nhớ đơn giản:

> **Measure = cái mình đo.**
> **Dimension = cách mình chia nhỏ dữ liệu để xem.**

---

## 5. Metric là gì?

`Metric` gần giống measure nhưng trong business thường mang nghĩa rộng hơn: **một chỉ số được dùng để theo dõi/đánh giá một khía cạnh nào đó**.

Ví dụ:

```
Revenue
Orders
Conversion Rate
Customer Retention
Defect Rate
Profit Margin
```

Ví dụ:

```
Revenue = 10 tỷ
Conversion Rate = 4.2%
Defect Rate = 1.8%
```

đều có thể được gọi là **metrics**.

Điều quan trọng là hiểu:

```
Raw Data
   ↓
Calculation
   ↓
Metric
```

---

## 6. KPI là gì?

Đây là khái niệm quan trọng hơn.

**KPI = Key Performance Indicator**

Không phải metric nào cũng là KPI.

Ví dụ công ty đặt mục tiêu:

> Doanh thu quý này phải đạt 10 tỷ.

Thì:

```
Revenue
```

là một metric.

Nhưng nếu công ty chính thức dùng nó để đánh giá performance:

```
Target = 10B
Actual = 8.5B
```

thì Revenue có thể trở thành **KPI**.

Ví dụ:

```
Metric:
Number of orders

KPI:
Monthly revenue target
```

KPI thường gắn với:

```
Target
Performance
Business objective
```

---

## 7. Granularity — cực kỳ quan trọng

**Granularity = mức độ chi tiết của một record.**

Ví dụ bảng:

```
orders
```

Nếu:

> Mỗi dòng = một order

thì:

```
Granularity = one row per order
```

Ví dụ:

| order_id | customer | amount |
| --- | --- | --- |
| O001 | C001 | 100 |
| O002 | C001 | 200 |
| O003 | C002 | 500 |

Mỗi dòng là **một order**.

---

Nhưng bảng khác:

```
daily_sales
```

có thể:

> Mỗi dòng = một ngày + một product.

| date | product | revenue |
| --- | --- | --- |
| Jan 1 | A | 1000 |
| Jan 1 | B | 2000 |
| Jan 2 | A | 1500 |

Granularity là:

```
one row per day per product
```

---

#### Tại sao granularity quan trọng?

Giả sử:

```
orders
```

có:

```
1 row = 1 order
```

thì:

```
SQLCOUNT(order_id)
```

có thể dùng để đếm order.

Nhưng nếu bảng đã được JOIN với bảng order items:

```
Order O001
    ↓
Laptop
Mouse
Keyboard
```

thì một order có thể xuất hiện 3 dòng.

Nếu bạn:

```
SQLCOUNT(order_id)
```

thì có thể đếm thành:

```
3 orders
```

trong khi thực tế chỉ có:

```
1 order
```

---

## 8. Fact và Dimension

Ví dụ database bán hàng:

```
                customers
                    │
                    │
                    ↓
products ───── orders ───── dates
```

`orders` thường chứa những sự kiện/giao dịch:

```
order_id
customer_id
product_id
date_id
quantity
revenue
```

Đây thường là **Fact**.

Còn:

```
customers
products
dates
regions
```

thường là **Dimensions**.

---

## 9. Bài tập

Bây giờ **không cần SQL**.

Hãy tưởng tượng bạn được đưa bảng sau:

| order_id | date | customer | product | category | quantity | price | region |
| --- | --- | --- | --- | --- | --- | --- | --- |
| O001 | 2026-01-02 | C001 | Laptop | Electronics | 1 | 20000000 | North |
| O002 | 2026-01-02 | C002 | Mouse | Accessories | 2 | 500000 | South |
| O003 | 2026-01-03 | C001 | Keyboard | Accessories | 1 | 1000000 | North |
| O004 | 2026-01-04 | C003 | Laptop | Electronics | 1 | 22000000 | South |
| O005 | 2026-01-05 | C002 | Monitor | Electronics | 1 | 5000000 | South |
| O006 | 2026-01-05 | C004 | Mouse | Accessories | 3 | 450000 | North |

Giả sử:

```
Revenue = quantity × price
```

#### Task 1

Xác định:

**Dimension nào xuất hiện trong bảng?**

Gợi ý:

```
date
customer
product
category
region
```

---

#### Task 2

Xác định các **measure** có thể tính.

Ví dụ:

```
quantity
revenue
```

Bạn tự tìm thêm.

---

#### Task 3

Hãy đưa ra **5 câu hỏi business** mà Data Analyst có thể trả lời từ dataset này.

Ví dụ:

> Which region generates the highest revenue?

Nhưng bạn phải tự nghĩ thêm 4 câu.

---

#### Task 4

Tính bằng tay:

```
Revenue của O001
Revenue của O002
Revenue của O003
Revenue của O004
Revenue của O005
Revenue của O006
```

Công thức:

```
Revenue = Quantity × Price
```

Sau đó tính:

```
Total Revenue
Total Quantity
```

---

#### Task 5 — quan trọng nhất

Giả sử manager hỏi:

> **"Region nào đang tạo ra nhiều revenue nhất?"**

Đừng chỉ trả lời bằng con số.

Hãy viết theo format:

```
Question:
...

Analysis:
...

Result:
...

Business Insight:
...
```

---

## 10. Bài kiểm tra cuối ngày

**1.** Data Analyst khác Software Developer ở điểm nào về mục tiêu công việc?

**2.** `Revenue` là measure hay dimension?

**3.** `Region` là measure hay dimension?

**4.** KPI khác metric như thế nào?

**5.** Granularity của bảng `orders` nếu mỗi dòng là một order là gì?

**6.** Nếu một order có 5 sản phẩm và sau JOIN bảng order items thì order đó xuất hiện mấy dòng?

**7.** Tại sao việc biết granularity quan trọng khi phân tích dữ liệu?

**8.** Từ bảng trên, hãy đưa ra **5 business questions** mà một Data Analyst có thể phân tích.

---
