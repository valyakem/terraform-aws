provider "aws" {
    region = "${var.region}"
}

# terraform {
#   backend "s3" {
#     bucket          = "nbterraformbackend"
#     key             = "terraform.tfstate"
#     region          = "us-east-1"
#     dynamodb_table  = "nblock-tf"
#   }
# }
