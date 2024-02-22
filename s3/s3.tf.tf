provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "central"
  region = "us-west-1"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  name               = "tf-iam-role-rep1"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.source.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.source.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination.arn}/*"]
  }
}

resource "aws_iam_policy" "replication" {
  name   = "tf-iam-role-policy-rep1"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "destination" {
  bucket = "tf-test-bucket-dest1"
}

resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.destination.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "source" {
  provider = aws.central
  bucket   = "tf-test-bucket-sour1"
}

# resource "aws_s3_bucket_acl" "source_bucket_acl" {
#   provider = aws.central

#   bucket = aws_s3_bucket.source.id
#   acl    = "public-read-write"
# }

resource "aws_s3_bucket_versioning" "source" {
  provider = aws.central

  bucket = aws_s3_bucket.source.id
  versioning_configuration {
    status = "Enabled"

  }
}

# resource "aws_s3_bucket_replication_configuration" "replication" {
#   provider = aws.central
#   # Must have bucket versioning enabled first
#   depends_on = [aws_s3_bucket_versioning.source]
  

#   role   = aws_iam_role.replication.arn
#   bucket = aws_s3_bucket.source.id

#   rule {
#     id = "foobar"

#     filter {
#       prefix = "foo"
#     }

#     status = "Enabled"

    

#     destination {
#       bucket        = aws_s3_bucket.destination.arn
#       storage_class = "STANDARD"
#     }
#   }
# }

