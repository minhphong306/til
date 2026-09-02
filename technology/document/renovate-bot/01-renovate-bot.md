> https://docs.renovatebot.com/

- Tại sao dùng renovate bot:
  - Automatic update
  - Support nhiều platform

# Repository installation
- Renovate admin có thể cấu hình autodiscover các repository hoặc cấu hình một fixed list.
- Nếu cấu hình fixed list, cần đợi tới next run hoặc restart renovate thì mới ăn config mới.
- Nếu để auto discover thì có vài cách:
  - Phổ biến nhất thì run Renovate như một bot user với config autodiscover giá trị là true. Như vậy, renovate bot sẽ run mỗi khi có 1 repository được grant.
  - Nếu dùng GitHub App, ...
## Configuration location
- Có 1 file renovate.json trong project
- Có thể dùng nhiều định dạng khác: json5, renovaterc, package.json (deprecated),...
  
## Customize default
- Mặc định thì renovate bot khá ngon rồi.
- Thường sẽ override một số giá trị sau:
  - rangeStrategy
  - labels
  - assignees

## Config lại
- Sau 1 thời gian sử dụng, bạn muốn config lại thì có 2 cách: config lại thông qua PR và config lại thông qua re-onboard

### Re-config thông qua PR
- Tạo branch
- Cài đặt renovate bot (npm i -g renovate) để có được renovate-config-validator
- Sửa file renovate config
- Validate config
- Merge branch vào nhánh chính

### Config lại và re-onboard
- Tìm lại PR `Configure Renovate`, đổi tên thành cái gì đó (VD: Configure Renovate - old)
- Xóa configuration file hiện tại (renovate.json)
- Lưu ý: nếu bạn dùng Mend Renovate App, bạn sẽ không có onboarding PR trong vài giờ. Nếu cần thì bạn tạo một discussion post để request nhân viên trigger manually.
- 