variable "tf-db-name" {
  description = "The name of the mysql-db"
  type        = string
  default     = "easynotes-dev-mysql-tsa"
}

variable "tf-db-admin-user" {
  description = "The name of Admin User of MySQL (root and admin are not allowed)"
  type        = string
  default     = "mysqladminuser"
}

variable "tf-db-admin-password" {
  description = "The Password of Admin User of MySQL"
  type        = string
  default     = "Password01."
}
