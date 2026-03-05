variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myproject"
}

variable "service_name" {
  description = "Service name"
  type        = string
  default     = "backend-service"
}
variable "owner_id" {
  description = "AWS owner ID"
  type        = string
}

variable "sg_settings" {
  description = "Security group settings"
  type = object({
    name        = string
    description = string
    #vpc_id      = string
    tags = map(string)
  })
}

variable "sg_rules" {
  description = "List of security group rules"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
}
variable "ec2_psql_settings" {
  description = "Settings for EC2 instance"
  type = object({
    architecture      = string
    os_version        = string
    instance_type     = string
    key_name          = string
    instance_count    = number
    availability_zone = string
    subnet_id         = string
    security_groups   = list(string)
    ebs_settings = object({
      volume_size = number
      volume_type = string
      iops        = number
      throughput  = number
    })
    is_public_ip               = bool
    enable_detailed_monitoring = bool
    terminate_protection       = bool
    tags                       = map(string)
    user_data_file             = string
  })
  default = {
    architecture      = "x86_64"
    os_version        = "22.04"
    instance_type     = "t2.medium"
    key_name          = "my-key"
    instance_count    = 1
    availability_zone = ""
    subnet_id         = ""
    security_groups   = []
    ebs_settings = {
      volume_size = 8
      volume_type = "gp3"
      iops        = 3000
      throughput  = 125
    }
    is_public_ip               = true
    enable_detailed_monitoring = false
    terminate_protection       = false
    tags = {
      "env"     = "dev"
      "project" = "test"
    }
    user_data_file = ""
  }
}
variable "ec2_sub_api_settings" {
  description = "Settings for EC2 instance"
  type = object({
    architecture      = string
    os_version        = string
    instance_type     = string
    key_name          = string
    instance_count    = number
    availability_zone = string
    subnet_id         = string
    security_groups   = list(string)
    ebs_settings = object({
      volume_size = number
      volume_type = string
      iops        = number
      throughput  = number
    })
    is_public_ip               = bool
    enable_detailed_monitoring = bool
    terminate_protection       = bool
    tags                       = map(string)
    user_data_file             = string
  })
}
variable "ec2_redis_settings" {
  description = "Settings for EC2 instance"
  type = object({
    architecture      = string
    os_version        = string
    instance_type     = string
    key_name          = string
    instance_count    = number
    availability_zone = string
    subnet_id         = string
    security_groups   = list(string)
    ebs_settings = object({
      volume_size = number
      volume_type = string
      iops        = number
      throughput  = number
    })
    is_public_ip               = bool
    enable_detailed_monitoring = bool
    terminate_protection       = bool
    tags                       = map(string)
    user_data_file             = string
  })
}
variable "ec2_celery_settings" {
  description = "Settings for EC2 instance"
  type = object({
    architecture      = string
    os_version        = string
    instance_type     = string
    key_name          = string
    instance_count    = number
    availability_zone = string
    subnet_id         = string
    security_groups   = list(string)
    ebs_settings = object({
      volume_size = number
      volume_type = string
      iops        = number
      throughput  = number
    })
    is_public_ip               = bool
    enable_detailed_monitoring = bool
    terminate_protection       = bool
    tags                       = map(string)
    user_data_file             = string
  })
}
variable "is_data_volume_enabled" {
  description = "Flag to enable/disable the data volume"
  type        = bool
  default     = false
}

variable "create_vault_monitor" {
  type        = bool
  default     = true
  description = "Whether to create the vault_monitor EC2 instance"
}

variable "ec2_vault_monitor_settings" {
  description = "Settings for EC2 instance for Vault + Monitoring"
  type = object({
    architecture            = string
    os_version              = string
    instance_type           = string
    key_name                = string
    instance_count          = number
    availability_zone       = string
    subnet_id               = string
    security_groups         = list(string)
    ebs_settings = object({
      volume_size = number
      volume_type = string
      iops        = number
      throughput  = number
    })
    is_public_ip               = bool
    enable_detailed_monitoring = bool
    terminate_protection       = bool
    tags                       = map(string)
    user_data_file             = string
  })
}

variable "data_volume" {
  description = "Settings for the data volume"
  type = object({
    device_name = string
    volume_size = number
    volume_type = string
    iops        = number
    throughput  = number
    tags        = map(string)
  })
  default = {
    device_name = "/dev/sdb"
    volume_size = 100
    volume_type = "gp2"
    iops        = 3000
    throughput  = 125
    tags        = {}
  }
}

variable "key_path" {
  description = "Path to store keys"
  type        = string
  default     = "keys"
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "EC2 profile"
  type        = string
  default     = ""
}

variable "create_eip" {
  description = "Whether to create and associate an Elastic IP with the instance"
  type        = bool
  default     = false
}

variable "use_existing_key" {
  description = "Flag to determine whether to use an existing key pair"
  type        = bool
  default     = false
}

variable "existing_key_name" {
  description = "Name of the existing key pair to use"
  type        = string
  default     = ""
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

variable "assume_role_policy" {
  description = "The assume role policy document"
  type = object({
    Version = string
    Statement = list(object({
      Effect = string
      Principal = object({
        Service = string
      })
      Action = string
    }))
  })
}

variable "selected_policies" {
  description = "List of selected policy file names"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "internalALB" {
  description = "If false, then the Load Balancer will be external and available on the Internet. If true, it will only be available inside the VPC."
  type = bool
  default = false
}

variable "ami_settings" {
  description = "Settings for selecting the appropriate AMI"
  type = object({
    ami_type = string # Can be 'ubuntu' or 'custom'
    owners    = list(string) # Specify the owner (e.g., amazon, self)
    filters = optional(list(object({
      name   = string
      values = list(string)
    })), []) # Optional: Any additional or custom filters
    ami_arch       = optional(string)
    ami_os_version = optional(string)

  })
  default = {
    ami_type       = "ubuntu"
    owners          = ["amazon"]
    filters        = []
    ami_arch       = "x86_64"
    ami_os_version = "22.04"
  }
}

variable "create_postgres_ec2" {
  type        = bool
  default     = true
  description = "Whether to create the postgres_ec2 module"
}

variable "create_sub_api_ec2" {
  type        = bool
  default     = true
  description = "Whether to create the sub_api_ec2 module"
}

variable "create_redis_ec2" {
  type        = bool
  default     = true
  description = "Whether to create the redis_ec2 module"
}

variable "create_celery_ec2" {
  type        = bool
  default     = true
  description = "Whether to create the celery_ec2 module"
}

variable "ec2_key_name" {
  description = "The name of the SSH key to use for EC2"
  type        = string
}
