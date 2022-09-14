resource "aws_cloudfront_distribution" "CloudFrontDistribution" {
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "https-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1.2"
            ]
        }
        domain_name = aws_lb.web-alb.dns_name
        origin_id = aws_lb.web-alb.dns_name

        origin_path = ""
    }

    logging_config {
    bucket          = "sandbox-cloudfront-log.s3.amazonaws.com"
    include_cookies = false
  }

    default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_lb.web-alb.dns_name
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    #   origin_request_policy_id = aws_cloudfront_origin_request_policy.origin-policy.id
    #    cache_policy_id          = aws_cloudfront_cache_policy.cache-policy-60s.id
  }
    comment = "rp-server.site"
    price_class = "PriceClass_All"
    enabled = true
    viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.cert-rp.arn
        cloudfront_default_certificate = true
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
    }
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    http_version = "http2"
    is_ipv6_enabled = true
}