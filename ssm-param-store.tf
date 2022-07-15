resource "aws_ssm_parameter" "cw-agent-linux" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "cw-agent-linux-config"
  type        = "String"
  value       = file("template/config_linux.json")
}

resource "aws_ssm_parameter" "cw-agent-win" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "cw-agent-windows-config"
  type        = "String"
  value       = file("template/config_windows.json")
}
resource "aws_ssm_parameter" "cw-agent-win-log" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "cw-agent-windows-wlog-config"
  type        = "String"
  value       = file("template/config_windows.json")
}