# # Custom VPC
# resource "aws_vpc" "USTeam2_ACP_VPC" {
#   cidr_block       = var.VPC_cidr_block
#   instance_tenancy = "default"

#   tags = {
#     Name = var.VPC_tag_name
#   }
# }

# # Two Public & Two Private Subnets in Diff AZ
# resource "aws_subnet" "USTeam2_ACP_Public_SN1" {
#   vpc_id            = aws_vpc.USTeam2_ACP_VPC.id
#   cidr_block        = var.public_subnet1_cidr_block
#   availability_zone = var.public_subnet1_availabilityzone

#   tags = {
#     Name = "USTeam2_ACP_Public_SN1"
#   }
# }

# resource "aws_subnet" "USTeam2_ACP_Private_SN1" {
#   vpc_id            = aws_vpc.USTeam2_ACP_VPC.id
#   cidr_block        = var.private_subnet1_cidr_block
#   availability_zone = var.private_subnet1_availabilityzone

#   tags = {
#     Name = "USTeam2_ACP_Private_SN1"
#   }
# }

# resource "aws_subnet" "USTeam2_ACP_Public_SN2" {
#   vpc_id            = aws_vpc.USTeam2_ACP_VPC.id
#   cidr_block        = var.public_subnet2_cidr_block
#   availability_zone = var.public_subnet2_availabilityzone
#   tags = {
#     Name = "USTeam2_ACP_Public_SN2"
#   }
# }

# resource "aws_subnet" "USTeam2_ACP_Private_SN2" {
#   vpc_id            = aws_vpc.USTeam2_ACP_VPC.id
#   cidr_block        = var.private_subnet2_cidr_block
#   availability_zone = var.private_subnet2_availabilityzone

#   tags = {
#     Name = "USTeam2_ACP_Private_SN2"
#   }
# }

# # Custom Internet Gateway
# resource "aws_internet_gateway" "USTeam2_ACP_IGW" {
#   vpc_id = aws_vpc.USTeam2_ACP_VPC.id

#   tags = {
#     Name = "USTeam2_ACP_IGW"
#   }
# }

# # Create a public route table
# resource "aws_route_table" "USTeam2_ACP_Public_RT" {
#   vpc_id = aws_vpc.USTeam2_ACP_VPC.id

#   route {
#     cidr_block = var.public_routetable_cidr_block
#     gateway_id = aws_internet_gateway.USTeam2_ACP_IGW.id
#   }

#   tags = {
#     Name = "USTeam2_ACP_Public_RT"
#   }
# }

# # Public subnet1 attached to public route table
# resource "aws_route_table_association" "USTeam2_ACP_Public_RTA1" {
#   subnet_id      = aws_subnet.USTeam2_ACP_Public_SN1.id
#   route_table_id = aws_route_table.USTeam2_ACP_Public_RT.id
# }

# # Public subnet2 attached to public route table
# resource "aws_route_table_association" "USTeam2_ACP_Public_RTA2" {
#   subnet_id      = aws_subnet.USTeam2_ACP_Public_SN2.id
#   route_table_id = aws_route_table.USTeam2_ACP_Public_RT.id
# }

# # EIP for NAT Gateway
# resource "aws_eip" "USTeam2_ACP_EIP" {
#   vpc = true
# }

# #Custom NAT Gateway
# resource "aws_nat_gateway" "USTeam2_ACP_NGW" {
#   allocation_id = aws_eip.USTeam2_ACP_EIP.id
#   subnet_id     = aws_subnet.USTeam2_ACP_Public_SN1.id

#   tags = {
#     Name = "USTeam2_ACP_NGW"
#   }
# }

# # Create a private route table
# resource "aws_route_table" "USTeam2_ACP_Private_RT" {
#   vpc_id = aws_vpc.USTeam2_ACP_VPC.id

#   route {
#     cidr_block     = var.private_routetable_cidr_block
#     nat_gateway_id = aws_nat_gateway.USTeam2_ACP_NGW.id
#   }

#   tags = {
#     Name = "USTeam2_ACP_Private_RT"
#   }
# }

# # Private subnet1 attached to private route table
# resource "aws_route_table_association" "USTeam2_ACP_Private_RTA1" {
#   subnet_id      = aws_subnet.USTeam2_ACP_Private_SN1.id
#   route_table_id = aws_route_table.USTeam2_ACP_Private_RT.id
# }

# # Private subnet2 attached to private route table
# resource "aws_route_table_association" "USTeam2_ACP_Private_RTA2" {
#   subnet_id      = aws_subnet.USTeam2_ACP_Private_SN2.id
#   route_table_id = aws_route_table.USTeam2_ACP_Private_RT.id
# }

# # Two security groups (Frontend & Backend)
# resource "aws_security_group" "USTeam2_ACP_Frontend_SG" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.USTeam2_ACP_VPC.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "All ICMP - IPv4"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "USTeam2_ACP_Frontend_SG"
#   }
# }

# resource "aws_security_group" "USTeam2_ACP_Backend_SG" {
#   name        = "SSH_MYSQL_Access"
#   description = "Enables SSH& MYSQL access"
#   vpc_id      = aws_vpc.USTeam2_ACP_VPC.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24"]
#   }
#   ingress {
#     description = "EFS"
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "ElasticCache (Redis)"
#     from_port   = 6379
#     to_port     = 6379
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "MYSQL/Aurora"
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "USTeam2_ACP_Backend_SG"
#   }
# }

# # create DB Subnet group
# resource "aws_db_subnet_group" "USTeam2_ACP_DB_SBG" {
#   name       = "usteam2acp_db_sb"
#   subnet_ids = [aws_subnet.USTeam2_ACP_Private_SN1.id, aws_subnet.USTeam2_ACP_Private_SN2.id]

#   tags = {
#     Name = "USTeam2_ACP_DB_SBG"
#   }
# }

# # create RDS Mysql Database
# resource "aws_db_instance" "USTeam2_ACP" {
#   allocated_storage      = 10
#   identifier             = var.identifier
#   storage_type           = "gp2"
#   engine                 = "mysql"
#   engine_version         = "5.7"
#   instance_class         = var.instance_class
#   db_name                = var.db_name
#   username               = var.db_username
#   password               = var.db_passwd
#   parameter_group_name   = "default.mysql5.7"
#   skip_final_snapshot    = true
#   db_subnet_group_name   = aws_db_subnet_group.USTeam2_ACP_DB_SBG.id
#   vpc_security_group_ids = [aws_security_group.USTeam2_ACP_Backend_SG.id]
#   publicly_accessible    = false
#   multi_az               = true
# }

# #Create S3 Media Bucket = USTeam2-ACP-Mediabucket 
# resource "aws_s3_bucket" "ustesteamedia" {
#   bucket        = "ustesteamedia"
#   force_destroy = true
#   tags = {
#     Name = "ustesteamedia"
#   }
# }

# #Create S3 Code Bucket = USTeam2-ACP-Codebucket 
# resource "aws_s3_bucket" "ustesteaml" {
#   bucket        = "ustesteaml"
#   force_destroy = true
#   tags = {
#     Name = "ustesteam"
#   }
# }


# #Create Bucket Policy
# resource "aws_s3_bucket_policy" "usteam2acpmediabucketpol" {
#   bucket = aws_s3_bucket.ustesteamedia.id
#   policy = jsonencode({
#     Id = "mediaBucketPolicy"
#     Statement = [
#       {
#         Action = ["s3:GetObject", "s3:GetObjectVersion"]
#         Effect = "Allow"
#         Principal = {
#           AWS = "*"
#         }
#         Resource = "arn:aws:s3:::ustesteamedia/*"
#         Sid      = "PublicReadGetObject"
#       }
#     ]
#     Version = "2012-10-17"
#   })
# }

# #Create Logs for Media Bucket = USTeam2_ACP_medialogs
# resource "aws_s3_bucket" "ustesteamedialogs" {
#   bucket        = "ustesteamedialogs"
#   force_destroy = true
#   tags = {
#     Name = "ustesteamedialogs"
#   }
# }

# # Creat Bucket Policy for Media Logs
# resource "aws_s3_bucket_policy" "ustesteamedialogs" {
#   bucket = aws_s3_bucket.ustesteamedialogs.id
#   policy = jsonencode({
#     Id = "mediaBucketlogsPolicy"
#     Statement = [
#       {
#         Action = "s3:GetObject"
#         Effect = "Allow"
#         Principal = {
#           AWS = "*"
#         }
#         Resource = "arn:aws:s3:::ustesteamedialogs/*"
#         Sid      = "PublicReadGetObject"
#       }
#     ]
#     Version = "2012-10-17"
#   })
# }

# # Create Bastion Security Group
# resource "aws_security_group" "BastionSG" {
#   name        = "BastionSG"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.USTeam2_ACP_VPC.id

#   ingress {
#     description = "ssh from VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "BastionSG"
#   }
# } 

# # Create a Bastion_Host
# resource "aws_instance" "bastion_host" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   vpc_security_group_ids      = [aws_security_group.BastionSG.id]
#   subnet_id                   = aws_subnet.USTeam2_ACP_Private_SN1.id
#   availability_zone           = var.public_subnet1_availabilityzone
#   key_name                    = var.key_name
#   associate_public_ip_address = true
#   provisioner "file" {
#     source = "~/Keypairs/UST-apC"
#     destination = "/home/ec2-user/UST-apC"
#   }
#   connection {
#     type = "ssh"
#     host = self.public_ip
#     private_key = file("~/Keypairs/UST-apC")
#     user = "ec2-user"
#   }
#   user_data = <<-EOF
#   #!/bin/bash
#   sudo chmod 400 UST-apC
#   sudo hostnamectl set-hostname bastion
#   EOF
#   tags = {
#     Name = "bastion_host"
#   }
# }

# #Create IAM role for EC2
# resource "aws_iam_instance_profile" "USTeam2_ACP-IAM-Profil" {
#   name = "USTeam2_ACP-IAM-Profil"
#   role = aws_iam_role.USTeam2_ACP-IAM-Rol.name
# }
# resource "aws_iam_role" "USTeam2_ACP-IAM-Rol" {
#   name        = "USTeam2_ACP-IAM-Rol"
#   description = "S3 Full Permission"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
#   tags = {
#     tag-key = "USTeam2_ACP-IAM-Rol"
#   }
# }

# #IAM role Policy attachment
# resource "aws_iam_role_policy_attachment" "USTeam2_ACP-role-pol-attach" {
#   role       = aws_iam_role.USTeam2_ACP-IAM-Rol.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }
# # Create a Keypair
# resource "aws_key_pair" "UST-apC-key" {
#   key_name   = var.key_name
#   public_key = file(var.path_to_public_key)
# }
# # Create the EC2 Instance
# resource "aws_instance" "USTeam2_ACP-web" {
#   ami                         = var.ami
#   instance_type               = var.instance_type
#   vpc_security_group_ids      = [aws_security_group.USTeam2_ACP_Backend_SG.id]
#   subnet_id                   = aws_subnet.USTeam2_ACP_Public_SN1.id
#   key_name                    = var.key_name
#   iam_instance_profile        = aws_iam_instance_profile.USTeam2_ACP-IAM-Profil.id
#   associate_public_ip_address = true

#   user_data = <<-EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum upgrade -y
# sudo yum install nfs-utils -y
# sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0b923a0d2c1ab6f40.efs.us-east-1.amazonaws.com:/ /var/www/html
# sudo bash -c 'echo "[fs-0b923a0d2c1ab6f40.efs.us-east-1.amazonaws.com/ /var/www/html nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0]" >> /etc/fstab'
# sudo reboot
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# sudo yum install unzip -y
# unzip awscliv2.zip
# sudo ./aws/install
# sudo yum install httpd php php-mysqlnd -y
# cd /var/www/html
# sudo touch indextest.html
# sudo bash -c 'echo "This is a test file" > indextest.html'
# sudo yum install wget -y
# sudo wget https://wordpress.org/wordpress-5.1.1.tar.gz
# sudo tar -xzf wordpress-5.1.1.tar.gz
# sudo cp -r wordpress/* /var/www/html/
# sudo rm -rf wordpress
# sudo rm -rf wordpress-5.1.1.tar.gz
# sudo chmod -R 755 wp-content
# sudo chown -R apache:apache wp-content
# sudo wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
# sudo mv htaccess.txt .htaccess
# cd /var/www/html && sudo mv wp-config-sample.php wp-config.php
# sed -i "s@define( 'DB_NAME', 'database_name_here' )@define( 'DB_NAME', '${var.db_name}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_USER', 'username_here' )@define( 'DB_USER', '${var.db_username}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_PASSWORD', 'password_here' )@define( 'DB_PASSWORD', '${var.db_passwd}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_HOST', 'localhost' )@define( 'DB_HOST', '${element(split(":", aws_db_instance.USTeam2_ACP.endpoint), 0)}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'WP_REDIS_HOST', 'PUT_YOUR_REDIS_INSTANCE_ENDPOINT_HERE')@define( 'WP_REDIS_HOST', 'tf-dev-rep-group.clns5t.ng.0001.use1.cache.amazonaws.com' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'WP_CACHE', true)@define( 'WP_CACHE', '${var.db_cache}' )@g" /var/www/html/wp-config.php
# cat <<EOT> /etc/httpd/conf/httpd.conf
# ServerRoot "/etc/httpd"
# Listen 80
# Include conf.modules.d/*.conf
# User apache
# Group apache
# ServerAdmin root@localhost
# <Directory />
#     AllowOverride none
#     Require all denied
# </Directory>
# DocumentRoot "/var/www/html"
# <Directory "/var/www">
#     AllowOverride None
#     # Allow open access:
#     Require all granted
# </Directory>
# <Directory "/var/www/html">
#     Options Indexes FollowSymLinks
#         AllowOverride All
#         Require all granted
# </Directory>
# <IfModule dir_module>
#     DirectoryIndex index.html
# </IfModule>
# <Files ".ht*">
#     Require all denied
# </Files>
# ErrorLog "logs/error_log"
# LogLevel warn
# <IfModule log_config_module>
#     LogFormat "%h %l %u %t \"%r\" %>s %b \"%%{Referer}i\" \"%%{User-Agent}i\"" combined
#     LogFormat "%h %l %u %t \"%r\" %>s %b" common
#     <IfModule logio_module>
#       LogFormat "%h %l %u %t \"%r\" %>s %b \"%%{Referer}i\" \"%%{User-Agent}i\" %I %O" combinedio
#     </IfModule>
#     CustomLog "logs/access_log" combined
# </IfModule>
# <IfModule alias_module>
#     ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
# </IfModule>
# <Directory "/var/www/cgi-bin">
#     AllowOverride None
#     Options None
#     Require all granted
# </Directory>
# <IfModule mime_module>
#     TypesConfig /etc/mime.types
#     AddType application/x-compress .Z
#     AddType application/x-gzip .gz .tgz
#     AddType text/html .shtml
#     AddOutputFilter INCLUDES .shtml
# </IfModule>
# AddDefaultCharset UTF-8
# <IfModule mime_magic_module>
#         MIMEMagicFile conf/magic
# </IfModule>
# EnableSendfile on
# IncludeOptional conf.d/*.conf
# EOT
# cat <<EOT> /var/www/html/.htaccess
# Options +FollowSymlinks
# RewriteEngine on
# rewriterule ^wp-content/uploads/(.*)$ http://${data.aws_cloudfront_distribution.USTeam2_ACP_cloudfront.domain_name}/\$1 [r=301,nc]
# # BEGIN WordPress
# # END WordPress
# EOT
# aws s3 cp --recursive /var/www/html/ s3://ustesteam
# aws s3 sync /var/www/html/ s3://ustesteam
# echo "* * * * * ec2-user /usr/local/bin/aws s3 sync --delete s3://ustesteam /var/www/html/" > /etc/crontab
# echo "* * * * * ec2-user /usr/local/bin/aws s3 sync /var/www/html/wp-content/uploads/ s3://ustesteamedia" >> /etc/crontab
# sudo chkconfig httpd on
# sudo service httpd start
# sudo setenforce 0
#   EOF
#   tags = {
#     Name = "USTeam2_ACP-web"
#   }
# }


# # Cloudfront Distribution Data
# data "aws_cloudfront_distribution" "USTeam2_ACP_cloudfront" {
#   id = aws_cloudfront_distribution.USTeam2_ACP_distribution.id
# }

# # Cloudfront Distribution
# locals {
#   s3_origin_id = "aws_s3_bucket.ustesteamedia.id"
# }
# resource "aws_cloudfront_distribution" "USTeam2_ACP_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.ustesteamedia.bucket_domain_name
#     origin_id   = local.s3_origin_id
#   }

#   enabled = true

#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 0
#     max_ttl                = 600
#   }

#   price_class = "PriceClass_All"

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }


# # #  Create Route 53 Hosted zone = usteam2-acp-zone
# # resource "aws_route53_zone" "usteam2-acp-zone" {
# #   name          = "consultlawal" # add your own domain name
# #   force_destroy = true
# # }

# # Create A Route 53 record = usteam2-acp-www
# resource "aws_route53_record" "usteam2-acp-www" {
#   zone_id = aws_route53_zone.usteam2-acp-zone.zone_id
#   name    = var.domain_name # add your own domain name
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.USTeam2_ACP-web.public_ip]
#   #  alias {
#   # #name = aws_lb.usteam2-acp-albb.dns_name
#   # zone_id = aws_lb.usteam2-acp-albb.zone_id
#   # evaluate_target_health = false

#   #}
# }

# # create a application load balancer 
# resource "aws_lb" "USTeam2_ACP-alb" {
#   name                       = "USTeam2-ACP-albb"
#   internal                   = false
#   load_balancer_type         = "application"
#   security_groups            = [aws_security_group.USTeam2_ACP_Frontend_SG.id]
#   subnets                    = [aws_subnet.USTeam2_ACP_Public_SN1.id, aws_subnet.USTeam2_ACP_Public_SN2.id]
#   enable_deletion_protection = false
#   access_logs {
#     bucket = "aws_s3_bucket.USTeam2-ACP-albb.elblog"
#     prefix = "USTeam2_ACP"
#   }
# }

# # Create a load balancer lisener 
# resource "aws_lb_listener" "USTeam2_ACP-lb-listener" {
#   load_balancer_arn = aws_lb.USTeam2_ACP-alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.USTeam2_ACP-tg.arn
#   }
# }
# # Create a Target Group for load balancer
# resource "aws_lb_target_group" "USTeam2_ACP-tg" {
#   name     = "USTeam2-ACP-tgg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.USTeam2_ACP_VPC.id
#   health_check {
#     healthy_threshold   = 3
#     unhealthy_threshold = 10
#     interval            = 90
#     timeout             = 60
#     path                = "/indextest.html"
#   }
# }
# resource "aws_lb_target_group_attachment" "USTeam2-ACP-tgg-att" {
#   target_group_arn = aws_lb_target_group.USTeam2_ACP-tg.arn
#   target_id        = aws_instance.USTeam2_ACP-web.id
#   port             = 80
# }


# # Create ami for webser
# resource "aws_ami_from_instance" "USTeam2_ACP_ami" {
#   name                    = "usteam2-acp-ami"
#   source_instance_id      = aws_instance.USTeam2_ACP-web.id
#   snapshot_without_reboot = true
# }


# # Launch Configuration  for autoscaling group = usteam2-acp-lc
# resource "aws_launch_configuration" "usteam2-acp-lc" {
#   name_prefix                 = "usteam2-acplc"
#   image_id                    = aws_ami_from_instance.USTeam2_ACP_ami.id
#   instance_type               = "t2.micro"
#   iam_instance_profile        = aws_iam_instance_profile.USTeam2_ACP-IAM-Profil.id
#   security_groups             = [aws_security_group.USTeam2_ACP_Backend_SG.id]
#   associate_public_ip_address = true
#   key_name                    = var.key_name
#   user_data                   = <<-EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum upgrade -y
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# sudo yum install unzip -y
# unzip awscliv2.zip
# sudo ./aws/install
# sudo yum install httpd php php-mysqlnd -y
# cd /var/www/html
# touch indextest.html
# echo "This is a test file" > indextest.html
# sudo yum install wget -y
# wget https://wordpress.org/wordpress-5.1.1.tar.gz
# tar -xzf wordpress-5.1.1.tar.gz
# cp -r wordpress/* /var/www/html/
# rm -rf wordpress
# rm -rf wordpress-5.1.1.tar.gz
# chmod -R 755 wp-content
# chown -R apache:apache wp-content
# wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
# mv htaccess.txt .htaccess
# cd /var/www/html && mv wp-config-sample.php wp-config.php
# sed -i "s@define( 'DB_NAME', 'database_name_here' )@define( 'DB_NAME', '${var.db_name}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_USER', 'username_here' )@define( 'DB_USER', '${var.db_username}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_PASSWORD', 'password_here' )@define( 'DB_PASSWORD', '${var.db_passwd}' )@g" /var/www/html/wp-config.php
# sed -i "s@define( 'DB_HOST', 'localhost' )@define( 'DB_HOST','${element(split(":", aws_db_instance.USTeam2_ACP.endpoint), 0)}' )@g" /var/www/html/wp-config.php
# cat <<EOT> /etc/httpd/conf/httpd.conf
# ServerRoot "/etc/httpd"
# Listen 80
# Include conf.modules.d/*.conf
# User apache
# Group apache
# ServerAdmin root@localhost
# <Directory />
#     AllowOverride none
#     Require all denied
# </Directory>
# DocumentRoot "/var/www/html"
# <Directory "/var/www">
#     AllowOverride None
#     # Allow open access:
#     Require all granted
# </Directory>
# <Directory "/var/www/html">
#     Options Indexes FollowSymLinks
#         AllowOverride All
#         Require all granted
# </Directory>
# <IfModule dir_module>
#     DirectoryIndex index.html
# </IfModule>
# <Files ".ht*">
#     Require all denied
# </Files>
# ErrorLog "logs/error_log"
# LogLevel warn
# <IfModule log_config_module>
#     LogFormat "%h %l %u %t \"%r\" %>s %b \"%%{Referer}i\" \"%%{User-Agent}i\"" combined
#     LogFormat "%h %l %u %t \"%r\" %>s %b" common
#     <IfModule logio_module>
#       LogFormat "%h %l %u %t \"%r\" %>s %b \"%%{Referer}i\" \"%%{User-Agent}i\" %I %O" combinedio
#     </IfModule>
#     CustomLog "logs/access_log" combined
# </IfModule>
# <IfModule alias_module>
#     ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
# </IfModule>
# <Directory "/var/www/cgi-bin">
#     AllowOverride None
#     Options None
#     Require all granted
# </Directory>
# <IfModule mime_module>
#     TypesConfig /etc/mime.types
#     AddType application/x-compress .Z
#     AddType application/x-gzip .gz .tgz
#     AddType text/html .shtml
#     AddOutputFilter INCLUDES .shtml
# </IfModule>
# AddDefaultCharset UTF-8
# <IfModule mime_magic_module>
#         MIMEMagicFile conf/magic
# </IfModule>
# EnableSendfile on
# IncludeOptional conf.d/*.conf
# EOT
# cat <<EOT> /var/www/html/.htaccess
# Options +FollowSymlinks
# RewriteEngine on
# rewriterule ^wp-content/uploads/(.*)$ http://${data.aws_cloudfront_distribution.USTeam2_ACP_cloudfront.domain_name}/\$1 [r=301,nc]
# # BEGIN WordPress
# # END WordPress
# EOT
# aws s3 cp --recursive /var/www/html/ s3://usteam2-acp-codebucket
# aws s3 sync /var/www/html/ s3://usteam2-acp-codebucket
# echo "* * * * * ec2-user /usr/local/bin/aws s3 sync --delete s3://usteam2-acp-codebucket /var/www/html/" > /etc/crontab
# echo "* * * * * ec2-user /usr/local/bin/aws s3 sync /var/www/html/wp-content/uploads/ s3://usteam2-acp-mediabucket" >> /etc/crontab
# sudo chkconfig httpd on
# sudo service httpd start
# sudo setenforce 0
# EOF
#   lifecycle {
#     create_before_destroy = false
#   }
# }


# # Autoscaling Group = usteam2-acp-asg
# resource "aws_autoscaling_group" "USTeam2_ACP-asg" {
#   name                      = "USTeam2_ACP-asg"
#   desired_capacity          = 3
#   max_size                  = 4
#   min_size                  = 2
#   health_check_grace_period = 300
#   default_cooldown          = 60
#   health_check_type         = "ELB"
#   force_delete              = true
#   launch_configuration      = aws_launch_configuration.usteam2-acp-lc.name
#   vpc_zone_identifier       = [aws_subnet.USTeam2_ACP_Public_SN1.id, aws_subnet.USTeam2_ACP_Public_SN2.id]
#   target_group_arns         = ["${aws_lb_target_group.USTeam2_ACP-tg.arn}"]
#   tag {
#     key                 = "Name"
#     value               = "usteam2-acp-asg"
#     propagate_at_launch = true
#   }
# }

# # Autoscaling Group Policy = usteam2-acp-asgpol
# resource "aws_autoscaling_policy" "usteam2-acp-asgpol" {
#   name                   = "usteam2-acp-asgpol"
#   policy_type            = "TargetTrackingScaling"
#   adjustment_type        = "ChangeInCapacity"
#   autoscaling_group_name = aws_autoscaling_group.USTeam2_ACP-asg.name
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = 60.0
#   }
# }

# # create cloudwatch
# resource "aws_cloudwatch_dashboard" "USTeam2_ACP-web-dashboard" {
#   dashboard_name = "USTeam2_ACP_web_dashboard"
#   dashboard_body = <<EOF
# {
#   "widgets": [
#     {
#       "type": "metric",
#       "x": 0,
#       "y": 0,
#       "width": 12,
#       "height": 6,
#       "properties": {
#         "metrics": [
#           [
#             "AWS/EC2",
#             "CPUUtilization",
#             "InstanceId",
#             "${aws_instance.USTeam2_ACP-web.id}"
#           ]
#         ],
#         "period": 300,
#         "stat": "Average",
#         "region": "us-east-1",
#         "title": "EC2 Instance CPU"
#       }
#     },
#     {
#       "type": "metric",
#       "x": 0,
#       "y": 0,
#       "width": 12,
#       "height": 6,
#       "properties": {
#         "metrics": [
#           [
#             "AWS/EC2",
#             "NetworkIn",
#             "Instanceld",
#             "${aws_instance.USTeam2_ACP-web.id}"
#           ]
#         ],
#         "period": 300,
#         "stat": "Average",
#         "region": "us-east-1",
#         "title": "EC2 Network In"
#       }
#     }
#   ]
# }
# EOF
# }

# #Create SNS Topic
# resource "aws_sns_topic" "ACPET1-alarms-topic" {
#   name = "ACPET1-alarms-topic"
#   delivery_policy = jsonencode({
#     "http" : {
#       "defaultHealthyRetryPolicy" : {
#         "minDelayTarget" : 20,
#         "maxDelayTarget" : 20,
#         "numRetries" : 3,
#         "numMaxDelayRetries" : 0,
#         "numNoDelayRetries" : 0,
#         "numMinDelayRetries" : 0,
#         "backoffFunction" : "linear"
#       },
#       "disableSubscriptionOverrides" : false,
#       "defaultThrottlePolicy" : {
#         "maxReceivesPerSecond" : 1
#       }
#     }
#   })
# }

# locals {
#   emails = ["aadediji@cloudhight.com", "toshomah@cloudhight.com"]
# }

# # Create Cloudwatch Alarm
# resource "aws_cloudwatch_metric_alarm" "USTeams2_ACP_metricalarm" {
#   alarm_name          = "USTeams2_ACP_metricalarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "80"
#   dimensions = {
#     AutoScalingGroupName = "${aws_autoscaling_group.USTeam2_ACP-asg.name}"
#   }
#   alarm_description = "This metric monitors ec2 cpu utilization"
#   alarm_actions     = [aws_autoscaling_policy.usteam2-acp-asgpol.arn]
# }

# # Create Cloud watch metric alarm for Health
# resource "aws_cloudwatch_metric_alarm" "USTeam2_ACP-metric-health-alarm" {
#   alarm_name          = "USTeam2-ACP-health-metric"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "StatusCheckFailed"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "1"
#   dimensions = {
#     "AutoScalingGroupName" = "${aws_autoscaling_group.USTeam2_ACP-asg.name}"
#   }
#   alarm_description = "This metric monitors ec2 health status"
#   alarm_actions     = ["${aws_autoscaling_policy.usteam2-acp-asgpol.arn}"]
# }

# # Creating Amazon EFS File system
# resource "aws_efs_file_system" "myfilesystem" {
# # Creating the AWS EFS lifecycle policy
# # Amazon EFS supports two lifecycle policies. Transition into IA and Transition out of IA
# # Transition into IA transition files into the file systems's Infrequent Access storage class
# # Transition files out of IA storage
#   creation_token = "efs"
#   performance_mode = "generalPurpose"
#   throughput_mode = "bursting"
#   encrypted = "true"
#   lifecycle_policy {
#     transition_to_ia = "AFTER_30_DAYS"
#   }
# # Tagging the EFS File system with its value as Myfilesystem
#   tags = {
#     Name = "Myfilesystem"
#   }
# }

# # Creating the EFS access point for AWS EFS File system
# resource "aws_efs_access_point" "test" {
#   file_system_id = aws_efs_file_system.myfilesystem.id
# }
# # Creating the AWS EFS System policy to transition files into and out of the file system.
# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.myfilesystem.id
# # The EFS System Policy allows clients to mount, read and perform 
# # write operations on File system 
# # The communication of client and EFS is set using aws:secureTransport Option
#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Id": "Policy01",
#     "Statement": [
#         {
#             "Sid": "Statement",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "*"
#             },
#             "Resource": "${aws_efs_file_system.myfilesystem.arn}",
#             "Action": [
#                 "elasticfilesystem:ClientMount",
#                 "elasticfilesystem:ClientRootAccess",
#                 "elasticfilesystem:ClientWrite"
#             ],
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "false"
#                 }
#             }
#         }
#     ]
# }
# POLICY
# }
# # Creating the AWS EFS Mount point in a specified Subnet 
# # AWS EFS Mount point uses File system ID to launch.
# resource "aws_efs_mount_target" "alpha" {
#   # availability_zone = var.public_subnet1_availabilityzone
#   file_system_id = aws_efs_file_system.myfilesystem.id
#   subnet_id      = aws_subnet.USTeam2_ACP_Private_SN1.id
#   security_groups = [aws_security_group.USTeam2_ACP_Backend_SG.id]
# }
# #creating elasticache
# resource "aws_elasticache_replication_group" "elasticache-cluster" {
#   availability_zones            		= ["${var.private_subnet2_availabilityzone}"]
#   replication_group_id          		= "tf-${var.environment}-rep-group"
#   replication_group_description 	= "${var.environment} replication group"
#   node_type                     		= "${var.node_type}"
#   number_cache_clusters         	= "${var.node_count}"
#   parameter_group_name          	= "default.redis6.x"
#   port                          			= 6379
# }