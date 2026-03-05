variable "env" {
  description = "Environment tag for the security group"
  type        = string
}

variable "project_name" {
  description = "Project name tag for the security group"
  type        = string
}

variable "sg_rules" {
  description = "List of security group rules"
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
}

variable "sg_settings" {
  description = "Security group settings"
  type        = object({
    name        = string
    description = string
    vpc_id      = string
    tags        = map(string)
  })
}
