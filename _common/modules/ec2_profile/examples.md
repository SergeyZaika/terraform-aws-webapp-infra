## Examples

### Example: EC2 Profile + IAM role

[see IAM role example usage for more details](../iam_role/examples.md#L5)
```hcl
module "iam_role" {
  source = "../modules/iam_role"

  project_name       = "example_name"
  service_name       = "example_name"
  env                = "example_name"
  owner_id           = "example_name"
  assume_role_policy = (
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
  )
  selected_policies  = ["policy1.json"]
  custom_managed_policies = {
    use_custom_managed_policies = true
    managed_policies            = []
  }
}

module "ec2_instance_profile" {
  source = "../modules/ec2_profile"

  project_name = "example_name"
  env          = "example_name"
  role_name    = module.iam_role.role_name
  service_name = "example_name"
  depends_on   = [module.iam_role]
}
```