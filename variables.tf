variable "organization_name" {
  description = "The name of the Terraform Cloud organization."
  type        = string
}

variable "oauth_client_name" {
  description = "The name of the OAuth client."
  type        = string
}

variable "modules_name" {
  description = "A list of modules name to published."
  type        = list(string)
  validation {
    condition     = alltrue([for module_name in var.modules_name : !can(regex("^terraform-[a-zA-Z--]+-[a-zA-Z--]+$", module_name))]) ? true : false
    error_message = "Module name must use a three-part name format like  `terraform-<PROVIDER>-<NAME>` and contain only letters and hypens."
  }
}