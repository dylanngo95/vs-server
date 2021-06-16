resource "aws_instance" "vs_instance_magento" {
  ami = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name = var.PUBLIC_KEY
  subnet_id = var.PUBLIC_SUBNET_ID
  vpc_security_group_ids = [
    var.SECURITY_GROUP_ID
  ]

  provisioner "local-exec" {
    command = "echo ${aws_instance.vs_instance_magento.private_ip} >> vs_instance_magento_private_ips.txt"
  }

  tags = {
    Name = var.NAME
  }
}
