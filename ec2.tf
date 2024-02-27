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





