#module "asg" {
#  source  = "terraform-aws-modules/autoscaling/aws"
#  version = "~> 4.0"
#
#  # Autoscaling group
#  name            = format("%s-%s-asg-rpras", var.Customer, var.environment)
#  use_name_prefix = false
#  instance_name   = format("%s-%s-app-asg-rpras", var.Customer, var.environment)
#
#  min_size                  = 1
#  max_size                  = 2
#  desired_capacity          = 1
#  wait_for_capacity_timeout = 0
#  health_check_type         = "EC2"
#  vpc_zone_identifier       = ["subnet-0276291eb4c933b83", "subnet-0cce4c2f94728406b"]
#
##  instance_refresh = {
##    strategy = "Rolling"
##    preferences = {
##      checkpoint_delay       = 600
##      checkpoint_percentages = [35, 70, 100]
##      instance_warmup        = 300
##      min_healthy_percentage = 50
##    }
##    triggers = ["tag"]
##  }
#
#  # Launch configuration
#  lc_name   = format("%s-%s-lc-rpras", var.Customer, var.environment)
#  use_lc    = true
#  create_lc = true
#
#  image_id          = "ami-04505e74c0741db8d"
#  instance_type     = "t2.micro"
#
#  iam_instance_profile_arn    = aws_iam_instance_profile.ssm-profile.arn
#  security_groups             = aws_security_group.Prod-App-sg.id
#
#  target_group_arns = aws_lb_target_group.albtg-prod-app.arn
#
#  ebs_block_device = [
#    {
#      device_name           = "/dev/xvda"
#      delete_on_termination = true
#      encrypted             = true
#      volume_type           = "gp2"
#      volume_size           = "50"
#    },
#  ]
#
#  root_block_device = [
#    {
#      delete_on_termination = true
#      encrypted             = true
#      volume_size           = "50"
#      volume_type           = "gp2"
#    },
#  ]
#
#  tags_as_map = local.common_tags
#}