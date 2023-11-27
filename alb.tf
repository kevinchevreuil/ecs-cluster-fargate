resource "aws_lb" "kaisen-ecs-fargate-alb" {
  name                             = "Kaisen-ECS-Fargate-ALB"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [module.aws_compute_base.sg]
  subnets                          = [module.aws_compute_base.public-subnet-a, module.aws_compute_base.public-subnet-b, module.aws_compute_base.public-subnet-c]
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  ip_address_type                  = "ipv4"
  preserve_host_header             = true
}

resource "aws_lb_target_group" "kaisen-ecs-fargate-alb-tg" {
  name                              = "Kaisen-ECS-Fargate-ALB-TG"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = module.aws_compute_base.vpc
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
  target_type                       = "ip"
  ip_address_type                   = "ipv4"
  protocol_version                  = "HTTP1"
  load_balancing_algorithm_type     = "round_robin"

  health_check {
    enabled  = true
    path     = "/"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "kaisen-ecs-fargate-alb-listener" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kaisen-ecs-fargate-alb-tg.arn
  }
  load_balancer_arn = aws_lb.kaisen-ecs-fargate-alb.arn
  port              = "80"
  protocol          = "HTTP"
}
