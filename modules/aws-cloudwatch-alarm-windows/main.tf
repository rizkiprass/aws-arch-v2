data aws_instance "instance-lookup" {
  instance_id = var.instance-id
}
resource "aws_cloudwatch_metric_alarm" "instance-cpu" {
  count               = var.cpu ? 1 : 0
  alarm_name          = format("%s-cpu-above-%s", data.aws_instance.instance-lookup.tags["Name"], var.alarm-threshold)
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = var.alarm-threshold
  alarm_description   = "This metric monitors ec2 cpu utilization for instance ${data.aws_instance.instance-lookup.id}"
  alarm_actions = [
  var.sns-topic-arn]
  insufficient_data_actions = []
  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/EC2"
      period      = "300"
      stat        = "Average"
      unit        = "Percent"
      dimensions = {
        InstanceId = var.instance-id
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "instance-ram" {
  count               = var.memory ? 1 : 0
  alarm_name          = format("%s-mem-above-%s", data.aws_instance.instance-lookup.tags["Name"], var.alarm-threshold)
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = var.alarm-threshold
  alarm_description   = "This metric monitors ec2 RAM utilization for instance ${data.aws_instance.instance-lookup.id}"
  alarm_actions = [
  var.sns-topic-arn]
  insufficient_data_actions = []
  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "Memory % Committed Bytes In Use"
      namespace   = "CWAgent"
      period      = "300"
      stat        = "Average"
      unit        = "None"
      dimensions = {
        InstanceId   = var.instance-id
        InstanceType = data.aws_instance.instance-lookup.instance_type
        ImageId      = data.aws_instance.instance-lookup.ami
        objectname   = "Memory"
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "windows-instance-disk" {
  count               = var.disk ? 1 : 0
  alarm_name          = format("%s-disk-above-%s", data.aws_instance.instance-lookup.tags["Name"], var.alarm-threshold)
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = var.alarm-threshold
  alarm_description   = "This metric monitors ec2 Disk utilization (device nvme0n1p1) for instance ${data.aws_instance.instance-lookup.id} on partition ${var.disk-partition}"
  alarm_actions = [
  var.sns-topic-arn]
  insufficient_data_actions = []
  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "LogicalDisk % Free Space"
      namespace   = "CWAgent"
      period      = "300"
      stat        = "Average"
      unit        = "None"
      dimensions = {
        InstanceId   = var.instance-id
        InstanceType = data.aws_instance.instance-lookup.instance_type
        ImageId      = data.aws_instance.instance-lookup.ami
        instance     = var.disk-partition
        objectname   = "LogicalDisk"
      }
    }
  }
}

