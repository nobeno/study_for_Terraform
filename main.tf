// Provider specific configs
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-northeast-1"
}

resource "aws_vpc" "myTestVPC_for_terraform" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name = "myTestVPC_for_terraform"
  }
}

resource "aws_subnet" "mySubnet01_for_terraform" {
  vpc_id = "${aws_vpc.myTestVPC_for_terraform.id}"
  cidr_block = "10.1.1.0/24"
  tags = {
    Name = "mySubnet01_for_terraform"
  }  
}


resource "aws_instance" "myTestEC2_for_terraform" {
  instance_type = "t2.micro"
  ami = "${var.ami_id}"
  subnet_id = "${aws_subnet.mySubnet01_for_terraform.id}"
  tags = {
    Name = "myTestEC2_for_terraform"
  }
}


