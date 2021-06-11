resource "aws_security_group" "vs_security_group_bastion_prod" {
  name = "allow_ssh"
  description = "Income: ssh OutCome: ssh"
  vpc_id = aws_vpc.vs_vpc_prod.id

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    description = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    description = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vs_security_group_bastion_prod"
  }
}

resource "aws_security_group" "vs_security_group_magento_prod" {
  name = "allow_mdc"
  description = "Income: http, https, ssh Outcome: mysql, smtp, amqp, elastic search, redis cache, rabbit mq, kafka"
  vpc_id = aws_vpc.vs_vpc_prod.id

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    description = "http"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    description = "https"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    description = "ssh"
    security_groups = [aws_security_group.vs_security_group_bastion_prod.id]
  }

  egress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    description = "mysql"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 25
    to_port = 25
    description = "smtp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 587
    to_port = 587
    description = "smtps"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 9200
    to_port = 9200
    description = "elastic search"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 6379
    to_port = 6379
    description = "redis cache"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 5672
    to_port = 5672
    description = "amqp queue"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 9092
    to_port = 9092
    description = "kafka queue"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vs_security_group_magento_prod"
  }
}