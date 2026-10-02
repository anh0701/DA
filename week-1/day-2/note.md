# Day 2 — Excel + Data Handling

## 1. Trước hết: Excel được dùng để làm gì trong công việc DA?

Một quy trình rất thường gặp:

```
Raw data
   ↓
Kiểm tra dữ liệu
   ↓
Làm sạch
   ↓
Tính toán / phân tích
   ↓
Pivot / Chart
   ↓
Insight
```

Ví dụ công ty đưa cho bạn file:

| Order ID | Date | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- | --- |
| O001 | 01/09/2026 | Laptop | North | 1 | 20000000 |
| O002 | 01/09/2026 | Mouse | South | 2 | 500000 |
| O003 | 02/09/2026 | Laptop | North | 1 | 22000000 |

Manager hỏi:

> Tháng này doanh thu bao nhiêu?
> Khu vực nào bán nhiều nhất?
> Sản phẩm nào bán tốt nhất?

Trước khi trả lời, bạn phải biết **dataset có sạch và hiểu đúng cấu trúc hay chưa**.

---

## 2. Dataset trong Excel

Một bảng dữ liệu tốt thường có dạng:

```
1 row = 1 observation / 1 record
1 column = 1 attribute
```

Ví dụ:

| Order ID | Date | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- | --- |
| O001 | 01/09/2026 | Laptop | North | 1 | 20000000 |
| O002 | 01/09/2026 | Mouse | South | 2 | 500000 |
| O003 | 02/09/2026 | Laptop | North | 1 | 22000000 |

### Column

Mỗi column đại diện cho một thuộc tính:

```
Order ID
Date
Product
Region
Quantity
Price
```

### Row

Mỗi row là một record.

Ví dụ:

```
O001 | 01/09/2026 | Laptop | North | 1 | 20M
```

là một record.

**Đừng nhầm row trong Excel với business entity.**

Ví dụ hôm qua ta đã học:

```
order_items
```

có thể:

```
O001 | Laptop
O001 | Mouse
O001 | Keyboard
```

3 rows nhưng chỉ có **1 order**.

Đây chính là lý do phải hiểu **granularity**.

---

## 3. Data types

Một việc DA phải làm thường xuyên là kiểm tra kiểu dữ liệu.

Ví dụ:

| Column | Kiểu dữ liệu |
| --- | --- |
| Order ID | Text |
| Date | Date |
| Product | Text |
| Region | Text |
| Quantity | Number |
| Price | Number |

Điều này rất quan trọng.

Ví dụ `Price` đáng lẽ là:

```
20000000
22000000
15000000
```

nhưng file lại chứa:

```
20M
22M
15M
```

Excel có thể coi chúng là **text**, lúc đó các phép tính có thể không hoạt động như bạn mong muốn.

---

## 4. Sort và Filter

Đây là hai thao tác cực kỳ quan trọng.

### Sort

Sắp xếp dữ liệu.

Ví dụ muốn xem sản phẩm có giá cao nhất:

```
Price ↓
```

Kết quả:

| Product | Price |
| --- | --- |
| Laptop | 22M |
| Laptop | 20M |
| Keyboard | 1M |
| Mouse | 500K |

Có thể sort:

- tăng dần
- giảm dần
- theo ngày
- theo alphabet

---

### Filter

Filter không xóa dữ liệu.

Nó chỉ **lọc những dòng bạn muốn xem**.

Ví dụ:

```
Region = North
```

thì chỉ còn:

| Order ID | Product | Region |
| --- | --- | --- |
| O001 | Laptop | North |
| O003 | Laptop | North |

Dữ liệu South vẫn tồn tại.

---

## 5. Tại sao Filter quan trọng với DA?

Giả sử manager hỏi:

> Doanh thu ở miền Bắc là bao nhiêu?

Bạn có thể:

```
Filter Region = North
        ↓
xem các record
        ↓
tính revenue
```

Nhưng đây mới chỉ là cách thủ công.

Sau này chúng ta sẽ học:

```
SUMIFS()
Pivot Table
SQL
Power BI
```

để làm việc này hiệu quả hơn.

---

## 6. Công thức cơ bản đầu tiên

Giả sử:

| Quantity | Price |
| --- | --- |
| 2 | 500000 |

Doanh thu của dòng đó:

```
Quantity × Price
```

Trong Excel:

```
excel=E2*F2
```

Nếu:

```
E2 = Quantity
F2 = Price
```

thì kết quả:

```
1,000,000
```

Ta có thể tạo thêm column:

| Quantity | Price | Revenue |
| --- | --- | --- |
| 2 | 500000 | 1000000 |

Công thức:

```
excel=E2*F2
```

Sau đó kéo công thức xuống các dòng còn lại.

---

## 7. Một nguyên tắc rất quan trọng

**Đừng sửa dữ liệu gốc một cách tùy tiện.**

Ví dụ file gốc:

```
sales_raw.xlsx
```

Tốt hơn nên có:

```
sales_raw.xlsx
sales_analysis.xlsx
```

hoặc trong cùng workbook:

```
Raw Data
Cleaned Data
Analysis
```

Tại sao?

Vì nếu bạn sửa trực tiếp dữ liệu gốc rồi sau đó phát hiện mình sửa sai, rất khó truy lại.

Đây là tư duy **data handling**, không chỉ là thao tác Excel.

---

## 8. Những lỗi dữ liệu bạn cần bắt đầu để ý

Ví dụ dataset:

| Order ID | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20000000 |
| O002 | Mouse | South | 2 | 500000 |
| O003 | Laptop | north | 1 | 22000000 |
| O004 | Keyboard | South | -1 | 1000000 |
| O005 | Mouse |  | 2 | 500000 |
| O006 | Laptop | North | 1 | 20000000 |

Có khá nhiều vấn đề.

### Vấn đề 1 — `North` và `north`

```
North
north
```

Về mặt dữ liệu, Excel có thể coi chúng là hai giá trị khác nhau trong một số thao tác/phân tích.

Cần chuẩn hóa.

---

### Vấn đề 2 — Quantity = -1

```
Quantity = -1
```

Có thể là:

- dữ liệu lỗi
- hàng trả lại
- điều chỉnh tồn kho

**Không được tự động xóa.**

Phải hiểu business rule trước.

Đây là một tư duy rất quan trọng của DA:

> Data bất thường ≠ data sai.

---

### Vấn đề 3 — Region bị trống

```
O005 | Mouse | [blank] | 2 | 500000
```

Đây là missing value.

---

### Vấn đề 4 — Duplicate

```
O006 | Laptop | North | 1 | 20000000
```

trông giống O001.

Nhưng **không được nhìn giống nhau rồi kết luận là duplicate**.

Có thể hai đơn hàng khác nhau nhưng tình cờ có cùng thông tin sản phẩm.

Muốn xác định duplicate phải biết:

> Một record được xác định duy nhất bởi những column nào?

Đây lại quay về **granularity** của dataset.

---

## 9. Bài tập Day 2

Giả sử bạn nhận được dataset:

| Order ID | Date | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- | --- |
| O001 | 01/09/2026 | Laptop | North | 1 | 20000000 |
| O002 | 01/09/2026 | Mouse | South | 2 | 500000 |
| O003 | 02/09/2026 | Laptop | north | 1 | 22000000 |
| O004 | 02/09/2026 | Keyboard | South | -1 | 1000000 |
| O005 | 03/09/2026 | Mouse |  | 2 | 500000 |
| O006 | 03/09/2026 | Laptop | North | 1 | 20000000 |
| O007 | 04/09/2026 | Mouse | South | 3 | 500000 |

### Câu 1

Xác định data type hợp lý cho từng column:

```
Order ID:
Date:
Product:
Region:
Quantity:
Price:
```

### Câu 2

Có những vấn đề dữ liệu nào bạn phát hiện được?

Liệt kê từng vấn đề và giải thích.

### Câu 3

Nếu tạo thêm column `Revenue`, công thức Excel là gì?

### Câu 4

Không cần tính bằng Excel, hãy tính **total revenue** bằng tay.

Nhớ:

```
Revenue = Quantity × Price
```

### Câu 5

Manager hỏi:

> Tôi muốn xem riêng các đơn hàng ở South.

Bạn sẽ dùng **Sort hay Filter**? Tại sao?

### Câu 6 — quan trọng

Dòng này:

```
O004 | 02/09/2026 | Keyboard | South | -1 | 1000000
```

Bạn có xóa nó ngay không?

Nếu không, bạn sẽ làm gì trước?

---

## Day 2 — Phần thực hành Excel

Bây giờ tập trung vào những thao tác Excel mà Junior DA sẽ dùng rất thường xuyên:

1. Table
2. Sort
3. Filter
4. Freeze
5. Format
6. Kiểm tra dữ liệu trước khi phân tích

---

### 1. Convert dataset thành Excel Table

Giả sử bạn có:

| Order ID | Date | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- | --- |
| O001 | 01/09/2026 | Laptop | North | 1 | 20000000 |
| O002 | 01/09/2026 | Mouse | South | 2 | 500000 |
| O003 | 02/09/2026 | Laptop | North | 1 | 22000000 |

Thay vì để nó là một vùng cell bình thường, nên chuyển thành **Table**.

Trong Excel:

```
Select data
→ Ctrl + T
→ My table has headers
→ OK
```

Table giúp:

- tự động có filter
- thêm row dễ dàng
- công thức tự mở rộng
- dễ dùng với Pivot Table
- dễ tham chiếu dữ liệu

Ví dụ đặt tên:

```
SalesData
```

---

### 2. Sort

Ví dụ muốn tìm những đơn hàng có `Price` cao nhất:

```
Price
↓
Largest to Smallest
```

Kết quả:

```
22,000,000
20,000,000
20,000,000
1,000,000
500,000
```

#### Cẩn thận một lỗi rất nguy hiểm

Không được chỉ sort **một column** trong khi dataset có nhiều column.

Ví dụ ban đầu:

| Order ID | Product | Price |
| --- | --- | --- |
| O001 | Laptop | 20M |
| O002 | Mouse | 500K |
| O003 | Keyboard | 1M |

Nếu chỉ sort riêng `Price`, bạn có thể biến thành:

| Order ID | Product | Price |
| --- | --- | --- |
| O001 | Laptop | 500K |
| O002 | Mouse | 1M |
| O003 | Keyboard | 20M |

Dữ liệu bị **lệch giữa các column**.

Table giúp giảm đáng kể nguy cơ này vì Excel hiểu các row thuộc cùng một record.

---

### 3. Filter

Ví dụ:

```
Region = South
```

Excel chỉ hiển thị:

| Order ID | Product | Region |
| --- | --- | --- |
| O002 | Mouse | South |
| O004 | Keyboard | South |
| O007 | Mouse | South |

Các dòng khác **không bị xóa**.

Đây là điểm rất quan trọng:

> Filter ≠ Delete.

---

### 4. Filter để kiểm tra data quality

Filter không chỉ dùng để trả lời business question.

Nó còn dùng để **tìm dữ liệu bất thường**.

Ví dụ:

#### Tìm Quantity âm

Filter:

```
Quantity < 0
```

Có thể phát hiện:

```
O004 | Keyboard | -1
```

#### Tìm Region trống

Filter:

```
Region = Blank
```

Phát hiện:

```
O005 | Mouse | [blank]
```

#### Tìm các giá trị Region

Filter dropdown có thể cho bạn thấy:

```
North
north
South
(blank)
```

Ngay lập tức nhận ra:

```
North
north
```

có vấn đề về consistency.

---

### 5. Freeze Panes

Dataset có thể có vài nghìn dòng.

Ví dụ:

```
Row 1 = headers
Row 2
Row 3
...
Row 5000
```

Khi scroll xuống row 3000, bạn không còn thấy:

```
Order ID | Date | Product | Region | ...
```

Lúc đó rất khó biết column nào là gì.

Dùng:

```
View
→ Freeze Panes
→ Freeze Top Row
```

Header sẽ luôn nằm trên màn hình khi scroll.

Đây là thao tác nhỏ nhưng cực kỳ hữu ích khi làm dataset lớn.

---

### 6. Format dữ liệu

Ví dụ `Price`:

```
20000000
22000000
500000
```

Có thể format thành:

```
20,000,000
22,000,000
500,000
```

hoặc format tiền tệ tùy yêu cầu.

Nhưng nhớ một nguyên tắc:

> **Formatting không làm thay đổi bản chất dữ liệu.**

Ví dụ:

```
20,000,000
```

vẫn là số `20000000`.

Còn:

```
"20,000,000"
```

có thể là text.

Hai thứ nhìn giống nhau nhưng bản chất khác nhau.

---

### 7. Một workflow rất thực tế

Giả sử sáng nay bạn nhận file:

```
sales_september.xlsx
```

Đừng lập tức tạo chart.

Quy trình nên là:

```
1. Open file
       ↓
2. Kiểm tra columns
       ↓
3. Xác định mỗi row đại diện cho cái gì
       ↓
4. Kiểm tra data types
       ↓
5. Kiểm tra missing values
       ↓
6. Kiểm tra duplicate
       ↓
7. Kiểm tra giá trị bất thường
       ↓
8. Chuẩn hóa dữ liệu nếu cần
       ↓
9. Bắt đầu phân tích
```

Đây chính là tư duy **Data Handling** mà hôm nay chúng ta đang xây.

---

### 8. Một case nhỏ

Giả sử manager nói:

> "Doanh thu tháng 9 của từng khu vực là bao nhiêu?"

Bạn nhận được:

| Order ID | Date | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- | --- |
| O001 | 01/09 | Laptop | North | 1 | 20M |
| O002 | 01/09 | Mouse | South | 2 | 0.5M |
| O003 | 02/09 | Laptop | north | 1 | 22M |
| O004 | 02/09 | Keyboard | South | 1 | 1M |

Một người mới có thể lập tức:

```
SUM(Quantity × Price)
```

Nhưng DA nên dừng lại kiểm tra:

#### Question 1

`North` và `north` có phải cùng một region không?

#### Question 2

Granularity là gì?

```
1 row = ?
```

#### Question 3

Revenue có phải:

```
Quantity × Price
```

không?

#### Question 4

Có missing/invalid data không?

Sau khi xác nhận business rules rồi mới phân tích.

---

### 9. Bài tập cuối Day 2

Không cần mở Excel ngay, bạn có thể trả lời bằng lý thuyết.

Dataset:

| Order ID | Product | Region | Quantity | Price |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20M |
| O002 | Mouse | South | 2 | 0.5M |
| O003 | Laptop | north | 1 | 22M |
| O004 | Keyboard | South | -1 | 1M |
| O005 | Mouse |  | 2 | 0.5M |

#### Câu 1

Bạn sẽ kiểm tra những gì **trước khi bắt đầu tính revenue theo Region**?

#### Câu 2

Nếu manager yêu cầu:

> "Chỉ xem những đơn hàng ở South"

Bạn dùng công cụ nào?

#### Câu 3

Nếu muốn tìm các record có `Quantity < 0`, bạn dùng Excel Filter như thế nào?

#### Câu 4

Tại sao `North` và `north` có thể gây vấn đề khi phân tích?

#### Câu 5

Nếu dataset có 50.000 dòng, tại sao **Freeze Top Row** hữu ích?

#### Câu 6 — quan trọng nhất

Manager hỏi:

> "North có revenue bao nhiêu?"

Bạn thấy:

```
North
north
```

Bạn **có cộng cả hai ngay không?**

Hãy giải thích cách bạn xử lý trước khi tính.
