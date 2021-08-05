
#Get the most recent snapshot indetifier of database-1 
data "aws_db_snapshot" "latest_prod_snapshot" {
  provider               = aws.region-master
  db_instance_identifier = "database-1"
  most_recent            = true
}

# Use the latest production snapshot to create a dev instance.
resource "aws_db_instance" "LojaOnline" {
  identifier = "lojaonline"
  provider             = aws.region-master
  instance_class       = "db.t2.micro"
  db_subnet_group_name = var.subnetgroup
  snapshot_identifier  = data.aws_db_snapshot.latest_prod_snapshot.id
  skip_final_snapshot  = true

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }

}

resource "aws_db_instance" "crrds" {
  identifier = "crrds"
  provider             = aws.region-master
  instance_class       = "db.t2.micro"
  db_subnet_group_name = var.subnetgroup
  snapshot_identifier  = data.aws_db_snapshot.latest_prod_snapshot.id
  skip_final_snapshot  = true

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }

}