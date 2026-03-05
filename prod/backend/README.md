# prod/backend

Provisions EC2-based backend services for the prod environment. Reads VPC outputs from remote state (`prod/vpc`). Creates a security group, IAM role with SSM access, instance profile, and multiple EC2 instances (PostgreSQL, sub-API, Redis, Celery worker, Vault monitor).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_celery_ec2"></a> [celery\_ec2](#module\_celery\_ec2) | ../../_common/modules/ec2 | n/a |
| <a name="module_ec2_instance_profile"></a> [ec2\_instance\_profile](#module\_ec2\_instance\_profile) | ../../_common/modules/ec2_profile | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | ../../_common/modules/iam_role | n/a |
| <a name="module_postgres_ec2"></a> [postgres\_ec2](#module\_postgres\_ec2) | ../../_common/modules/ec2 | n/a |
| <a name="module_redis_ec2"></a> [redis\_ec2](#module\_redis\_ec2) | ../../_common/modules/ec2 | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ../../_common/modules/sg | n/a |
| <a name="module_sub_api_ec2"></a> [sub\_api\_ec2](#module\_sub\_api\_ec2) | ../../_common/modules/ec2 | n/a |
| <a name="module_vault_monitor_ec2"></a> [vault\_monitor\_ec2](#module\_vault\_monitor\_ec2) | ../../_common/modules/ec2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_vars"></a> [additional\_vars](#input\_additional\_vars) | Additional variables | `map(string)` | `{}` | no |
| <a name="input_ami_settings"></a> [ami\_settings](#input\_ami\_settings) | Settings for selecting the appropriate AMI | <pre>object({<br>    ami_type = string # Can be 'ubuntu' or 'custom'<br>    owners    = list(string) # Specify the owner (e.g., amazon, self)<br>    filters = optional(list(object({<br>      name   = string<br>      values = list(string)<br>    })), []) # Optional: Any additional or custom filters<br>    ami_arch       = optional(string)<br>    ami_os_version = optional(string)<br><br>  })</pre> | <pre>{<br>  "ami_arch": "x86_64",<br>  "ami_os_version": "22.04",<br>  "ami_type": "ubuntu",<br>  "filters": [],<br>  "owners": [<br>    "amazon"<br>  ]<br>}</pre> | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The assume role policy document | <pre>object({<br>    Version = string<br>    Statement = list(object({<br>      Effect = string<br>      Principal = object({<br>        Service = string<br>      })<br>      Action = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_create_celery_ec2"></a> [create\_celery\_ec2](#input\_create\_celery\_ec2) | Whether to create the celery\_ec2 module | `bool` | `true` | no |
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Whether to create and associate an Elastic IP with the instance | `bool` | `false` | no |
| <a name="input_create_postgres_ec2"></a> [create\_postgres\_ec2](#input\_create\_postgres\_ec2) | Whether to create the postgres\_ec2 module | `bool` | `true` | no |
| <a name="input_create_redis_ec2"></a> [create\_redis\_ec2](#input\_create\_redis\_ec2) | Whether to create the redis\_ec2 module | `bool` | `true` | no |
| <a name="input_create_sub_api_ec2"></a> [create\_sub\_api\_ec2](#input\_create\_sub\_api\_ec2) | Whether to create the sub\_api\_ec2 module | `bool` | `true` | no |
| <a name="input_custom_managed_policies"></a> [custom\_managed\_policies](#input\_custom\_managed\_policies) | Configure custom managed policies | <pre>object({<br>    use_custom_managed_policies = bool<br>    managed_policies            = list(string)<br>  })</pre> | <pre>{<br>  "managed_policies": [],<br>  "use_custom_managed_policies": false<br>}</pre> | no |
| <a name="input_data_volume"></a> [data\_volume](#input\_data\_volume) | Settings for the data volume | <pre>object({<br>    device_name = string<br>    volume_size = number<br>    volume_type = string<br>    iops        = number<br>    throughput  = number<br>    tags        = map(string)<br>  })</pre> | <pre>{<br>  "device_name": "/dev/sdb",<br>  "iops": 3000,<br>  "tags": {},<br>  "throughput": 125,<br>  "volume_size": 100,<br>  "volume_type": "gp2"<br>}</pre> | no |
| <a name="input_ec2_celery_settings"></a> [ec2\_celery\_settings](#input\_ec2\_celery\_settings) | Settings for EC2 instance | <pre>object({<br>    architecture      = string<br>    os_version        = string<br>    instance_type     = string<br>    key_name          = string<br>    instance_count    = number<br>    availability_zone = string<br>    subnet_id         = string<br>    security_groups   = list(string)<br>    ebs_settings = object({<br>      volume_size = number<br>      volume_type = string<br>      iops        = number<br>      throughput  = number<br>    })<br>    is_public_ip               = bool<br>    enable_detailed_monitoring = bool<br>    terminate_protection       = bool<br>    tags                       = map(string)<br>    user_data_file             = string<br>  })</pre> | n/a | yes |
| <a name="input_ec2_psql_settings"></a> [ec2\_psql\_settings](#input\_ec2\_psql\_settings) | Settings for EC2 instance | <pre>object({<br>    architecture      = string<br>    os_version        = string<br>    instance_type     = string<br>    key_name          = string<br>    instance_count    = number<br>    availability_zone = string<br>    subnet_id         = string<br>    security_groups   = list(string)<br>    ebs_settings = object({<br>      volume_size = number<br>      volume_type = string<br>      iops        = number<br>      throughput  = number<br>    })<br>    is_public_ip               = bool<br>    enable_detailed_monitoring = bool<br>    terminate_protection       = bool<br>    tags                       = map(string)<br>    user_data_file             = string<br>  })</pre> | <pre>{<br>  "architecture": "x86_64",<br>  "availability_zone": "",<br>  "ebs_settings": {<br>    "iops": 3000,<br>    "throughput": 125,<br>    "volume_size": 8,<br>    "volume_type": "gp3"<br>  },<br>  "enable_detailed_monitoring": false,<br>  "instance_count": 1,<br>  "instance_type": "t2.medium",<br>  "is_public_ip": true,<br>  "key_name": "my-key",<br>  "os_version": "22.04",<br>  "security_groups": [],<br>  "subnet_id": "",<br>  "tags": {<br>    "env": "dev",<br>    "project": "example"<br>  },<br>  "terminate_protection": false,<br>  "user_data_file": ""<br>}</pre> | no |
| <a name="input_ec2_redis_settings"></a> [ec2\_redis\_settings](#input\_ec2\_redis\_settings) | Settings for EC2 instance | <pre>object({<br>    architecture      = string<br>    os_version        = string<br>    instance_type     = string<br>    key_name          = string<br>    instance_count    = number<br>    availability_zone = string<br>    subnet_id         = string<br>    security_groups   = list(string)<br>    ebs_settings = object({<br>      volume_size = number<br>      volume_type = string<br>      iops        = number<br>      throughput  = number<br>    })<br>    is_public_ip               = bool<br>    enable_detailed_monitoring = bool<br>    terminate_protection       = bool<br>    tags                       = map(string)<br>    user_data_file             = string<br>  })</pre> | n/a | yes |
| <a name="input_ec2_settings"></a> [ec2\_settings](#input\_ec2\_settings) | Settings for ec2 instance | <pre>object({<br>      architecture        = string<br>      os_version          = string<br>      instance_type       = string<br>      volume_size         = string<br>      #  key_name = string<br>  })</pre> | n/a | yes |
| <a name="input_ec2_sub_api_settings"></a> [ec2\_sub\_api\_settings](#input\_ec2\_sub\_api\_settings) | Settings for EC2 instance | <pre>object({<br>    architecture      = string<br>    os_version        = string<br>    instance_type     = string<br>    key_name          = string<br>    instance_count    = number<br>    availability_zone = string<br>    subnet_id         = string<br>    security_groups   = list(string)<br>    ebs_settings = object({<br>      volume_size = number<br>      volume_type = string<br>      iops        = number<br>      throughput  = number<br>    })<br>    is_public_ip               = bool<br>    enable_detailed_monitoring = bool<br>    terminate_protection       = bool<br>    tags                       = map(string)<br>    user_data_file             = string<br>  })</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | `"development"` | no |
| <a name="input_existing_key_name"></a> [existing\_key\_name](#input\_existing\_key\_name) | Name of the existing key pair to use | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | EC2 profile | `string` | `""` | no |
| <a name="input_internalALB"></a> [internalALB](#input\_internalALB) | If false, then the Load Balancer will be external and available on the Internet. If true, it will only be available inside the VPC. | `bool` | `false` | no |
| <a name="input_is_data_volume_enabled"></a> [is\_data\_volume\_enabled](#input\_is\_data\_volume\_enabled) | Flag to enable/disable the data volume | `bool` | `false` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the EC2 key pair | `string` | n/a | yes |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | Path to store keys | `string` | `"keys"` | no |
| <a name="input_owner_id"></a> [owner\_id](#input\_owner\_id) | AWS owner ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | `"myproject"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_selected_policies"></a> [selected\_policies](#input\_selected\_policies) | List of selected policy file names | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | `"backend-service"` | no |
| <a name="input_sg_rules"></a> [sg\_rules](#input\_sg\_rules) | List of security group rules | <pre>list(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = optional(list(string))<br>    security_groups = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_sg_settings"></a> [sg\_settings](#input\_sg\_settings) | Security group settings | <pre>object({<br>    name        = string<br>    description = string<br>    #vpc_id      = string<br>    tags = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | n/a | yes |
| <a name="input_use_existing_key"></a> [use\_existing\_key](#input\_use\_existing\_key) | Flag to determine whether to use an existing key pair | `bool` | `false` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_infrastructure_details"></a> [infrastructure\_details](#output\_infrastructure\_details) | n/a |
