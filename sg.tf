# resource "aws_security_group" "bastion-allow-ssh" {
#   vpc_id      = aws_vpc.my-vpc.id
#   name        = "bastion-allow-ssh"
#   description = "security group for bastion that allows ssh and all egress traffic"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "bastion-allow-ssh"
#   }
# }

# resource "aws_security_group" "private-ssh" {
#   vpc_id      = aws_vpc.my-vpc.id
#   name        = "private-ssh"
#   description = "security group for private that allows ssh and all egress traffic"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     security_groups = [ aws_security_group.bastion-allow-ssh.id ]
#   }
#   tags = {
#     Name = "private-ssh"
#   }
# }


resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.my-vpc.id
  name        = "security-group"
  description = "Allow SSH and http and https"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp" #icmp
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  # tags {
  #   Name = "sg"
  # }
}