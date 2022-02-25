# resource "aws_s3_bucket" "nbbucket" {
#   bucket = "${var.nb_app_s3_bucket}"
#   acl = "private"
#   //region = "${var.region}"

#   tags = {
#     Name = "nbhome-app-de"
#     Environment = "${terraform.workspace}"
#   }
# }

