#cache-policy
resource "aws_cloudfront_cache_policy" "cache-policy-60s" {
  name        = "cache-policy-60s"
  comment     = "cache-policy-60s"
  default_ttl = 60
  max_ttl     = 60
  min_ttl     = 60
  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Host"]
      }
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    cookies_config {
     cookie_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}

#origin-policy
resource "aws_cloudfront_origin_request_policy" "origin-policy" {
  name    = "origin-policy"
  comment = "Origin Policy With Header, Cookie, & Query String"

  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["Origin", "Host", "user-agent"]
    }
  }
  query_strings_config {
     query_string_behavior = "none"
  }
   cookies_config {
     cookie_behavior = "none"
  }
}
