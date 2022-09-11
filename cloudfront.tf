resource "aws_cloudfront_distribution" "cf" {
  comment         = "rp-server.site"
  aliases         = ["rp-server.site"]
  enabled         = true
  is_ipv6_enabled = true
#  web_acl_id      = var.waf
  logging_config {
    bucket = "sandbox-cloudfront-log"
    include_cookies = false
  }
  origin {
     domain_name = aws_lb.web-alb.dns_name
     origin_id   = aws_lb.web-alb.dns_name
     custom_origin_config {
       http_port              = 80
       https_port             = 443
       origin_protocol_policy = "https-only"
       origin_ssl_protocols   = ["TLSv1.1"]
     }
   }
  restrictions {
      geo_restriction {
      restriction_type = "none"
      }
    }
  viewer_certificate {
       acm_certificate_arn      = aws_acm_certificate.cert-rp.arn
       ssl_support_method       = "sni-only"
       minimum_protocol_version = "TLSv1.2_2021"
    }
 default_cache_behavior {
     allowed_methods  = ["GET", "HEAD"]
     cached_methods   = ["GET", "HEAD"]
     target_origin_id = aws_lb.web-alb.dns_name
     viewer_protocol_policy = "redirect-to-https"
     compress               = true
#   origin_request_policy_id = aws_cloudfront_origin_request_policy.origin-policy.id
#    cache_policy_id          = aws_cloudfront_cache_policy.cache-policy-60s.id
 }
#  ordered_cache_behavior {
#    path_pattern     = "/*"
#    allowed_methods  = ["GET", "HEAD"]
#    cached_methods   = ["GET", "HEAD"]
#    target_origin_id =  var.origin_cloudfront
#    viewer_protocol_policy = "redirect-to-https"
#    compress               = true
#    origin_request_policy_id = aws_cloudfront_origin_request_policy.origin-policy.id
#    cache_policy_id          = aws_cloudfront_cache_policy.cache-policy-60s.id
#   }
}