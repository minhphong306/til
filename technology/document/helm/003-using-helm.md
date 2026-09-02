> https://helm.sh/docs/intro/using_helm/

# Ba concept lớn
- Chart là một helm package, bao gồm tất cả các resource cần thiết để chạy một application, tools, hoặc một service bên trong K8s cluster.
- Nó tương tự khi RPM, PKG hay homebrew pacakge.

- Repository: Repository là nơi tập hợp các charts và có thể chia sẻ được. Nó giống kiểu Fedora Package Database, nhưng là cho K8s packages.

- Release là một instance của chart, chạy trên K8S cluster. Một chart có thể cài nhiều lần vào cùng 1 cluster.
  - Lấy ví dụ: bạn cần 2 con MySQL chạy trong cluster của bạn, bạn có thể cài chart mysql 2 lần. Mỗi con sẽ có 1 release name riêng.

# Helm search: tìm kiếm các charts

- helm search hub: tìm kiếm trên Artifact Hub
- helm search repo: Tìm kiếm các chart trên repo.
- helm repo add brigade https:/bridage.github.io/charts: add charts vào repository

# helm install: cài đặt packages
```bash
helm install happy-panda bitnami/wordpress
```
- Lệnh trên đặt tên release là happy-panda. Nếu muốn để helm tự đặt tên, hãy sử dụng --generate-name.

- Trong quá trình cài đặt, helm sẽ in các thông tin cần thiết, resource nào cần tạo, state của release là gì
- Helm sẽ cài đặt các resource theo thứ tự sau:
  - Namespace
  - NetworkPolicy
  - ResourceQuota
  - LimitRange
  - PodSecurityPolicy
  - PodDisruptionBudget
  - ServiceAccount
  - Secret
  - SecretList
  - ConfigMap
  - StorageClass
  - PersistentVolume
  - PersistentVolumeClaim
  - CustomResourceDefinition
  - ClusterRole
  - ClusterRoleList
  - ClusterRoleBinding
  - ClusterRoleBindlingList
  - Role
  - RoleList
  - RoleBinding
  - RoleBindingList
  - Service
  - DaemonSet
  - Pod
  - ReplicationController
  - ReplicaSet
  - Deployment
  - HorizontalPodAutoscaler
  - StatefulSet
  - Job
  - CronJob
  - Ingress
  - APIService

- Helm sẽ không đợi tòan bộ resource được running trước khi exit.