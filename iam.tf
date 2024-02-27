resource "aws_iam_role" "ec2_admin_role" {
  name = "EC2AdminRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ec2_admin_policy" {
  name        = "EC2AdminPolicy"
  description = "Policy for EC2 Admin"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_admin_policy_attachment" {
  policy_arn = aws_iam_policy.ec2_admin_policy.arn
  role       = aws_iam_role.ec2_admin_role.name
}



