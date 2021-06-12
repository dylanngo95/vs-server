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
  NAME = "bastion"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_bastion_prod.id
}

module "vs_instance_magento_prod" {
  source = "../modules/magento"
  NAME = "magento_prod"
  AMI = "ami-0d058fe428540cd89"
  INSTANCE_TYPE = var.INSTANCE_TYPE
  PUBLIC_KEY = aws_key_pair.credentials.key_name
  PUBLIC_SUBNET_ID = aws_subnet.vs_subnet_public.id
  SECURITY_GROUP_ID = aws_security_group.vs_security_group_magento_prod.id
}
