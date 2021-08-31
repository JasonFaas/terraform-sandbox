provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami = "ami-064819abc1d82ae10"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-example-1"
  }
}

