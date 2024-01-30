data "aws_subnets" "fsuh_default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.fsuh_default_vpc.id]
  }
}

data "aws_ami" "fsuh_awsLinux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*"]
  }

  # filter {
  #   name   = "root-device-type"
  #   values = ["ebs"]
  # }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

