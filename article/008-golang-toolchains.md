> https://go.dev/doc/toolchain

# Introduction
- Từ phiên bản Go 1.21, khi cài Go sẽ bao gồm cả Go toolchain.
- Command `go` sẽ bao gồm cả Go toolchain.
- Để dùng Go toolchain thì có thể set GOTOOLCHAIN env variable hoặc thêm dòng `toolchain` trong file go.mod, hay `go.work`.
- Trong config tiêu chuẩn, `go` command sử dụng phiên bản go thấp nhất là bằng phiên bản go cài đặt trong máy, hoặc trong file module hoặc workspace( CLGT?)
    - Ví dụ, khi dùng go command bundled với go 1.21.3 thì ở trong main module 1.21.0, thì `go` command sẽ dùng bản 1.21.3.
- Nếu go hoặc toolchain mới hơn bundled toolchain, `go` command sẽ sử dụng bản toolchain mới hơn này.
    - Ví dụ: go command bundled với Go 1.21.3, main module go 1.21.9 thì go command sẽ sử dụng Go 1.21.9
        - Đầu tiên, nó sẽ tìm trong PATH xem có bin nào là go1.21.9 không, nếu không có thì sẽ download và cache một bản copy của Go 1.21.9 lại.
- Automatic toolchain switching này có thể được disable đi, nhưng trong trừong hợp này, để tương thích ngược thì go command sẽ từ chối chạy trong các module hoặc workspace mà có go version cao hơn. Vì dòng `go` trong go.mod định nghĩa phiên bản go thấp nhất mà project hoặc module hoặc workspace cần.
- Các module thì phụ thuộc vào module khác. Module khác này có thể yêu cầu phiên bản Go thấp nhất thấp hơn the preferred toolchain. Trong trường hợp này, dòng `toolchain` trong file go.mod hoặc go.work sẽ được ưu tiên để quyết định sẽ dùng toolchain nào.
- 