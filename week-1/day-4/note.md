# Day 4 — IF, IFS, IFERROR, XLOOKUP

## 1. `IF()` — đưa ra kết quả dựa trên điều kiện

Cú pháp:

```
excel=IF(condition, value_if_true, value_if_false)
```

Ví dụ dataset:

| Product | Quantity | Revenue |
| --- | --- | --- |
| Laptop | 1 | 20M |
| Mouse | 2 | 1M |
| Laptop | 1 | 22M |

Manager muốn phân loại:

> Revenue >= 10M → High
> Revenue < 10M → Low

Công thức:

```
excel=IF(C2>=10000000,"High","Low")
```

Kết quả:

| Revenue | Level |
| --- | --- |
| 20M | High |
| 1M | Low |
| 22M | High |

---

## 2. IF không chỉ dùng với số

Có thể kiểm tra text.

Ví dụ:

```
excel=IF(C2="North","Northern Region","Other")
```

Nếu C2 là `North`:

```
Northern Region
```

Nếu không:

```
Other
```

Có thể dùng các toán tử:

```
=
>
<
>=
<=
<>
```

Trong đó:

```
<>
```

nghĩa là **khác**.

---

## 3. `IF()` với nhiều điều kiện

Ví dụ:

```
Revenue >= 20M → High
Revenue >= 10M → Medium
Revenue < 10M → Low
```

Có thể viết:

```
excel=IF(C2>=20000000,"High",
   IF(C2>=10000000,"Medium","Low"))
```

Nhưng khi có nhiều mức, công thức sẽ bắt đầu rất khó đọc.

Đó là lúc `IFS()` hữu ích.

---

## 4. `IFS()`

Cú pháp:

```
excel=IFS(
    condition1, result1,
    condition2, result2,
    condition3, result3
)
```

Ví dụ:

```
excel=IFS(
    C2>=20000000,"High",
    C2>=10000000,"Medium",
    C2<10000000,"Low"
)
```

Kết quả:

```
20M → High
15M → Medium
5M  → Low
```

### IF vs IFS

| Trường hợp | Dùng |
| --- | --- |
| 2 trường hợp | `IF` |
| Một vài điều kiện | `IF` lồng nhau |
| Nhiều mức phân loại | `IFS` |

---

## 5. `IFERROR()`

Đây là hàm rất hữu ích khi làm data.

Ví dụ:

```
excel=A2/B2
```

Nếu:

```
B2 = 0
```

Excel sẽ trả:

```
#DIV/0!
```

Có thể xử lý:

```
excel=IFERROR(A2/B2,0)
```

Nếu phép tính thành công:

```
100 / 10 → 10
```

Nếu lỗi:

```
100 / 0 → 0
```

---

### Nhưng đừng dùng IFERROR để che lỗi dữ liệu

Ví dụ:

```
excel=IFERROR(A2/B2,0)
```

có thể làm bảng nhìn "sạch", nhưng bạn không biết tại sao B2 = 0.

Trong Data Analysis:

> **Xử lý error không có nghĩa là bỏ qua nguyên nhân của error.**

Nếu `0` là dữ liệu hợp lệ → xử lý bằng `IFERROR` có thể hợp lý.

Nếu `0` xuất hiện vì dữ liệu bị lỗi → cần điều tra.

---

## 6. Bây giờ đến XLOOKUP

Giả sử chúng ta có **hai bảng**.

### Bảng Orders

| Order ID | Product ID | Quantity |
| --- | --- | --- |
| O001 | P01 | 1 |
| O002 | P02 | 2 |
| O003 | P01 | 1 |
| O004 | P03 | 1 |

### Bảng Products

| Product ID | Product | Category | Price |
| --- | --- | --- | --- |
| P01 | Laptop | Computer | 20M |
| P02 | Mouse | Accessory | 0.5M |
| P03 | Keyboard | Accessory | 1M |

Orders chỉ có:

```
Product ID
```

nhưng chúng ta muốn biết:

```
Product
Category
Price
```

Đây là lúc `XLOOKUP` xuất hiện.

---

## 7. XLOOKUP cơ bản

Cú pháp:

```
excel=XLOOKUP(
    lookup_value,
    lookup_array,
    return_array
)
```

Muốn tìm tên Product dựa vào `Product ID`:

```
excel=XLOOKUP(
    B2,
    Products!A:A,
    Products!B:B
)
```

Nghĩa là:

```
B2
 ↓
tìm trong Products!A:A
 ↓
tìm thấy P01
 ↓
lấy giá trị tương ứng từ Products!B:B
 ↓
Laptop
```

---

## 8. Tư duy của XLOOKUP

Bạn có:

```
P01
```

Excel sẽ:

```
P01
 ↓
tìm P01 trong Product ID
 ↓
P01 nằm ở row 2
 ↓
lấy Product ở row 2
 ↓
Laptop
```

Kết quả:

| Order ID | Product ID | Product |
| --- | --- | --- |
| O001 | P01 | Laptop |
| O002 | P02 | Mouse |
| O003 | P01 | Laptop |
| O004 | P03 | Keyboard |

---

## 9. XLOOKUP để lấy Price

Ta có thể dùng:

```
excel=XLOOKUP(
    B2,
    Products!A:A,
    Products!D:D
)
```

Kết quả:

| Product ID | Price |
| --- | --- |
| P01 | 20M |
| P02 | 0.5M |
| P01 | 20M |
| P03 | 1M |

Sau đó:

```
excel=Quantity * Price
```

là có Revenue.

---

## 10. XLOOKUP khi không tìm thấy dữ liệu

Ví dụ Orders có:

```
P99
```

nhưng Products không có `P99`.

XLOOKUP có thể trả lỗi.

Bạn có thể chỉ định giá trị nếu không tìm thấy:

```
excel=XLOOKUP(
    B2,
    Products!A:A,
    Products!B:B,
    "Not Found"
)
```

Kết quả:

```
P99 → Not Found
```

Thay vì:

```
#N/A
```

---

## 11. XLOOKUP và tư duy JOIN

Trong Excel:

```
excel=XLOOKUP(...)
```

có thể dùng để lấy thông tin liên quan từ bảng khác.

Trong SQL, tư duy tương tự sẽ là:

```
SQLSELECT
    o.order_id,
    o.product_id,
    p.product,
    p.price
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;
```

Không phải hai cái **hoàn toàn tương đương về kỹ thuật**, nhưng về tư duy dữ liệu:

```
Bảng A
   ↓
có key
   ↓
tìm record tương ứng
   ↓
lấy thông tin từ Bảng B
```

Đây là bước rất tốt để chuẩn bị cho **Day 12 — JOIN trong SQL** sau này.

---

## 12. Một vấn đề cực kỳ quan trọng với XLOOKUP

Giả sử bảng Products:

| Product ID | Product | Price |
| --- | --- | --- |
| P01 | Laptop | 20M |
| P01 | Laptop | 22M |

`P01` xuất hiện **2 lần**.

XLOOKUP sẽ không tự hiểu:

> "Có 2 record, vậy tôi phải làm gì?"

Nó sẽ lấy một kết quả theo cơ chế của XLOOKUP, nhưng vấn đề thực sự nằm ở **data quality / uniqueness của key**.

Vì vậy trước khi lookup, phải biết:

> `Product ID` có thực sự unique không?

Đây cũng chính là tư duy **data modeling + data quality**.

---

## 13. Tóm tắt Day 4

| Hàm | Mục đích |
| --- | --- |
| `IF()` | Điều kiện |
| `IFS()` | Nhiều mức điều kiện |
| `IFERROR()` | Xử lý kết quả lỗi |
| `XLOOKUP()` | Tìm dữ liệu từ bảng khác |

Tư duy:

```
IF
→ Nếu điều kiện đúng/sai thì làm gì?

IFS
→ Có nhiều trường hợp thì phân loại thế nào?

IFERROR
→ Nếu phép tính/lookup lỗi thì xử lý thế nào?

XLOOKUP
→ Muốn lấy thông tin từ bảng khác dựa trên key nào?
```

---

## Bài tập Day 4

Có hai bảng.

### Orders

| Order ID | Product ID | Quantity |
| --- | --- | --- |
| O001 | P01 | 1 |
| O002 | P02 | 2 |
| O003 | P01 | 1 |
| O004 | P03 | 1 |
| O005 | P99 | 2 |

### Products

| Product ID | Product | Price |
| --- | --- | --- |
| P01 | Laptop | 20M |
| P02 | Mouse | 0.5M |
| P03 | Keyboard | 1M |

### Câu 1

Viết `IF()` để phân loại:

```
Quantity >= 2 → Bulk
Quantity < 2 → Normal
```

### Câu 2

Viết `IFS()` để phân loại Quantity:

```
>= 3 → High
>= 2 → Medium
< 2 → Low
```

### Câu 3

Nếu:

```
A2 = 100
B2 = 0
```

viết công thức tính `A2/B2` nhưng không để xuất hiện `#DIV/0!`.

### Câu 4

Viết `XLOOKUP()` để lấy `Product` từ `Product ID`.

### Câu 5

Viết `XLOOKUP()` để lấy `Price`.

### Câu 6

Order `O005` có `Product ID = P99`, nhưng Products không có P99.

Bạn sẽ để Excel trả `#N/A`, hay xử lý thành một giá trị khác? **Và tại sao?**

### Câu 7 — quan trọng

Nếu `Product ID = P01` xuất hiện **2 lần** trong bảng Products với hai mức giá khác nhau, bạn có lập tức dùng XLOOKUP rồi tin vào kết quả không?

Giải thích bạn sẽ kiểm tra gì trước.