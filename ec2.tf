provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_vpc" "general" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "general" {
  vpc_id     = aws_vpc.general.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "general" {
  vpc_id = aws_vpc.general.id
}

resource "aws_route" "general_internet" {
  route_table_id         = aws_vpc.general.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.general.id
}

resource "aws_security_group" "general" {
  vpc_id = aws_vpc.general.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "general" {
  key_name   = "terraform_key"
  public_key = file("~/.ssh/terraform.pub")
}

resource "aws_instance" "general" {
  key_name                    = aws_key_pair.general.key_name
  ami                         = "ami-0701e7be9b2a77600"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.general.id]
  subnet_id                   = aws_subnet.general.id
  associate_public_ip_address = true
}
