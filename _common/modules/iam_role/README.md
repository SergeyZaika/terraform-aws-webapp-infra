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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_vars"></a> [additional\_vars](#input\_additional\_vars) | Additional variables | `map(string)` | `{}` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | Assume role policy | `any` | `null` | no |
| <a name="input_custom_managed_policies"></a> [custom\_managed\_policies](#input\_custom\_managed\_policies) | Configure custom managed policies | <pre>object({<br>    use_custom_managed_policies = bool<br>    managed_policies            = list(string)<br>  })</pre> | <pre>{<br>  "managed_policies": [],<br>  "use_custom_managed_policies": false<br>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_owner_id"></a> [owner\_id](#input\_owner\_id) | AWS owner ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_selected_policies"></a> [selected\_policies](#input\_selected\_policies) | List of specific policy files to include (optional) | `list(string)` | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Project name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
<!-- END_TF_DOCS -->