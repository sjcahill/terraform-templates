output "address" {
  value       = aws_db_instance.mysql-db.address
  description = "Connect to mysql database at this endpoint."
}

output "port" {
  value       = aws_db_instance.mysql-db.port
  description = "Port the database is listening on."
}
