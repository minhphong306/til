# How renovate works
- https://docs.renovatebot.com/key-concepts/how-renovate-works/
- Renovate hoạt động thông qua các bước:
    - Clone repo
    - Scan package files để extract ra các dependencies
    - Tìm registries để check update
    - Apply các grouping rule đã được định nghĩa.
    - Push branch và tạo PR.
- Vì renovate support đa dạng các kiểu dependency naming và versioning, nên có các modules khác nhau cho các convention đã biết.
    - Bạn có thể tự contribute module của bạn nếu muốn.

## Modules
- Renovate's modules là: 
    - datasource
    - manager
    - platform
    - versioning
- Renovate sử dụng các modules này theo thứ tự:
    - platform pull code về
    - manager extract dependencies thành các data source khác nhau
    - versioning module tiến hành validate, sort lại

# Preset
- Preset là cấu hình mẫu. giúp bạn cấu hình nhanh hơn.
- Cách dùng: thêm vào file config:

```json
{
  "extends": ["config:recommended""helpers:pinGitHubActionDigests"]
}
```
- Nếu bị conflict thì config nào ở sau sẽ win

# Dependency dashboard
- Giống kiểu 1 cái dashboard, sẽ cho bạn biết tình trạng repo của bạn.
- VIết ở dạng markdown, ở trong issues (VD: https://github.com/minhphong306/demo-playwright-fw/issues/4)
- Cách config:
```json
{
  "extends": ["config:recommended", ":dependencyDashboard"]
}
```
- Hoặc:
```json
{
  "dependencyDashboard": true
}
```
-... một số config cho major only, need approval,...

# Pull requests
- 