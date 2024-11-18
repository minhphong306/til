> https://open.larksuite.com/document/server-docs/getting-started/getting-started

# Các bước
- Tạo app
- Get access token
- Apply cho API scope
- Cấu hình data permission
- Set IP whitelist
- Gọi API

# Access token
- Có khá nhiều loại:
    - tenant_access_token: token dùng để gọi API dưới vai trò app. Token bắt đầu bởi `t-`
    - user_access_token: token để gọi API dưới vai trò user. Bắt đầu bởi `u-`. Cần user authorization
    - app_access_token: token ngắn hạn, dùng để open platform xác định người gọi app, dựa trên app_access_token.
- Cách chọn access token:
    - Kiểm tra xem API support loại token nào.
    - Format: Thêm vào header Bearer `access token`
        - Content-Type: `application/json; charset=utf-8`
    - Vì app_access_token khá ít dùng (thường để get user_access_token và refresh_user_access_token) nên Lark đang có kế hoạch migrate lại thành 2 loại user và tenant token thôi.
    - Chọn tenant_access_token: nếu app không cần truy cập dữ liệu của người dùng.
    - Chọn user_access_token: nếu cần lấy dữ liệu từ người dùng (VD: tạo document ở thư mục của user).
# Permission scope