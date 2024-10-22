variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "username" {
  description = "The username for the IAM user (will be auto generated from name)"
  type        = string
  default     = null
}

variable "advanced_ssh_key_encoding" {
  description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM"
  type        = string
  default     = "SSH"
}

variable "ssh_public_key" {
  description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format"
  type        = string
  default     = null
}

variable "admin" {
  description = "Grant AdministratorAccess to the account"
  default     = false
}

variable "roles" {
  description = "List of roles that the user will be granted AssumeRole permissions"
  default     = []
}

variable "groups" {
  description = "List of groups whuch will be attached to the user"
  default     = []
}
