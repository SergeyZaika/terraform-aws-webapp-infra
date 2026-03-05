<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment tag for the security group | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name tag for the security group | `string` | n/a | yes |
| <a name="input_sg_rules"></a> [sg\_rules](#input\_sg\_rules) | List of security group rules | <pre>list(object({<br>    from_port       = number<br>    to_port         = number<br>    protocol        = string<br>    cidr_blocks     = optional(list(string))<br>    security_groups = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_sg_settings"></a> [sg\_settings](#input\_sg\_settings) | Security group settings | <pre>object({<br>    name        = string<br>    description = string<br>    vpc_id      = string<br>    tags        = map(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the created security group |
<!-- END_TF_DOCS -->