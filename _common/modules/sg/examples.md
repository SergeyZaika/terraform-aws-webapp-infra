## Examples

```hcl
module "security_group" {
  source = "../modules/sg"

  env          = example_env
  project_name = example_project_name
  sg_settings = {
    name        = "example_sg"
    description = "SG for example sg"
    vpc_id      = "example-vpc-id"
    tags = {
      Name = "example_sg"
    }
  }
  sg_rules = [
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = null
      cidr_blocks     = ["1.1.1.1/32"]
    },
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = null
      cidr_blocks     = ["2.2.2.2/32"]
    }
  ]
}
```