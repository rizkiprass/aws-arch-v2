module "autoscaling-launchtemplate" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 6.7.0"


  # Autoscaling group
  name            = format("%s-%s-webserver-asg", var.customer, var.environment)
  use_name_prefix = false
#  instance_name   = "my-instance-name"

#  ignore_desired_capacity_changes = true

  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  default_instance_warmup   = 300
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets

  # Launch template
  launch_template_name        = format("%s-%s-webserver", var.customer, var.environment)
  launch_template_description = "webserver-lt"
  update_default_version      = true
  key_name             = "webmaster-key"
  termination_policies = ["OldestInstance"]

  image_id          = "ami-0bc3e55f290310f38"
  instance_type     = "t3.micro"
#  user_data         = base64encode(local.user_data)

  iam_instance_profile_arn = aws_iam_instance_profile.ssm-profile.arn

  security_groups      = [aws_security_group.web-sg.id]

  target_group_arns = [aws_lb_target_group.albtg-web-asg.arn]
#  enable_monitoring = true

#  block_device_mappings = [
#    {
#      # Root volume
#      device_name = "/dev/xvda"
#      no_device   = 0
#      ebs         = {
#        delete_on_termination = true
#        encrypted             = true
#        volume_size           = 20
#        volume_type           = "gp3"
#      }
#    }, {
#      device_name = "/dev/sda1"
#      no_device   = 1
#      ebs         = {
#        delete_on_termination = true
#        encrypted             = true
#        volume_size           = 30
#        volume_type           = "gp2"
#      }
#    }
#  ]



  tags = local.common_tags

}