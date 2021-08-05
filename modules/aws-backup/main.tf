#Backup Vault to store the backups
resource "aws_backup_vault" "vault" {
  provider = aws.region-master
  name     = "Compact"
}

resource "aws_backup_plan" "backup_plan" {
  provider = aws.region-master
  name     = "Backup-compact"

  rule {
    rule_name         = "DailyBackups"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = "cron(50 16 ? * MON-FRI *)"
    lifecycle {
      cold_storage_after = 0
      delete_after       = "7"
    }
  }

  tags = {
    "Service" = "Backup"
  }
}

resource "aws_backup_selection" "backup_resources" {
  provider     = aws.region-master
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "Compact-Backup"
  plan_id      = aws_backup_plan.backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "AWSbackup"
    value = "Yes"
  }
}
