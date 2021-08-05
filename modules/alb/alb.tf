resource "aws_lb" "LB-Prod" {
  provider           = aws.region-master
  name               = "LB-Prod"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.SG-LB-Prod]
  subnets            = [var.SB-Prod-1, var.SB-Prod-2]
  tags = {
    Name = "LB-Prod"
  }
}

resource "aws_lb_target_group" "Prod-TargetGroup" {
  provider    = aws.region-master
  name        = "Prod-TargetGroup"
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

resource "aws_lb_target_group" "Prod-webmin" {
  provider    = aws.region-master
  name        = "Prod-webmin"
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

#Adiciona a instancia como target
resource "aws_lb_target_group_attachment" "Prod-webmin" {
  target_group_arn = aws_lb_target_group.Prod-webmin.arn
  target_id        = var.Appserver
  port             = 10000
}

#Adiciona a instancia como target
  resource "aws_lb_target_group_attachment" "Prod-TargetGroup" {
  target_group_arn = aws_lb_target_group.Prod-TargetGroup.arn
  target_id        = var.Appserver
  port             = 80
}

resource "aws_lb_listener" "LB-Prod-listener-http" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.LB-Prod.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Prod-TargetGroup.id
  }
}

resource "aws_lb_listener" "LB-Prod-listener-10000" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.LB-Prod.arn
  port              = "10000"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Prod-webmin.id
  }
}
