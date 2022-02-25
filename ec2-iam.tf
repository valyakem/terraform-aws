# data "template_file" "s3_web_policy" {
#     template = "${file("scripts/iam/web-ec2-policy.json")}"
#     vars = {
#         s3_bucket_arn = "{arn:aws:s3:::${var.nb_app_s3_bucket}/*"
#     }
# }