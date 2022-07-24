variable "mysql_username" {
  description = "Username for database"
  type        = string
  sensitive   = true
}

variable "mysql_password" {
  description = "Password for database"
  type        = string
  sensitive   = true
}
