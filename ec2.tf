resource "aws_instance" "private_ec2" {
  ami           = "ami-0440d3b780d96b29d"  # Change to your desired AMI ID
  instance_type = "t2.micro"
  subnet_id      = aws_subnet.private_subnet.id  # Change to your private subnet ID
  # private_ip    = "10.0.2.10"  # Change to your desired private IP address
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  
  key_name = aws_key_pair.mykeypair.key_name
  #key_name      = "mykeypair"  # Change to your key pair name

  tags = {
    Name = "PrivateEC2"
  }

  # User data to install Nginx on startup
  ####              # amazon-linux-extras install nginx1.12 -y
              # systemctl start nginx
              # systemctl enable nginx
  user_data = <<-EOF
              #!/bin/bash
              amazon-linux-extras install nginx1.12 -y
              systemctl start nginx
              systemctl enable nginx
              echo "hello, Welcome to nginx !!!" > /var/www/html/index.html
              systemctl restart nginx

              EOF
}







# resource "aws_instance" "nginx" {
#   ami                         = "ami-0e731c8a588258d0d"
#   instance_type               = "t2.micro"
#   key_name                    = "mykeypair"
#   monitoring                  = true
#   vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
#   # security_group_ids = ["sg-0b2cc13eed33569ed"]
# # sg-0b2cc13eed33569ed
#   subnet_id                   = aws_subnet.private_subnet.id
#   associate_public_ip_address = true
#   # user_data = file("userdata.tpl")
#   user_data                  = filebase64("web-script.sh")

#   # tags {
#   #   Name = "nginx"
#   # }



# }



# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }


# resource "aws_launch_template" "nginx" {
#   name_prefix                 = var.name_prefix
#   image_id                    = data.aws_ami.ubuntu.id
#   instance_type               = var.instance_type
#   key_name                    = "mykeypair"
#   user_data                   = filebase64("web-script.sh")
#   vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  
#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }
# }

# resource "aws_autoscaling_group" "asg" {
#   availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
#   desired_capacity   = var.desired_capacity
#   max_size           = var.max_size
#   min_size           = 1

#   launch_template {
#     id      = aws_launch_template.nginx.id
#     version = "$Latest"
#   }
# }
