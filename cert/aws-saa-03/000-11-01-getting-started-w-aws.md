- **AWS Cloud history**
    - 2002: Internally launch
    - 2003: AWS infra là một trong những core strength idea để ra market
    - 2004: Lauch public với SQS
    - 2006: Re-launch publicly với SQS, S3 & EC2
    - 2007: Lauch in Europe
- **AWS Cloud Number Facts**
    - 2019: AWS có 35.02 tỉ đô doanh thu theo năm
    - 9029: AWS account chiếm 47% market (Microsoft lúc này mới là 22%)
    - Là tiên phong, market leader trong 9 năm liên tiếp
    - Hơn 1 triệu active user
- **Use cases:**
    - Giúp bạn build ứng dụng phức tạp (sophisticated), scalable.
    - Ứng dụng trong các ngành nghề đa dạng (a diverse set of industry)
    - Use cases:
        - Enterprise IT, Backup & Storage, Big Data analytics
        - Web hosting, mobile & social Apps
        - Gaming
    - AWS Global Infrastructure
        - Xem ở đây: https://infrastructure.aws
        - Một số điểm quan trọng
            - AWS Region
                - AWS có region all over the world
                - Tên region có thể là: us-east-1, eu-west-3…
                - Một region là một cụm các data center (cluster of data center)
                - Hầu hết các service của AWS là region-scoped (tức là chia theo region)
                - Chọn region:
                    - Tuân thủ các chính sách về dữ liệu và pháp lý (Compliance with data governance & legal requirement): dữ liệu sẽ không rời region mà không có sự cho phép của bạn
                    - Proximity (gần) khách hàng để giảm latency
                    - Available services within a Region: một số service mới và tính năng mới không có trên tất cả các Region
                    - Pricing: thay đổi theo từng vùng (pricing varies region to region) và được transparent ở service pricing page
            - AWS Availability Zones (AZ)
                - Mỗi region thường có nhiều các availability zones, thường min là 3 và max là 6
                - Mỗi AZ thường có các trung tâm dữ liệu riêng biệt (discrete data centers) với nguồn điện dự phòng (redundant power), networking và connectivity
                - Các AZ này là nằm tách biệt nhau, nên isolated from disaster (thảm hoạ).
                - Các AZ có băng thông lớn (high bandwidth), độ trễ siêu nhỏ (ultra-low latency) networking
            - AWS Data Centers
            - AWS Edge Locations/ Points of Presence (Các điểm hiện diện)
                - Amazon có trên 400 Point of Presence (400+ Edge Locations và 10+ Region Caches) ở 90+ thành phố, trên 40+ quốc gia
                - Nội dung delivery đến end user với latency thấp hơn.
            - Tour of AWS Console
                - Identity and Access Management (IAM)
                - Route 53 (DNS Service)
                - CloudFront (Content Delivery Network)
                - WAF (Web Application Firewall)
            - Most AWS services are Region-scoped:
                - Amazon EC2 (Infrastructure as a Service)
                - Elastic Beanstalk (Platform as a Service)
                - Lambda (Function as a Service)
                - Rekognition (Software as a Service)
            - Region table: https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services
    
    # Tour of AWS
    
    - Một số service là globally, nên không cần choose region (region selection bị disable)