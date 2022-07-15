# module "main-backup" {
#   source            = "./modules/aws-backup"
#   backup_vault_name = format("%s-%s-backup-vault", var.Customer, var.environment)
#   backup_vault_tag  = local.common_tags
# }