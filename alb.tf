resource "aws_lb" "my_load_balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups      = ["${aws_security_group.sg.id}"]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  enable_deletion_protection = false

  enable_http2 = true

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  health_check {
    path                = "/index.html"
    port                = 80
    protocol            = "HTTP"
    unhealthy_threshold = 2
    healthy_threshold   = 5
    timeout             = 10
  }

  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}



