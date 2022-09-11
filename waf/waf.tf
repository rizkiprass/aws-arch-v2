resource "aws_wafv2_web_acl" "thiswaf" {
  name        = "mnc-portal-aiml"
  description = "mnc-portal-aiml"
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



  tags = {
    Tag1 = "mnc-portal-aiml-prod"
    Tag2 = "Production"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "mnc-portal-metric-name"
    sampled_requests_enabled   = false
  }
}
