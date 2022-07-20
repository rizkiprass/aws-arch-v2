resource "aws_lb" "web-alb" {
  name               = format("%s-%s-app-alb", var.Customer, var.environment)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-alb-sg.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]

  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = format("%s-%s-web-alb", var.Customer, var.environment)
  })
}