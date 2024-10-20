> https://appium.io/docs/en/latest/intro/drivers/

- Như đã giới thiệu từ phần intro, driver đơn giản là câu trả lời cho: "Làm thế nào để Appium automation cho các platform không liên quan đến nhau".
- Việc hiểu phần này chủ yếu giúp ích cho các bác có ý định viết driver.

# Interface implementation 
- Đoạn này khá dễ hiểu, về cơ bản thì Appium có một cái Driver gọi là `BaseDriver`. Anh em extends thằng Base này lại, rồi viết thêm code tương tác với platform vào.
- Hiểu đơn giản thì:
```
Client code <=> Appium <=> Driver <=> Device
```

```typescript
import BaseDriver from '@appium/base-driver'

class MyNewDriver extends BaseDriver {
}
```
- Do làm theo chuẩn web, nên một số method trông hơi giống tương tác trên web như: `setUrl` thì sẽ phải map tương ứng với bên app:
    - Browser: dùng js để set window.location.href
    - iOS/Android app: dùng deep link để run app
    - React app: load một route cụ thể
    - Unity: đi đến một scene cụ thể.

# Automation mapping
# Multi-level architecture
- Nhiều lúc kiến trúc nó phải chia nhiều tầng và hơi phức tạp chút. Phần nhiều là do platform nó phải thế.
- Lấy ví dụ với iOS đi:
    - Muốn tương tác được với iOS qua thư viện XCUITest thì phải dùng Objective-C hoặc Swift, và thông qua một chế độ đặc biệt của X-Code.
    - Không thể map trực tiếp từ code của Nodejs tới XCUITest được.
    - Lúc này thì người viết driver buộc phải viết riêng:
        - Một phần viết bằng Nodejs để tương tác với core của Appium
        - Một phần viết bằng Objective-C để gọi tới command của XCUITest
    - Làm như trên thì effort sẽ nhân đôi, phải maintain cả 2 cháu.
    - Cuối cùng ông cháu chọn cách: viết 1 lib Objective-C thôi, con này sẽ giao tiếp với WebDriver protocol

# Proxy mode
- Phần này nói về việc nhiều khi driver sẽ chỉ là một chỗ để proxy tới platform driver thôi.
- Ví dụ dễ hiểu: Safari driver: https://github.com/appium/appium-safari-driver
    - Nếu nhìn vào code thì thấy chủ yếu code là gọi tới binary Safari driver của Apple.
- Sử dụng cách proxy này giúp anh em viết driver cho nhanh.