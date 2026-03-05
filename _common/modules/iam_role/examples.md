## Examples

### Example: Creation of specific IAM role

This example demonstrates the creation of a IAM role named "test_role" that:

- Uses custom policies from `policies/` to select specific inline policies to apply to the user group.
- Uses AWS managed policies to apply to the user group.

To use custom inline policies, you should create a directory policies in the root Terraform directory  where you will store the inline JSON policies.

Example tree structure
```txt
.
├── main.tf
├── outputs.tf
├── policies
│   ├── policy1.json
│   ├── policy2.json
│   └── policy3.json
├── providers.tf
└── variables.tf
```


```hcl
module "example_role_name" {
  source = "../modules/iam_role"

  project_name = "example_project_name"
  service_name = "example_policy_name"
  env          = "example-env"
  owner_id     = "owner-id"
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
  selected_policies = [
    "policy2.json",
    "policy1.json"
    ]
  custom_managed_policies = {
    use_custom_managed_policies = true
    managed_policies = [
      "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  }
}
```

### Example: using only custom inline policies
```hcl
  ...
  selected_policies = [
    "policy2.json",
    "policy1.json"
    ]
  ...
  custom_managed_policies = {
    use_custom_managed_policies = false
    managed_policies = []
  }
```