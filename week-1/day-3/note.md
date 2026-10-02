# Day 3 — Excel Functions

## 1. Dataset hôm nay

Ta dùng dataset nhỏ này:

| Order ID | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20M |
| O002 | Mouse | South | 2 | 0.5M |
| O003 | Laptop | North | 1 | 22M |
| O004 | Keyboard | South | 1 | 1M |
| O005 | Mouse | South | 2 | 0.5M |
| O006 | Laptop | North | 1 | 20M |
| O007 | Mouse | South | 3 | 0.5M |

Ta có thể thêm:

```
Revenue = Quantity × Price
```

| Order ID | Quantity | Price | Revenue |
| --- | --- | --- | --- |
| O001 | 1 | 20M | 20M |
| O002 | 2 | 0.5M | 1M |
| O003 | 1 | 22M | 22M |
| O004 | 1 | 1M | 1M |
| O005 | 2 | 0.5M | 1M |
| O006 | 1 | 20M | 20M |
| O007 | 3 | 0.5M | 1.5M |

---

## 2. `SUM()` — tính tổng

Đây là hàm cơ bản nhất.

Nếu `Revenue` nằm ở cột G:

```
excel=SUM(G2:G8)
```

Nó sẽ cộng toàn bộ Revenue.

Kết quả:

```
66.5M
```

### Khi nào dùng?

Khi bạn cần tổng:

```
Total Revenue
Total Quantity
Total Cost
...
```

Ví dụ:

```
excel=SUM(D2:D8)
```

→ tổng quantity.

---

## 3. `AVERAGE()` — tính trung bình

```
excel=AVERAGE(G2:G8)
```

Tính Revenue trung bình trên **các dòng**.

Điểm cần chú ý:

> `AVERAGE()` tính trung bình theo các giá trị trong range, không tự hiểu "trung bình mỗi order" hay "trung bình mỗi customer".

Ví dụ dataset có nhiều dòng thuộc cùng một order:

```
O001 | Laptop
O001 | Mouse
O001 | Keyboard
```

thì `AVERAGE()` trên các dòng này đang tính average theo **row**, không phải average theo order.

Đây lại là vấn đề **granularity** mà Day 1 chúng ta đã học.

---

## 4. `COUNT()` — đếm số

```
excel=COUNT(D2:D8)
```

`COUNT()` đếm **các ô chứa số**.

Ví dụ:

```
1
2
1
1
2
1
3
```

→ `COUNT()` = 7.

### Nhưng:

`COUNT()` không đếm text.

Ví dụ:

| Order ID |
| --- |
| O001 |
| O002 |
| O003 |

```
excel=COUNT(A2:A4)
```

→ `0`

vì `Order ID` là text.

---

## 5. `COUNTA()` — đếm ô không trống

```
excel=COUNTA(A2:A8)
```

`COUNTA()` đếm các ô **không rỗng**, bất kể là:

- text
- number
- date

Ví dụ:

| Order ID |
| --- |
| O001 |
| O002 |
| O003 |
| O004 |

`COUNTA()` → 4.

---

### `COUNT()` vs `COUNTA()`

Đây là cặp rất dễ nhầm.

| Hàm | Đếm |
| --- | --- |
| `COUNT()` | ô chứa số |
| `COUNTA()` | ô không trống |

Ví dụ:

| A |
| --- |
| O001 |
| 100 |
| O003 |
| 200 |
| *(blank)* |

```
excelCOUNT(A1:A5)
```

→ `2`

```
excelCOUNTA(A1:A5)
```

→ `4`

---

## 6. `MIN()` và `MAX()`

Tìm giá trị nhỏ nhất:

```
excel=MIN(G2:G8)
```

Tìm giá trị lớn nhất:

```
excel=MAX(G2:G8)
```

Ví dụ Revenue:

```
20M
1M
22M
1M
1M
20M
1.5M
```

thì:

```
MIN = 1M
MAX = 22M
```

Có thể dùng để trả lời:

> Đơn hàng có revenue thấp nhất là bao nhiêu?

> Revenue cao nhất là bao nhiêu?

---

## 7. Đây mới là phần quan trọng: `SUMIF()`

Các hàm trên đều tính trên **toàn bộ range**.

Nhưng business question thường có điều kiện.

Ví dụ:

> Doanh thu ở North là bao nhiêu?

Ta cần:

```
Region = North
```

và cộng Revenue.

Công thức:

```
excel=SUMIF(C2:C8,"North",G2:G8)
```

Cấu trúc:

```
SUMIF(
    range,
    criteria,
    sum_range
)
```

Trong ví dụ:

```
C2:C8 = Region
"North" = điều kiện
G2:G8 = Revenue cần cộng
```

Kết quả:

```
62M
```

---

## 8. `COUNTIF()`

Ví dụ manager hỏi:

> Có bao nhiêu đơn hàng ở South?

Ta có:

```
excel=COUNTIF(C2:C8,"South")
```

Kết quả:

```
4
```

Cấu trúc:

```
COUNTIF(
    range,
    criteria
)
```

Nó không cộng tiền.

Nó **đếm số cell thỏa điều kiện**.

---

## 9. `SUMIFS()` — nhiều điều kiện

Đây là hàm rất đáng học vì business questions thường có nhiều điều kiện.

Ví dụ:

> Revenue của Laptop ở North là bao nhiêu?

Điều kiện:

```
Product = Laptop
Region = North
```

Công thức:

```
excel=SUMIFS(
    G2:G8,
    B2:B8,"Laptop",
    C2:C8,"North"
)
```

Cấu trúc:

```
SUMIFS(
    sum_range,
    criteria_range1, criteria1,
    criteria_range2, criteria2,
    ...
)
```

Ở đây:

```
G2:G8       → Revenue
B2:B8       → Product
"Laptop"    → điều kiện 1
C2:C8       → Region
"North"     → điều kiện 2
```

---

## 10. `COUNTIFS()` — nhiều điều kiện để đếm

Ví dụ:

> Có bao nhiêu dòng là Laptop ở North?

```
excel=COUNTIFS(
    B2:B8,"Laptop",
    C2:C8,"North"
)
```

Kết quả:

```
3
```

---

## 11. Nhìn business question → chọn hàm

Đây là phần bạn nên nhớ nhất hôm nay.

| Business question | Hàm |
| --- | --- |
| Tổng revenue? | `SUM()` |
| Revenue trung bình? | `AVERAGE()` |
| Có bao nhiêu giá trị số? | `COUNT()` |
| Có bao nhiêu ô có dữ liệu? | `COUNTA()` |
| Revenue thấp nhất? | `MIN()` |
| Revenue cao nhất? | `MAX()` |
| Revenue ở North? | `SUMIF()` |
| Có bao nhiêu dòng ở North? | `COUNTIF()` |
| Revenue của Laptop ở North? | `SUMIFS()` |
| Có bao nhiêu Laptop ở North? | `COUNTIFS()` |

Tư duy nên là:

```
Business question
       ↓
Có cần điều kiện không?
       ↓
Không → SUM / COUNT / AVERAGE...
Có 1 điều kiện → SUMIF / COUNTIF
Có nhiều điều kiện → SUMIFS / COUNTIFS
```

---

## 12. Một cái bẫy quan trọng

Quay lại bài Day 1.

Nếu dataset:

```
O001 | Laptop
O001 | Mouse
O001 | Keyboard
O002 | Laptop
```

thì:

```
excel=COUNT(A2:A5)
```

không phải là số order.

Nó đang đếm số **row chứa order_id**.

Muốn đếm order duy nhất trong Excel, sau này ta sẽ học cách xử lý bằng:

- `UNIQUE()`
- Pivot Table
- hoặc các cách khác.

Và khi sang SQL, nó sẽ tương ứng với:

```
SQLCOUNT(DISTINCT order_id)
```

Đây là lý do kiến thức **granularity của Day 1** tiếp tục xuất hiện ở Day 3.

---

## Bài tập Day 3

Dùng dataset trên.

### Câu 1

Viết công thức tính:

> Tổng Quantity

---

### Câu 2

Viết công thức tính:

> Tổng Revenue

---

### Câu 3

Viết công thức tính:

> Revenue trung bình của tất cả các dòng

---

### Câu 4

Viết công thức:

> Có bao nhiêu dòng có Quantity?

---

### Câu 5

Viết công thức:

> Có bao nhiêu dòng thuộc Region = `South`?

---

### Câu 6

Viết công thức:

> Tổng Revenue của Region = `South`

---

### Câu 7

Viết công thức:

> Tổng Revenue của Product = `Laptop` và Region = `North`

---

### Câu 8 — tư duy DA

Manager hỏi:

> "Có bao nhiêu order ở South?"

Bạn **có dùng ngay**:

```
excel=COUNTIF(C2:C8,"South")
```

không?

Nếu không, giải thích tại sao.

Câu 8 liên kết trực tiếp với bài **`COUNT` vs `COUNT(DISTINCT)` và granularity** hôm Day 1.