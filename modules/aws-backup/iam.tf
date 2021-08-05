resource "aws_iam_role" "backup_role" {
  provider           = aws.region-master
  name               = "AWSBackupDefaultServiceRole"
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

resource "aws_iam_role_policy_attachment" "backup_attachment" {
  provider   = aws.region-master
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
                
  role       = aws_iam_role.backup_role.name


}
