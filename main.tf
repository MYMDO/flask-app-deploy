# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" # Рекомендовано вказувати версію
    }
  }
}

provider "aws" {
  region = "us-west-2" # Заміни на бажаний регіон AWS (наприклад, eu-west-1 для Європи)
  # Credentials повинні бути налаштовані через AWS CLI профілі, змінні оточення, IAM roles, тощо
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b33aee474a12f" # Ubuntu 20.04 LTS, us-west-2. Заміни на AMI для твого регіону
  instance_type = "t2.micro" # Безкоштовний для Free Tier

  key_name = "your-aws-key-pair-name" # Заміни на ім'я твого AWS Key Pair (створи його в AWS Management Console, якщо немає)

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  tags = {
    Name = "flask-web-server"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP traffic"
  vpc_id      = "vpc-xxxxxxxxxxxxxxxxx" # Заміни на ID твого VPC (або створи новий VPC в Terraform, якщо потрібно)

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Дозволити доступ з будь-якої IP адреси (для простого прикладу, в продакшн обмежте)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Дозволити вихідний трафік на будь-яку IP адресу (для простого прикладу)
  }
}

output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP address of the web server"
}
