variable "name" {
  description = "The alias for the AWS account"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*$", var.name))
    error_message = "The account alias must start with an alphanumeric character and only contain lowercase alphanumeric characters and hyphens"
  }
}

variable "sub_accounts" {
  description = "A list of sub-accounts to create (name, email)"
  type        = map(string)

  default = {}
}



variable "advanced_common_roles" {
  description = "List of roles that should be present in all accounts"
  type        = list(string)
  default     = ["admin", "developer", "read-only"]
}



variable "dangerous_close_on_deletion" {
  description = "Close sub-acounts on deletion"
  type        = bool
  default     = false
}

variable "service_access_principals_enabled" {
  description = "Enable service access principals for the organization. additional_service_principals can be used to add more service principals."
  type = object({
    account = optional(bool, true)
    sso     = optional(bool, true)

    additional_service_principals = optional(list(string), [])
  })
  default = {}
}
