variable "vpc_cidr" {
    description = "Choosen cidr for vpc"
    type        = string   //if type is not mentioned, the default value datatype takes precedent.
    default     = "10.20.0.0/16"
}

variable "region" {
    description = "choosen region for your stack"
    type        = string
    default     = "us-east-1" 
}

//web ec2 counts
variable "web_ec2_count" {
    description = "number of EC2 counts for deployment"
    type        = string
    default     = "2" 
}

//S3 Bucket variables
variable "nb_app_s3_bucket" {
    default     = "nbhome-app-de" 
}

variable "nat_amis" {
    type = map
    default = {
        us-east-1 = "ami-083654bd07b5da81d"
        us-east-2 = "ami-0629230e074c580f2"
    }
}

variable "web_amis" {
    type = map
    default = {
        us-east-1 = "ami-083654bd07b5da81d"
        us-east-2 = "ami-0629230e074c580f2"
    }
}



variable "web_instance_type" {
    description = "choosen isntance instance type"
    type        = string
    default     = "t2.micro" 
}

variable "web_tags" {
    type = map
    default = {
        Name = "webserver"
    }
}