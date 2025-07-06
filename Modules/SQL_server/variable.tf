variable "sql_name"{} 
variable "rg_name"{}
variable "rg_location"{}
variable "sql_version"{}
variable "admin_login"{}
variable "admin_login_password"{
  description = "SQL admin password"
  type        = string
  sensitive   = true
}
variable "sqlserver_id" {
  description = "ID of the SQL server"
  type        = string
  default     = null
}