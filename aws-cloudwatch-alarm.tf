 locals {
 #   cwatch-alarm-instanceid-win   = [aws_instance.web2.id]
   cwatch-alarm-instanceid-linux = [
       aws_instance.web-app.id,
       aws_instance.jenkins-app.id,
       aws_instance.bastion.id,
       ] #TODO: Update with new instance for linux
 }
 resource "aws_sns_topic" "alert-sns-topic" {
   name = format("%s-resource-alert-topic", var.project)

 #   provisioner "local-exec" {
 #     command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarms_email}"
 #   }
 }



 module "rc-cwatch-alarm-linux" {
   count           = length(local.cwatch-alarm-instanceid-linux)
   source          = "./modules/aws-cloudwatch-alarm"
   sns-topic-arn   = aws_sns_topic.alert-sns-topic.arn
   memory          = true
   disk            = true
   alarm-threshold = "80"
   instance-id     = element(local.cwatch-alarm-instanceid-linux, count.index)
 }

 # module "rc-cwatch-alarm-win" {
 #   count           = length(local.cwatch-alarm-instanceid-win)
 #   source          = "./modules/aws-cloudwatch-alarm-windows"
 #   sns-topic-arn   = aws_sns_topic.alert-sns-topic.arn
 #   memory          = true
 #   cpu             = true # TODO: FixMe
 #   disk            = true
 #   alarm-threshold = "80"
 #   instance-id     = element(local.cwatch-alarm-instanceid-win, count.index)
 # }

 //asg-cloudwatch
resource "aws_cloudwatch_metric_alarm" "sandbox-web-cpu-above" {
  alarm_name          = format("%s-%s-web-utoscale-cpu-above", var.Customer, var.environment)
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = format("%s-%s-web-autoscale-cpu-above", var.Customer, var.environment)
  alarm_actions = [
    aws_autoscaling_policy.sandbox-scale-out.arn,
     aws_sns_topic.alert-sns-topic.arn
  ]
  dimensions = {
    AutoScalingGroupName = module.webserversg.this_autoscaling_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "bogordaily-webserverutoscale-cpu-below" {
  alarm_name          = format("%s-%s-bogordaily-webserverutoscale-cpu-below", var.Customer, var.environment)
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"
  alarm_description   = format("%s-%s-web-autoscale-cpu-below", var.Customer, var.environment)
  alarm_actions = [
    aws_autoscaling_policy.sandbox-scale-in.arn,
   aws_sns_topic.alert-sns-topic.arn
  ]
  dimensions = {
    AutoScalingGroupName = module.webserversg.this_autoscaling_group_name
  }
}