resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "user"
  password             = "pass"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
#   vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
#   subnet_id = "aws.private_subnet.id"
}

resource "aws_db_subnet_group" "private" {
  name = "private"
  subnet_ids                   = [aws_subnet.private_subnet.id, aws_subnet.private_subnet-2.id]


}

