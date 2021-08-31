
variable "port_web_server" {
  type = number
  default = 8081
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = var.port_web_server
    to_port = var.port_web_server
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami = "ami-064819abc1d82ae10"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p ${var.port_web_server} &
              EOF

  tags = {
    Name = "terraform-example-1"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

