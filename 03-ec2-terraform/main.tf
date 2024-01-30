terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "fsuh_default_vpc" {
  tags = {
    Name = "Default VPC"
  }

}

resource "aws_security_group" "fsuh_http_server_sg" {
  name   = "fsuh_http_server_sg"
  vpc_id = aws_default_vpc.fsuh_default_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "fsuh_http_server_sg"

  }
}

resource "aws_instance" "fsuh_http_server" {
  ami                    = data.aws_ami.fsuh_awsLinux_2023.id
  key_name               = "fsuh_keypair"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.fsuh_http_server_sg.id]
  subnet_id              = data.aws_subnets.fsuh_default_subnets.ids[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      // install httpd
      "sudo yum install httpd -y",
      //start service
      "sudo service httpd start",
      // copy a file
      "echo Welcom fsuh - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
    ]

  }
}




