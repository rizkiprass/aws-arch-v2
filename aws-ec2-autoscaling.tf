module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name            = format("%s-%s-web-asg", var.Customer, var.environment)
  use_name_prefix = false
  instance_name   = format("%s-%s-app-web-asg", var.Customer, var.environment)

  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.intra_subnets[0], module.vpc.intra_subnets[1]]

#  instance_refresh = {
#    strategy = "Rolling"
#    preferences = {
#      checkpoint_delay       = 600
#      checkpoint_percentages = [35, 70, 100]
#      instance_warmup        = 300
#      min_healthy_percentage = 50
#    }
#    triggers = ["tag"]
#  }

  # Launch configuration
  lc_name   = format("%s-%s-web-lc", var.Customer, var.environment)
  use_lc    = true
  create_lc = false

  image_id          = "ami-04505e74c0741db8d"
  instance_type     = "t3.medium"

  iam_instance_profile_arn    = aws_iam_instance_profile.ssm-profile.arn
  security_groups             = aws_security_group.web-sg.id

  target_group_arns = aws_lb_target_group.albtg-web-app.arn

  ebs_block_device = [
    {
      device_name           = "/dev/xvda"
      delete_on_termination = true
      encrypted             = true
      volume_type           = "gp3"
      volume_size           = "50"
    },
  ]

  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = true
      volume_size           = "50"
      volume_type           = "gp3"
    },
  ]

  tags_as_map = local.common_tags
}