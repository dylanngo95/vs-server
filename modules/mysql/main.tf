# MySQL Instance
resource "aws_db_instance" "vs_mysql" {
  allocated_storage = 100
  # auto scaling instance
  max_allocated_storage = 150
  engine = "mysql"
  identifier = var.NAME
  engine_version = var.ENGINE_VERSION
  instance_class = var.INSTANCE_CLASS
  db_subnet_group_name = var.DB_GROUP_SUBNET_NAME
  vpc_security_group_ids = var.MYSQL_SECURITY_GROUP
  parameter_group_name = "default.mysql8.0"
  storage_type = "io1"
  iops = 1000
  name = var.DATA_BASE_NAME
  username = var.DATABASE_USER_NAME
  password = var.DATABASE_PASSWORD

  provisioner "local-exec" {
    command = "echo ${aws_db_instance.vs_mysql.endpoint} >> vs_instance_mysql_enpoints.txt"
  }

  //  s3_import {
  //    source_engine         = "mysql"
  //    source_engine_version = var.ENGINE_VERSION
  //    bucket_name           = "vs-s3-prod"
  //    bucket_prefix         = "terraform/backups"
  //    ingestion_role        = "arn:aws:iam::1234567890:role/role-xtrabackup-rds-restore"
  //  }
}
