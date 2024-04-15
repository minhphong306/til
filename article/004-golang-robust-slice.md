> https://go.dev/blog/generic-slice-functions

# Robust generic functions on slices
- `slices` package cũng cấp các functions để xử lý với tất cả các kiểu dữ liệu.
- Bài này nói về cách sử dụng các functions này một cách hiệu quả, hiểu xem slice được lưu thế nào trong RAM, ảnh hưởng thế nào đến Garbage collector; team Go đã update các functions liên quan đến slice gần đây thế nào để tránh việc gây ra các lỗi "surprising".

- Slice package bao gồm nhiều helper functions để xử lý slice

```golang
    s := []string{"Bat", "Fox", "Owl", "Fox"}
    s2 := slices.Clone(s)
    slices.Sort(s2)
    fmt.Println(s2) // [Bat Fox Fox Owl]
    s2 = slices.Compact(s2)
    fmt.Println(s2)                  // [Bat Fox Owl]
    fmt.Println(slices.Equal(s, s2)) // false
```
- Trước tiên, hãy hiểu về cấu tạo của slice:
    - Slice có thể hiểu là một phần của array.
    - Slice có 3 thuộc tính:
        - Con trỏ (pointer): trỏ tới vị trí của array lưu trữ value.
        - Độ dài (len)
        - Sức chứa (cap)
    - 2 slice có thể trỏ đến cùng 1 array và trỏ đến các vị trí khác nhau.

![Slice](images/004-slice.svg)
- Nếu 1 function thay đổi length của slice được pass như parameter, cần được return slice mới cho caller.Array phía dưới có thể giữ nguyên nếu nó không phát triển thêm. Điều này giải thích tại sao append và slices hoạt động.
    - `slice.Compact` trả về giá trị, `slice.Sort` lại không

## Xét ví dụ xóa 1 đoạn của slice
```
s = append(s[:2], s[5]...)
```
- Về cơ bản thì đoạn code trên sẽ xử lý:
    - Lấy 2 phần tử đầu tiên
    - Lấy từ phần tử số 5 đến cuối slice (len(slice))
