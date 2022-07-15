{
 "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${account-id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
      {% if policy == false %},
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.${region}.amazonaws.com"
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
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:region:${account-id}:log-group:*"
                }
            }
        }
      {% endif %}
    ]
}
