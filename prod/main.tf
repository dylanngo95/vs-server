# AWS Credentials

resource "aws_key_pair" "credentials" {
  key_name = "VSKey"
  public_key = file("../global/credentials/VSKey.pub")
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = var.AWS_REGION
}

# Create new instances

module "vs_instance_bastion_prod" {
  source = "../modules/bastion"
  NAME = "vs_instance_bastion_prod"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_bastion_prod.id
}

module "vs_instance_magento_prod" {
  source = "../modules/magento"
  NAME = "vs_instance_magento_prod"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_magento_prod.id
}

module "vs_instance_magento_cron" {
  source = "../modules/cron"
  NAME = "vs_instance_cron_prod"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_magento_prod.id
}

module "vs_instance_es" {
  source = "../modules/elasticsearch"
  NAME = "vs_instance_es_prod"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_elastic_search_prod.id
}

//module "vs_mysql_prod" {
//  source = "../modules/mysql"
//  ENGINE_VERSION = "8.0.20"
//  INSTANCE_CLASS = "db.t2.micro"
//  DATABASE_USER_NAME = "admin"
//  DATABASE_PASSWORD = "admin123"
//  DATA_BASE_NAME = "vs_mysql_prod"
//  DB_GROUP_SUBNET_NAME = aws_db_subnet_group.vs_db_subnet_group.name
//  NAME = "vs-mysql-prod"
//  MYSQL_SECURITY_GROUP = [
//    aws_security_group.vs_security_group_mysql_prod.id
//  ]
//}
