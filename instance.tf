

resource "aws_instance" "bastion_host" {
  ami             = "ami-0440d3b780d96b29d"
  #0440d3b780d96b29d # double check ami-0e731c8a588258d0d
  instance_type   = "t2.micro"
  key_name = aws_key_pair.mykeypair.key_name
  subnet_id       = aws_subnet.public_subnet.id
  # vpc_security_group_ids = [aws_security_group.bastion-allow-ssh.id]

   user_data                  = filebase64("web-script.sh")
   #path = 

   monitoring                 = true
   vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
   associate_public_ip_address = true


}
