# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {
}

# https://docs.aws.amazon.com/config/latest/developerguide/cloudwatch-log-group-encrypted.html
data "template_file" "policy_template_kms" {
  template = <<JSON
{
 "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::$${account-id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.$${region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:$${region}:$${account-id}:log-group:*"
                }
            }
        }
    ]
}
JSON
  vars = {
    policy = var.key_policy
    account-id = data.aws_caller_identity.current.account_id
    region = var.region
  }
}

resource "aws_kms_key" "key" {
  description = var.description
  key_usage = "ENCRYPT_DECRYPT"
  policy = var.key_policy ? data.template_file.policy_template_kms.rendered : ""
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled = true
  enable_key_rotation = true
  tags = merge(
  {
    Description = var.description
    Environment = var.environment
    Name = var.alias_name
    ProductDomain = var.product_domain
    ManagedBy = "terraform"
  },
  var.additional_tags,
  )
}

resource "aws_kms_alias" "key_alias" {
  name = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.key.id
}
