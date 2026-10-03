# Day 6 — Data Cleaning trong Excel

Từ hôm nay chúng ta chuyển từ **“tính toán được”** sang **“đảm bảo dữ liệu đủ sạch để tính đúng”**.

Một DA không nên thấy:

```
North
north
NORTH
```

rồi lập tức coi chúng là 3 Region khác nhau.

## 1. Những lỗi dữ liệu thường gặp

### Missing value

Ví dụ:

| Order ID | Product | Region |
| --- | --- | --- |
| O001 | Laptop | North |
| O002 | Mouse |  |
| O003 | Laptop | South |

Region của O002 bị thiếu.

Không được tự ý:

`blank → North`

vì chưa có cơ sở.

Cần xác định **business rule** hoặc tìm nguồn dữ liệu khác.

---

### Inconsistent text

```
North
north
NORTH
North
```

Có thể về mặt business đều là một Region.

Các hàm hữu ích:

excel

`=TRIM(A2)`

Loại bỏ khoảng trắng thừa.

excel

`=UPPER(A2)`

→ NORTH

excel

`=LOWER(A2)`

→ north

excel

`=PROPER(A2)`

→ North

Nhưng hãy nhớ:

> **Cleaning format ≠ thay đổi business meaning.**

Ví dụ North và Noth không thể tự động kết luận là cùng một giá trị chỉ vì nhìn gần giống nhau.

---

## 2. Duplicate

Ví dụ:

| Order ID | Product | Quantity |
| --- | --- | --- |
| O001 | Laptop | 1 |
| O002 | Mouse | 2 |
| O002 | Mouse | 2 |

Có thể là duplicate.

Nhưng trước khi xóa, phải hỏi:

> **Hai dòng này thực sự là duplicate hay là hai giao dịch hợp lệ?**

Đây cũng giống nguyên tắc Day 2:

> **Không xóa dữ liệu bất thường chỉ vì nó “trông sai”.**

---

## 3. Data type

Ví dụ Quantity:

```
1
2
3
-1
```

là number.

Nhưng:

```
"1"
"2"
"3"
```

có thể đang là text.

Hoặc Revenue:

`20,000,000`

là số.

Trong khi:

`20M`

nếu nhập trực tiếp có thể là text.

Khi dữ liệu là text, các phép:

excel

`SUM()
AVERAGE()`

có thể cho kết quả không như mong muốn.

---

## 4. Một lỗi rất quan trọng: khoảng trắng

Giả sử:

```
A2 = "North"
A3 = "North "
```

Bạn nhìn bằng mắt gần như không nhận ra.

Nhưng:

excel

`=COUNTIF(A:A,"North")`

có thể không xử lý hai giá trị này như cùng một chuỗi.

Có thể dùng:

excel

`=TRIM(A2)`

để tạo một cột cleaned:

| Original | Cleaned |
| --- | --- |
| North | North |
| North | North |
| South | South |

**Tốt hơn là giữ lại cột gốc**, tạo cột cleaned để kiểm tra trước, thay vì phá dữ liệu nguồn ngay lập tức.

---

## 5. Data Cleaning Workflow

Khi nhận một dataset mới, bạn có thể đi theo thứ tự:

```
1. Understand the data
        ↓
2. Check data types
        ↓
3. Check missing values
        ↓
4. Check duplicates
        ↓
5. Check inconsistent values
        ↓
6. Check outliers / invalid values
        ↓
7. Apply business rules
        ↓
8. Validate cleaned data
        ↓
9. Analyze
```

---

## Bài tập Day 6

Cho dataset:

| Order ID | Product | Region | Quantity | Revenue |
| --- | --- | --- | --- | --- |
| O001 | Laptop | North | 1 | 20M |
| O002 | Mouse | south | 2 | 1M |
| O003 | Laptop | North | -1 | 22M |
| O004 | Keyboard | South | 1 | 1M |
| O005 | Mouse | South | 2 | 1M |
| O005 | Mouse | South | 2 | 1M |
| O006 | Laptop | North | 1 | 20M |
| O007 | Mouse |  | 3 | 1.5M |

### Task 1

Hãy liệt kê **tất cả data quality issues** mà bạn phát hiện.

---

### Task 2

Với:

`south`

bạn sẽ chuẩn hóa thành South bằng cách nào?

Viết công thức Excel.

---

### Task 3

Với:

`North`

bạn sẽ xử lý thế nào?

---

### Task 4

O005 xuất hiện hai dòng giống hệt nhau.

Bạn có **xóa ngay không?**

Nếu không, bạn sẽ làm gì trước?

---

### Task 5

O003 có:

`Quantity = -1`

Bạn sẽ làm gì?

---

### Task 6

O007 thiếu Region.

Bạn có tự điền North hoặc South không? Nếu không thì xử lý thế nào?

---

### Task 7 — câu quan trọng

Giả sử business xác nhận:

> south, South, SOUTH đều có nghĩa là **South**.

Sau cleaning, bạn muốn kiểm tra xem còn Region nào không hợp lệ.

Bạn sẽ kiểm tra như thế nào?

Hãy trả lời theo **tư duy DA**, không cần phải dùng đúng một công thức duy nhất.