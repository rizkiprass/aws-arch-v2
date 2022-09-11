variable "origin_cloudfront" {
    default = "mnc-portal-aiml-alb-production-1469286990.ap-southeast-1.elb.amazonaws.com"
 }
variable "waf" {
    default = "arn:aws:wafv2:us-east-1:261187130022:global/webacl/mnc-portal-aiml/3b5a58bd-02ac-4981-9097-26e535e8f1b9"
}
variable "cf_ssl_crt_2" {
    default = "arn:aws:acm:us-east-1:261187130022:certificate/4641c5a0-7cc0-4851-96b1-f0a929c947ae"
}
