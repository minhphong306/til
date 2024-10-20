> https://argo-cd.readthedocs.io/en/stable/getting_started/

# Yêu cầu
- Cài kubectl, có kubeconfig (~/.kube/config).
- CoreDNS

# 1. Cài Argo CD
```
kubectl create namespacce argocd
kubectl apply - argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
- Đoạn command trên sẽ tạo ra 1 namespace argocd, nơi mà ArgoCD services và application sẽ được chạy.
- Lưu ý: file cài đặt mặc định bao gồm ClusterRoleBinding được tham chiếu tới argocd namespace. Nếu bạn cài vào namespace khác, vui lòng update giá trị này.
- Tip: Nếu bạn không cần UI, SSO,... thì bạn chỉ cần cài core thôi cũng được.
- Mặc định thì chưa vào được UI ngay, cần làm 1 số thao tác để trust cái client certificate nữa.
- Có thể set namespace mặc định về argocd để không phải gõ dài dòng nữa:

```
kubectl config set-context --current --namespace=argocd
```
- Sử dụng `argocd login --core` để cấu hình CLI access.
- Lưu ý: Mặc định thì Redis sử dụng password authentication.
    - Redis password được lưu ở Kubenetes secret `argocd-redis` với key `auth`, ở namespace `argocd`

# 2. Cài ArgoCD CLI
- brew install argocd
- https://github.com/argoproj/argo-cd/releases/latest

# 3. Truy cập Argo CD API server
- Mặc định thì Argo CD API server không expose với một external IP.
- Để access được API Server, cần dùng 1 trong 2 cách sau:
- Đổi service type về LoadBalancer
```
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
- Sử dụng Ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/
- Port Forwarding: 
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
    - Lúc này có thể access sử dụng port 8080: https://localhost:8080

# 4. - Login sử dụng CLI
- Account mặc định là admin.
- Password thì lưu trong secret. Dùng argocli để lấy cũng được
```
argocd admin initial-password -n argocd
```
- Lưu ý: sau khi dùng xong thì xoá hẳn cái argocd-initial-admin-secret đi nha. Cũng không dùng để làm gì đâu.
    - Sau này cần gen lại thì argocd sẽ tự tạo cái secret khác.

- Sử dụng username admin và password để login:
```bash
argocd login <ARGOCD_SERVER>
```