module "waf" {
  source  = "umotif-public/waf-webaclv2/aws"
  version = "5.1.2"

  name_prefix = "pras-test-waf"
  alb_arn     = aws_lb.app-alb.arn

  scope = "REGIONAL"

  create_alb_association = true

  allow_default_action = true # set to allow if not specified

  visibility_config = {
    metric_name = "pras-test-waf-metrics"
  }

  rules = [
    {
      name     = "AWSManagedRulesCommonRuleSet-rule-1"
      priority = "1"

      override_action = "count"

      managed_rule_group_statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }

      visibility_config = {
#        cloudwatch_metrics_enabled = false
        metric_name                = "AWSManagedRulesCommonRuleSet-metric"
#        sampled_requests_enabled   = false
      }
    },
    {
      name     = "AWSManagedRulesKnownBadInputsRuleSet-rule-2"
      priority = "2"

      override_action = "count"

      managed_rule_group_statement = {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }

      visibility_config = {
        metric_name = "AWSManagedRulesKnownBadInputsRuleSet-metric"
      }
    },
        {
      name     = "AWSManagedRulesKnownBadInputsRuleSet-rule-3"
      priority = "3"

      override_action = "count"

      managed_rule_group_statement = {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }

      visibility_config = {
        metric_name = "AWSManagedRulesKnownBadInputsRuleSet-metric"
      }
    },
    {
      name     = "AWSManagedRulesAmazonIpReputationList-rule-4"
      priority = "4"

      override_action = "count"

      managed_rule_group_statement = {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }

      visibility_config = {
        metric_name = "AWSManagedRulesAmazonIpReputationList-metric"
      }
    },
    {
      name     = "AWSManagedRulesAnonymousIpList-rule-5"
      priority = "5"

      override_action = "count"

      managed_rule_group_statement = {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }

      visibility_config = {
        metric_name = "AWSManagedRulesAnonymousIpList-metric"
      }
    }
  ]

  tags = {
    "Name" = "waf"
    "Env"  = "poc"
  }
}