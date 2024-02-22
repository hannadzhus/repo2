# resource "aws_s3_bucket" "example" {
#   bucket = "tf-test-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# #####... other configuration ...

# resource "aws_s3_bucket" "bucket-m" {
#   bucket = "bucket-m"
# }

# resource "aws_s3_bucket_acl" "bucket-m" {
#   bucket = aws_s3_bucket.bucket-m.id
#   acl = "private"
# }


