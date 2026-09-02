- https://kubernetes.io/docs/concepts/storage/volumes/

- Nếu container bị restart, các files trong container sẽ bị mất.
- Nhiều container cùng chạy trong một pod cần share một file cũng khó.
- Volumes ra đời để giải quyết các vấn đề này.