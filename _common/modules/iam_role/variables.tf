variable "project_name" {
  description = "Project name"
  type        = string
}

variable "service_name" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "owner_id" {
  description = "AWS owner ID"
  type        = string
}

variable "assume_role_policy" {
  description = "Assume role policy"
  type        = any
  default     = null
}

variable "custom_managed_policies" {
  description = "Configure custom managed policies"
  type = object({
    use_custom_managed_policies = bool
    managed_policies            = list(string)
  })
  default = {
    use_custom_managed_policies = false
    managed_policies            = []
  }
}

variable "additional_vars" {
  description = "Additional variables"
  type        = map(string)
  default     = {}
}

variable "selected_policies" {
  description = "List of specific policy files to include (optional)"
  type        = list(string)
  default     = []
}
