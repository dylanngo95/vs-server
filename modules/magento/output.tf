output "bastion_public_ip" {
  value = aws_instance.vs_instance_magento.public_ip
}

output "bastion_group_id" {
  value = aws_instance.vs_instance_magento.id
}
