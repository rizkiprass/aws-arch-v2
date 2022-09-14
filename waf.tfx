resource "aws_wafv2_web_acl" "thiswaf" {
  name        = "sandbox-prod-waf-cf"
  description = "sandbox-prod-waf-cf"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesCommonRuleSet-metric"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "rule-2"
    priority = 2

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet-metric"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "rule-3"
    priority = 3

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesPHPRuleSet-metric"
      sampled_requests_enabled   = false
    }
  }



  tags = merge(local.common_tags, {
    Name                = format("%s-%s-waf-cf", var.Customer, var.environment),
  })

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "sandbox-prod-metric-name"
    sampled_requests_enabled   = false
  }
}
