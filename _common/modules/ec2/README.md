<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.ec2_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [local_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.public_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Whether to create and associate an Elastic IP with the instance | `bool` | `false` | no |
| <a name="input_data_volume"></a> [data\_volume](#input\_data\_volume) | Settings for the data volume | <pre>object({<br>    device_name = string<br>    volume_size = number<br>    volume_type = string<br>    iops        = number<br>    throughput  = number<br>    tags        = map(string)<br>  })</pre> | <pre>{<br>  "device_name": "/dev/sdb",<br>  "iops": 3000,<br>  "tags": {},<br>  "throughput": 125,<br>  "volume_size": 100,<br>  "volume_type": "gp2"<br>}</pre> | no |
| <a name="input_ec2_settings"></a> [ec2\_settings](#input\_ec2\_settings) | Settings for EC2 instance | <pre>object({<br>    architecture               = string<br>    os_version                 = string<br>    instance_type              = string<br>    key_name                   = string<br>    instance_count             = number<br>    availability_zone          = string<br>    subnet_id                  = string<br>    security_groups            = list(string)<br>    ebs_settings = object({<br>      volume_size = number<br>      volume_type = string<br>      iops        = number<br>      throughput  = number<br>    })<br>    is_public_ip               = bool<br>    enable_detailed_monitoring = bool<br>    terminate_protection       = bool<br>    tags                       = map(string)<br>    user_data_file             = string<br>  })</pre> | <pre>{<br>  "architecture": "x86_64",<br>  "availability_zone": "",<br>  "ebs_settings": {<br>    "iops": 3000,<br>    "throughput": 125,<br>    "volume_size": 8,<br>    "volume_type": "gp3"<br>  },<br>  "enable_detailed_monitoring": false,<br>  "instance_count": 1,<br>  "instance_type": "t2.medium",<br>  "is_public_ip": true,<br>  "key_name": "my-key",<br>  "os_version": "22.04",<br>  "security_groups": [],<br>  "subnet_id": "",<br>  "tags": {<br>    "env": "dev",<br>    "project": "test"<br>  },<br>  "terminate_protection": false,<br>  "user_data_file": ""<br>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_existing_key_name"></a> [existing\_key\_name](#input\_existing\_key\_name) | Name of the existing key pair to use | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | EC2 profile | `string` | `""` | no |
| <a name="input_is_data_volume_enabled"></a> [is\_data\_volume\_enabled](#input\_is\_data\_volume\_enabled) | Flag to enable/disable the data volume | `bool` | `false` | no |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | Path to store keys | `string` | `"keys"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name | `string` | n/a | yes |
| <a name="input_use_existing_key"></a> [use\_existing\_key](#input\_use\_existing\_key) | Flag to determine whether to use an existing key pair | `bool` | `false` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | AMI ID |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | List of EC2 instance IDs |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | List of private IPs |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of public IPs |
<!-- END_TF_DOCS -->