resource "aws_iam_role" "awsbackup" {
  count              = var.create_iam_role ? 1 : 0
  name_prefix        = "AWS-Backup-Role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "awsbackup" {
  count      = var.create_iam_role ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.awsbackup[0].name
}

#Create a Vault for Storing Backup
resource "aws_backup_vault" "BackupVault" {
  name = var.backup_vault_name
  tags = merge(var.backup_vault_tag, {
    Name = var.backup_vault_name,
  })
}

resource "aws_backup_plan" "BackupDaily-Plan" {
  name = "BackupDaily-Plan"

  rule {
    rule_name         = "BackupDaily"
    target_vault_name = aws_backup_vault.BackupVault.name
    schedule          = "cron(0 16 ? * * *)"
    start_window      = 60
    completion_window = 120
    lifecycle {
      delete_after = var.daily_retention_in_days
    }
  }
}
#Weekly backup plan with the retention of 31 day
resource "aws_backup_plan" "BackupWeekly-Plan" {
  name = "BackupWeekly-Plan"

  rule {
    rule_name         = "BackupWeekly"
    target_vault_name = aws_backup_vault.BackupVault.name
    //weekly at 1 AM sunday
    schedule          = "cron(0 18 ? * 7 *)"
    start_window      = 60
    completion_window = 120
    //Set to cold storage after 1 day of creation and delete after 91 days(min 90 days)
    lifecycle {
      delete_after = var.weekly_retention_in_days
    }
  }
}
resource "aws_backup_plan" "BackupWeekly-cold-Plan" {
  name = "BackupWeekly-cold-Plan"

  rule {
    rule_name         = "BackupWeekly-cold"
    target_vault_name = aws_backup_vault.BackupVault.name
    //weekly at 1 AM sunday
    schedule          = "cron(0 18 ? * 7 *)"
    start_window      = 60
    completion_window = 360
    //Set to cold storage after 1 day of creation and delete after 91 days(min 90 days)
    lifecycle {
      cold_storage_after = 1
      delete_after       = 91
    }
  }
}
resource "aws_backup_plan" "BackupMonthly-Plan" {
  name = "BackupMonthly-Plan"

  rule {
    rule_name         = "BackupMonthly"
    target_vault_name = aws_backup_vault.BackupVault.name
    //Monthly at 1 AM 1st day
    schedule          = "cron(0 18 1 * ? *)"
    start_window      = 60
    completion_window = 120
    lifecycle {
      delete_after = var.monthly_retention_in_days
    }
  }
}


resource "aws_backup_selection" "selection-daily" {
  iam_role_arn = var.create_iam_role ? aws_iam_role.awsbackup[0].arn : var.iam_role
  name         = "selection"
  plan_id      = aws_backup_plan.BackupDaily-Plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "DailyBackup"
  }
}
resource "aws_backup_selection" "selection-weekly" {
  iam_role_arn = var.create_iam_role ? aws_iam_role.awsbackup[0].arn : var.iam_role
  name         = "selection-weekly"
  plan_id      = aws_backup_plan.BackupWeekly-Plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "WeeklyBackup"
  }
}
resource "aws_backup_selection" "selection-weekly-cold" {
  iam_role_arn = var.create_iam_role ? aws_iam_role.awsbackup[0].arn : var.iam_role
  name         = "selection-weekly-cold"
  plan_id      = aws_backup_plan.BackupWeekly-cold-Plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "WeeklyBackupCold"
  }
}
resource "aws_backup_selection" "selection-monthly" {
  iam_role_arn = var.create_iam_role ? aws_iam_role.awsbackup[0].arn : var.iam_role
  name         = "selection-monthly"
  plan_id      = aws_backup_plan.BackupMonthly-Plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "MonthlyBackup"
  }
}


