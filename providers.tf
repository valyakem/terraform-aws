provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "nb_vpc" {
  cidr_block        = "10.0.0.0/16"
  instance_tenancy  = "default"

  tags = {
    Name            = "NbVPC"
    Environment     = "Dev"
  }

  output "vpc_cidr" {
    value = "${aws.nb_vpc.id}"
  }
}