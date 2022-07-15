variable "daily_retention_in_days" {
  type        = number
  description = "Daily Backup Retention In Days"
  default     = 7
}

variable "weekly_retention_in_days" {
  type        = number
  description = "Weekly Backup Retention in Days"
  default     = 31
}

variable "monthly_retention_in_days" {
  type        = number
  description = "Weekly Backup Retention in Days"
  default     = 31
}

variable "backup_vault_name" {
  type        = string
  description = "Backup Vault Name"
}

variable "create_iam_role" {
  type    = bool
  default = true
}
variable "backup_vault_tag" {
  default = {}
  description = "Custom Tag Backup Vault"
}
variable "iam_role" {
  type    = string
  default = ""
}
