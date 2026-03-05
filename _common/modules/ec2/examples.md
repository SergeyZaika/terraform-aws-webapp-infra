## Examples

### Example: x1 EC2 + EIP + IAM Role + EC2 Profile + Security Group

For variables information, see details [here](./variables.tf).

Keep in mind:
- If you set `is_public_ip` to `true` and select a private subnet, it will still run on a public subnet. To completely run the instance in a private subnet, ensure that `is_public_ip` is set to `false` and the used `subnet-id` is private.
- If `use_existing_key` is set to `true`, the module will use an existing key name in AWS that matches `existing_key_name`. Otherwise, the EC2 module will create custom keys and save them to the `.keys` directory locally.

```hcl
module "ec2" {
  source = "../modules/ec2"

  project_name         = "example_name"
  service_name         = "example_name"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile[0].instance_profile_name : ""
  env                  = "example_name"
  ec2_settings = {
    architecture      = "x86_64"
    os_version        = "22.04"
    instance_type     = "t2.medium"
    key_name          = "example_key"
    instance_count    = 1
    availability_zone = "az"
    subnet_id         = "subnet-id"
    security_groups   = [module.security_group.security_group_id]
    ebs_settings = {
      volume_size = 20
      volume_type = "gp3"
      iops        = 3000
      throughput  = 125
    }
    is_public_ip               = true
    enable_detailed_monitoring = false
    terminate_protection       = true
    tags = {
      "monitoring"   = "yes"
      "env"          = var.env
    }
    user_data_file = ""
  }
  is_data_volume_enabled = false
  data_volume = {
    device_name = ""
    volume_size = 0
    volume_type = ""
    iops        = 0
    throughput  = 0
    tags        = {}
  }
  key_path          = ".keys"
  user_data         = ""
  create_eip        = true
  use_existing_key  = true
  existing_key_name = "example_key"
}

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