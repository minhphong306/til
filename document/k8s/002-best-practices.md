> https://kubernetes.io/docs/setup/best-practices/cluster-large/

# Cân nhắc cho cluster lớn
- Một cluster là một set các nodes (vật lý hoặc VM) chạy các K8s agents, được quản lý bởi control plane.
- K8s 1.31 support cluster lên tới 5000 nodes.
- Cụ thể hơn thì, K8s được thiết kế với các tiêu chí sau:
  - - Không có hơn 110 pods trên mỗi node.
  - Không có trên 5000 nodes
  - Không có trên 150K pods tổng cộnggs
  - Không có trên 300K container

# Cloud provider resource quota
- Để tránh bị overquota, khi tạo cluster có nhiều nodes, hãy lưu ý:
- Yêu cầu tăng cloud resource như:
  - Computer instances
  - CPUs
  - Storage volumes
  - In-use IP addresses
  - Package filtering rule sets
  - Number of load balancers
  - Network subnets.
  - Log streams.
- Khi tăng resource, hãy 