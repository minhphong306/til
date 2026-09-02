> https://appium.io/docs/en/latest/intro/history/

# Appium project history
- Appium ra đời khoảng năm 2012, dưới thời của các cá nhân và tổ chức khác nhau, đến nay đã phát triển trên 3 ngôn ngữ. 
- Bài này nói về lịch sử Appium.

# Cảm hứng
- Vấn đề
    - Dan Cuellar năm 2011 là Test Manager tại Zoosk.
    - Số lượng test trên thiết bị iOS ngày càng nhiều, khiến ông phải nghĩ cách.
    - Ông thử dùng tools của Apple là UIAutomation nhưng thấy nhiều điểm bất cập: bắt code bằng JS, không debug real-time được.
    - Tìm đến một số third-party service thì solution hơi lởm: bắt nhúng cái HTTP server vào app mới debug được.
- Giải quyết:
    - Ông Dan bảo manager cho 2 tuần vọc thử. Thế là vọc ra được bản demo bằng Python.
    - Đại khái solution sẽ là:
        - Dùng tool của Apple để execute command:
            - cat để đọc text
            - eval để chạy code
        - Dùng python để ghi vào disk
    - Solution lúc này gọi là iOSAuto.

# Selenium Conference 2012
- Dan được chọn để chém vào Selenium Conference 2012 ở London.
- Tranh thủ, ông show off project iOSAuto của mình vào cuối một slide chém của mình.
- Mọi người khá hứng thú, bảo ông ấy tách riêng ra thành 1 cái talk vào ngày hôm sau.
- Ngày hôm sau có tí trục trặc kĩ thuật, cơ mà về sau vẫn demo ngon lành. Mọi người vỗ tay ầm ầm.

# Điện thoại kêu
- Sau 4 tháng kể từ conference nói trên, Jason (Co-Creator of Selenium) phải làm tới project automation cho đội Sauce Labs trên iOS.
- Lúc này Jason nhớ tới bài chém của Dan, định dùng code của Dan cho đỡ phải code nhiều, nhưng nhớ là là Dan không opensource.
- Thế là Jason gọi cho Dan, bảo đi bar chơi.
- Đến bar thì Jason bảo: Opensource đi chú, ngại đ' gì.
- Đến tầm tháng 8, Dan opensource viết bằng C#.
- Đến tháng 9, Dan viết thêm 1 con server HTTP nằm ở giữa để hứng request. Thế là anh em code client bằng ngôn ngữ gì cũng được, khỏi cần C#.

# Mobile testing summit
- Jason quyết định mang con project này đi chém ở Mobile Testing summit vào tháng 11.
- 2 người muốn đặt cho nó 1 cái tên. 
- Định đặt là AppleCart, nhưng mà dính bản quyền sml
- Sau nghĩ ra cái tên Appium -> Selenium for App.

# Sauce Labs và Node.js
- Tháng 1 năm 2013, Sauce Labs quyết định đầu tư, cho dev vào phát triển con Appium này.
- Lúc này ông Jonathan làm lead, quyết định viết lại bằng Node.js cho anh em dễ contribute (tại cộng đồng js đông và nguy hiểm)
- Chỉ vài ngày, team convert code cũ từ C# sang javascript ngon lành cành đào.

# Appium Around the World
- Về sau, Jonathan mang con Appium này đi chém vòng quanh thế giới, để cho cộng dồng biết tới nhiều hơn.
- Đầu 2013, team Sauce Labs release Android and Seledroid support, làm cho Appium là một cross-platform automation framework chính hiệu.
- Project vào cuối 2013 có trên 1000 commits.

# Đường đến version 1.0
- 5/2014, Sauce Labs release bản 1.0 của Appium, đánh dấu chặng đường quan trọng.
- Appium lúc này đạt được nhiều giải thưởng phết rồi. Cũng trở thành một trong những opensource platform cho mobile phổ biến nhất.
- Appium dẫn trở nên ổn định hơn, các issue được ưu tiên fix, các tính năng mới được thêm vào.
- Sauce Labs cũng thêm dev vào code và fix cho nhanh, và vẫn để community contribute cùng.

# Mở rộng Appium
- Mặc dù đã được viết lại 1 lần, nhưng Appium vẫn còn nhiều hạn chế, khiến team lớn khó mà hoạt động trơn tru được.
- Source Labs cho 1 team viết lại Appium, sử dụng phiên bản Javascript mới hơn; update lại architecture chạy cho nhanh, cho người dùng tự viết driver dễ hơn.

# Appium tới mọi người
- Cuối 2016, Source Labs donate dự án Appium to JS Foundation - là một tổ chức phi lợi nhuận, chuyên quản lý và phát triển các dự án opensource.
- Sau này thì JS Foundation cũng được merge vào OpenJS Foundation.
- Appium vẫn là một trong những project to và có sức ảnh hưởng lớn trong tổ chức.

# Appium 2.0
- Appium 2 được release vào năm 2023, với giá trị cốt lõi là coi Appium là một hệ sinh thái, chứ không phải là một project độc lập.
- Drivers và plugins có thể được phát triển bởi bất kì ai, mở ra cơ hội phát triển cho các platforms khác sau này nữa, không chỉ dừng lại ở iOS và Android.