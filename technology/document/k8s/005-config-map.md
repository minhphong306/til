> https://kubernetes.io/docs/concepts/configuration/configmap/

- ConfigMap là một API object để lưu những dữ liệu không nhạy cảm dưới dạng key-value.
- Pod có thể sử dụng ConfigMap như một:
    - Biến môi trường
    - Command-line arguments
    - Configuration file trong một volume.
- ConfigMap giúp decouple các cấu hình của môi trường với container images.
- Lưu ý: ConfigMap không được encrypt -> nếu dữ liệu nhạy cảm, vui lòng dùng Secret hoặc 3rd party.

# Motivation
- Sử dụng ConfigMap để cấu hình dữ liệu tách biệt so với code của ứng dụng.
- /‌/ TODO: bổ sung ví dụ vào đây khi đã hiểu

- Lưu ý: ConfigMap không được thiết kế để lưu một lượng lớn dữ liệu (không quá 1MB), do vậy, nếu dữ liệu quá lớn thì bạn nên cân nhắc việc mount 1 volume hoặc một database hoặc file riêng biệt.

# ConfigMap object
- ConfigMap là một API object, giúp bạn lưu configuration cho ứng dụng khác sử dụng.
- Không giống với các object khác trong K8s, ConfigMap không có spec mà chỉ có `data` và `binaryData` data:
    - Dữ liệu lưu dạng key-value
    - key trong `data` và `binaryData` không được trùng nhau.
- Từ bản 1.19, ConfigMap support thêm `immutable` field.

# ConfigMaps và Pods
- Bạn có thê viết Pod `spec` refer tới một ConfigMap. Điều kiện là pod và ConfigMap cần cùng namespace.
- **Lưu ý**: static Pod không thể refer tới ConfigMap hoặc các API object khác.
- Ví dụ về một ConfigMap có một số key-value

```yml
apiVersion: v1
kind: ConfigMap
metadata:
    name: game-demo
data:
    player_initial_lives: "3"
    ui_properties_file_name: "user-interface.properties"

    game.properties: |
        enemy.types=aliens,monsters
        player.maximum-lives=5
    user-interface.properties: |
        color.good=purple
        color.bad=yellow
        allow.textmode=true
```
- Có 4 cách để dùng CM để cấu hình cho một container bên trong một pod:
1. Trong container command và args
2. Trong environment variable cho một container
3. Thêm file trong 1 read-only volume, để application đọc
4. Viết code trong pod, dùng k8s api để đọc giá trị trong configmap

- Mỗi cách sẽ hơi khác nhau chút:
    - 3 cách đầu: kubelet dùng data của configmap khi bắt đầu chạy container trong pod.
    - cách thứ 4: cần viết code để tương tác với k8s API.

- Ví dụ về pod sử dụng configMap

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: configmap-demo-pod
spec:
    containers:
        - name: demo
          image: alpine
          command: ["sleep", "3600"]
          env:
            - name: PLAYER_INITIAL_LIVES
              valueFrom:
                configMapKeyRef:
                  name: game-demo
                  key: player_initial_lives
            - name: UI_PROPERTIES_FILE_NAME
              valueFrom:
                configMapKeyRef:
                    name: game-demo
                    key: ui_properties_file_name
          volumeMounts:
          - name: config
            mountPath: "/config"
            readOnly: true
    volumes:
    - name: config
      configMap:
        name: game-demo
        items:
        - key: "game.properties"
          path: "game.properties"
        - key: "user-interface.properties"
          path: "user-interface.properties"
