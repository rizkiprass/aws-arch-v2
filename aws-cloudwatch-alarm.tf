# locals {
# #   cwatch-alarm-instanceid-win   = [aws_instance.web2.id]
#   cwatch-alarm-instanceid-linux = [
#       aws_instance.Prod-App.id,
#       aws_instance.Dev-App.id,
#       aws_instance.Prod-Data.id,
#       aws_instance.openvpn.id
#       ] #TODO: Update with new instance for linux
# }
# resource "aws_sns_topic" "alert-sns-topic" {
#   name = format("%s-resource-alert-topic", var.project)

# #   provisioner "local-exec" {
# #     command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarms_email}"
# #   }
# }



# module "rc-cwatch-alarm-linux" {
#   count           = length(local.cwatch-alarm-instanceid-linux)
#   source          = "./modules/aws-cloudwatch-alarm"
#   sns-topic-arn   = aws_sns_topic.alert-sns-topic.arn
#   memory          = true
#   disk            = true
#   alarm-threshold = "80"
#   instance-id     = element(local.cwatch-alarm-instanceid-linux, count.index)
# }

# # module "rc-cwatch-alarm-win" {
# #   count           = length(local.cwatch-alarm-instanceid-win)
# #   source          = "./modules/aws-cloudwatch-alarm-windows"
# #   sns-topic-arn   = aws_sns_topic.alert-sns-topic.arn
# #   memory          = true
# #   cpu             = true # TODO: FixMe
# #   disk            = true
# #   alarm-threshold = "80"
# #   instance-id     = element(local.cwatch-alarm-instanceid-win, count.index)
# # }