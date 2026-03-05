# dev/vpc

Provisions the VPC for the dev environment using the community `terraform-aws-modules/vpc/aws` module. Outputs `vpc_id`, `public_subnets`, and `private_subnets` to S3 remote state for consumption by `dev/backend`.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.33.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.9.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `"myproject"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_vpc_settings"></a> [vpc\_settings](#input\_vpc\_settings) | Settings for ec2 instance | <pre>object({<br>    prefix      = string<br>    cidr            = string<br>    azs             = list(string)<br>    private_subnets = list(string)<br>    public_subnets  = list(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnet IDs |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnet IDs |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |
