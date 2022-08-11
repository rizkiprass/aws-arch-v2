resource "aws_acm_certificate" "cert-rp" {
  domain_name       = "rp-server.site"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}