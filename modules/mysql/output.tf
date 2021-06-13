output "mysql_public_ip" {
  value = aws_db_instance.vs_mysql.endpoint
}