> https://kubernetes.io/docs/concepts/workloads/pods/

- Pod là đơn vị nhỏ nhất.
- Từ pod có thể hiểu là pod of whales (như một con cá voi trong một đàn cá voi) hay pea pod (hạt đậu trong một quả đậu)
- Pod là một nhóm của một hoặc nhiều containers, được share storage và network resources, có hướng dẫn để chạy container.
- Có thể hiểu đơn giản: pod là một nhóm các ứng dụng dính lấy nhau, để chạy lên được một ứng dụng gốc.

# What is a Pod?
- Bên trên nói rồi. 
- Có 2 mô hình phổ biến:
    - 1 pod, 1 container
    - 1 pod, nhiều container: chỉ dùng khi các container liên quan chặt chẽ với nhau.

# Using Pod
- Ví dụ về 1 pod sử dụng image nginx:1.14.2

```yml
apiVersion: v1
kind: Pod
metadata:
    name: nginx
spec:
    containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
      - containerPort: 80
```
- Để chạy pod này lên, dùng lệnh
```bash
k apply -f <file_name>
```
- Để xoá pod này đi, dùng lệnh
```bash
k delete -f <file_name>
```
## Workload resource for managing pods
- Thông thường, không cần tạo pods trực tiếp mà tạo thông qua các workload resources như Deployment, Job.
- Nếu pods của bạn cần track state, sử dụng `StatefulSet` resource.
- Một pod tương đương với một instace ứng dụng của bạn đang chạy.
    - Bạn muốn scale lên nhiều instance? -> tăng số lượng pod lên.
    - Trong k8s thì gọi là replication.
- Pod thường cung cấp 2 loại shared resources cho các container của nó: `networking` và `storage`.

# Working with Pods
- Bạn rất hiếm khi tạo pod.
- Pod được thiết kế gần như là đối tượng tạm thời, có thể biến mất bất cứ lúc nào.
- Mỗi khi pod mới được tạo ra, pod này sẽ được schedule để chạy trong một Node, trong cluster của bạn.
- Pod sẽ ở trên Node đó cho tới khi nó chạy xong, hoặc pod bị xoá, pod bị evicted hoặc hết resource, hoặc node fail.
- **lưu ý**: Restart container trong một pod khác với việc restart pod.
    - Pod không phải là một process, nhưng nó là môi trường để chạy container.
- Tên pod phải tuân theo chuẩn giống DNS subdomain:
    - contain no more than 253 characters
    - contain only lowercase alphanumeric characters, '-' or '.'
    - start with an alphanumeric character
    - end with an alphanumeric character
- Nhưng mà ngon nhất thì nên theo chuẩn của Label names:
    - contain at most 63 characters
    - contain only lowercase alphanumeric characters or '-'
    - start with an alphanumeric character
    - end with an alphanumeric character

## Pod OS
- Bạn nên set `.spec.os.name` field thành `window` hoặc `linux` để định nghĩa xem pod run ở hệ điều hành nào.
- Trong cụm cluster có nhiều OS, hãy set kubernetes.io/os label đúng cho các node, definePod với nodeSelector dựa vào label của hệ điều hành.

## Pods và controllers
- Bạn có thể sử dụng workload resource để tạo và quản lý nhiều Pods cho bạn.
- Một controller có thể xử lý nhiều replication, rollout và automatic healing trong trường hợp pods của bạn fail.
- Ví dụ: node fail -> controller được thông báo và tạo một pod khác trên một healthy node.

## Pod templates
- Controller cho workload resource tạo pod từ pod template và quản lý các pod đó thay cho bạn.
- PodTemplate là specification để tạo pods, 