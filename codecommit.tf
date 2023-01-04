resource "aws_codecommit_repository" "sandbox-cicd" {
  repository_name = "pras-sandbox-cicd"
  description     = "This is the Sample App Repository"
}