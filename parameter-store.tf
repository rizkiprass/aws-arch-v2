resource "aws_ssm_parameter" "secret1" {
  name = "pras-sandbox-laravel-ps"
  type = "SecureString"
  value = file("template/laravel-ps.txt")
}

#Example ENV see at template/laravel-ps.txt)