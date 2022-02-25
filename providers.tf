provider "aws"{
    region = "ca-central-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "nb_VPC"
  }
}


output "vpc_cidr" {
  value = ["${aws_vpc.main.id}", "${aws_vpc.main.arn}"]
}