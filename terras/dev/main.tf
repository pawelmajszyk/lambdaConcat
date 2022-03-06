provider "aws" {
  region = "eu-central-1"
}
#module "my_vpc" {
#  vpc_cidr = "192.168.0.0/16"
#  source = "../modules/vpc"
#  subnet1_cidr = "192.168.1.0/24"
#  subnet2_cidr = "192.168.2.0/24"
#  subnet3_cidr = "192.168.3.0/24"
#  subnet4_cidr = "192.168.4.0/24"
#  vpc_id = "${module.my_vpc.vpc_id}"
#
#}

module "my_bucket" {
  source = "../modules/s3"
  bucket_name = "nowyasdasdasdq"
  bucket_arn = "${module.my_bucket.bucket_arn}"
}

module "iam" {
  source = "../modules/iam"
  bucket_arn = "${module.my_bucket.bucket_arn}"
  bucket_id = "${module.my_bucket.bucket_id}"
}