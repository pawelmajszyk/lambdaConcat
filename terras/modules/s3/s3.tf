resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
output "bucket_arn" {
  value = "${aws_s3_bucket.b.arn}"
}

output "bucket_id" {
  value = "${aws_s3_bucket.b.id}"
}