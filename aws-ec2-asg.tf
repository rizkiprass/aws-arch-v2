module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = format("%s-%s-webserver-asg-name", var.Customer, var.environment)

  # Launch configuration
  lc_name = "sandbox-prod-webserver-lc"

  image_id        = var.ami-ubuntu
  instance_type   = "t3.medium"
  security_groups = [aws_security_group.web-sg.id]
  termination_policies = ["OldestInstance"]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp3"
    },
  ]

  enable_monitoring = true

  # Auto scaling group
  asg_name                  = "sandbox-prod-webserver-asg"
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  health_check_type         = "ELB"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  iam_instance_profile_arn    = aws_iam_instance_profile.ssm-profile.name

  #Target Group
  target_group_arns = [aws_lb_target_group.albtg-web-app.arn]
#  tags_as_map       = local.common_tags

  tags = merge(local.common_tags, {
      Name = format("%s-%s-webserver-asg-tagname", var.Customer, var.environment)
    })
}

#Automatic Scale
resource "aws_autoscaling_policy" "sandbox-scale-out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = module.asg.autoscaling_group_name //see outputs

}
resource "aws_autoscaling_policy" "sandbox-scale-in" {
  name                   = "scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = module.asg.autoscaling_group_name
}