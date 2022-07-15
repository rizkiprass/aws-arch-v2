resource "aws_securityhub_account" "main-account" {}

resource "aws_securityhub_standards_subscription" "main-account" {
  count = var.cis ? 1:0
  depends_on    = [aws_securityhub_account.main-account]
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
}
resource "aws_securityhub_standards_subscription" "main-account-pci-321" {
  count = var.pci ? 1:0
  depends_on    = [aws_securityhub_account.main-account]
  standards_arn = "arn:aws:securityhub:us-east-1::standards/pci-dss/v/3.2.1"
}

