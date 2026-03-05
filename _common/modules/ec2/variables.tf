variable "ec2_settings" {
  description = "Settings for EC2 instance"
  type = object({
    architecture               = string
    os_version                 = string
    instance_type              = string
    key_name                   = string
    instance_count             = number
    availability_zone          = string
    subnet_id                  = string
    security_groups            = list(string)
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
    architecture               = "x86_64"
    os_version                 = "22.04"
    instance_type              = "t2.medium"
    key_name                   = "my-key"
    instance_count             = 1
    availability_zone          = ""
    subnet_id                  = ""
    security_groups            = []
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

variable "env" {
  description = "Environment"
  type        = string
}

variable "service_name" {
  description = "Service name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "is_data_volume_enabled" {
  description = "Flag to enable/disable the data volume"
  type        = bool
  default     = false
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