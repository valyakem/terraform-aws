resource "aws_vpc" "nb_app" {
    cidr_block       = "${var.vpc_cidr}"
    instance_tenancy = "default"

  tags = {
    Name = "nbappVPC"
    Environment = "${terraform.workspace}"
  }
}