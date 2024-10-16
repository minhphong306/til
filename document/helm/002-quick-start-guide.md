> https://helm.sh/docs/intro/quickstart/

# Khởi tạo helm chart repository
```
helm repo add bitnami https:/charts.bitnami.com/bitnami
```
- Khi cài xong, có thể search

```
helm search repo bitnami
```

# Cài example chart
```bash
helm repo update
helm install bitnami/mysql --generate-name
```
- Để xem chi tiết, chạy lệnh `helm show chart bitnami/mysql`
```bash
annotations:
  category: Database
  images: |
    - name: mysql
      image: docker.io/bitnami/mysql:8.4.2-debian-12-r4
    - name: mysqld-exporter
      image: docker.io/bitnami/mysqld-exporter:0.15.1-debian-12-r32
    - name: os-shell
      image: docker.io/bitnami/os-shell:12-debian-12-r29
  licenses: Apache-2.0
apiVersion: v2
appVersion: 8.4.2
dependencies:
- name: common
  repository: oci://registry-1.docker.io/bitnamicharts
  tags:
  - bitnami-common
  version: 2.x.x
description: MySQL is a fast, reliable, scalable, and easy to use open source relational
  database system. Designed to handle mission-critical, heavy-load production applications.
home: https://bitnami.com
icon: https://bitnami.com/assets/stacks/mysql/img/mysql-stack-220x234.png
keywords:
- mysql
- database
- sql
- cluster
- high availability
maintainers:
- name: Broadcom, Inc. All Rights Reserved.
  url: https://github.com/bitnami/charts
name: mysql
sources:
- https://github.com/bitnami/charts/tree/main/bitnami/mysql
version: 11.1.17
```
- Mỗi khi install chart, một release mới được tạo ra. Vì thế mà mỗi chart có thể được cài nhiều lần vào cluster.

# List danh sách release
- helm list hay helm ls
```bash
NAME            	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART        	APP VERSION
mysql-1728985195	default  	1       	2024-10-15 16:39:58.427528886 +0700 +07	deployed	mysql-11.1.17	8.4.2 
```

# Uninstall release
- helm uninstall <release-name>
- Nếu thêm flag `--keep-history` thì có thể truy vấn lại information được
```
helm status <release_name>
```
