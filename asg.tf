resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"

#   version_description = "Initial version"

  image_id          = "ami-0c7217cdde317cfec"
  instance_type     = "t2.micro"
#   security_group_ids = ["sg-0475aa477040f6d79"]
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  desired_capacity     = 3
  max_size             = 5
  min_size             = 1
  vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
}
