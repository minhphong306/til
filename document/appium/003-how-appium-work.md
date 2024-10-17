> https://appium.io/docs/en/latest/intro/appium/

- Như bài trước đã nói, Appium có các mục tiêu chính sau:
    - Xây dựng chuẩn chung cho các platform khác nhau.
    - Cung cấp các API cho phép truy cập từ bất kì ngôn ngữ lập trình nào.
    - Cung cấp các tools để cộng đồng dễ dàng phát triển các extension.

- Có rất nhiều câu hỏi được đặt ra như:
    - Làm thế để có API chung giữa nhiều Platform?
    - Làm thế nào để map một automation behaviour tới một platform cụ thể?
    - Làm thế nào để API có thể truy cập được từ tất cả ngôn ngữ?
    - Làm thế nào để automation trên tất cả các platform?

# Cách Appium thiết kế các API
- Rất may mắn là Appium có Selenium đi trước, chuẩn hoá mọi thứ rồi.
- Appium chọn follow theo conventions của Selenium cho nhanh.
- Có vấn đề là: Selenium thì cho web, còn Appium thì cho mobile là chính. Nếu dùng luôn conventions của Selenium liệu có hợp lí không?
    - Ví dụ như trên app đâu có get cookie, set cookie?
    - Ví dụ như trên app cần có thêm các tính năng mà web không có: automation cho TV cần có chức năng của điều khiển từ xa chẳng hạn.
    - Mấy câu này được trả lời ở phần dưới

# Platform automation behaviour
- Cách đẹp trai nhất để giải quyết các vấn đề trên là đưa phần riêng vào từng driver. Driver sẽ implement các phần chung và bổ sung các phương thức riêng cho từng nền tảng.
- Một số platform sẽ hỗ trợ thư viện test riêng, ví dụ iOS có thư viện XCUITest. Driver iOS của Appium thực chất là wrap lại thư viện này.

# Không giới hạn truy cập từ các ngôn ngữ
- Appium thiết kế kiểu HTTP-based. Do vậy mà bạn code bằng ngôn ngữ nào không quan trọng. Gọi đúng API của Appium là được.
- Việc này rất tiện, đặc biệt bạn muốn đưa automation lên cloud. Dùng ngôn ngữ nào cũng được hết.
- Có vẻ Appium là một thư viện, cung cấp tính năng automation. Không phải một framework testing hoàn chỉnh.

# Appium's huge scope 
- Vì tham vọng của Appium là automation trên tất cả các platform, nên phạm vi công việc cực lớn.
- Do vậy mà hướng đi của Appium sẽ là để cộng đồng maintain. Thiết kế driver và CLI để mọi người có thể dễ dàng phát triển, chia sẻ và maintain.