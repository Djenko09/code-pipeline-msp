resource "aws_lb" "LojaOnlineALB" {
  provider           = aws.region-master
  name               = "LojaOnlineALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.SG-LB-Prod]
  subnets            = [var.SB-Prod-1, var.SB-Prod-2]
  tags = {
    Name = "LojaOnlineALB"
  }
}

resource "aws_lb_target_group" "LojaOnline-80" {
  provider    = aws.region-master
  name        = "LojaOnline-80"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = 80
    protocol = "HTTP"
    matcher  = "200-299"
  }
}

resource "aws_lb_target_group" "LojaOnline-10000" {
  provider    = aws.region-master
  name        = "LojaOnline-10000"
  port        = 10000
  target_type = "instance"
  vpc_id      = var.vpc
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = 10000
    protocol = "HTTP"
    matcher  = "200-299"
  }
}

  resource "aws_lb_target_group_attachment" "LojaOnline-80" {
  target_group_arn = aws_lb_target_group.LojaOnline-80.arn
  target_id        = var.LojaOnline
  port             = 80
}

 resource "aws_lb_target_group_attachment" "LojaOnline-10000" {
  target_group_arn = aws_lb_target_group.LojaOnline-10000.arn
  target_id        = var.LojaOnline
  port             = 10000
}

resource "aws_lb_listener" "LojaOnlineALB-listener-http" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.LojaOnlineALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LojaOnline-80.id
  }
}

resource "aws_lb_listener" "LojaOnlineALB-listener-10000" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.LojaOnlineALB.arn
  port              = "10000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LojaOnline-10000.id
  }
}
