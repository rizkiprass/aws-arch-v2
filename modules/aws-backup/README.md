Example:<br>
module "riski-backup" {<br>
  source = "./modules/aws-backup"<br>
  backup-vault-name = "rc-backup-test"<br>
  environment = "prod"<br>
}