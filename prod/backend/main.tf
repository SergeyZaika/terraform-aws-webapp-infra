resource "tls_private_key" "main_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main_key" {
  key_name   = var.ec2_key_name
  public_key = tls_private_key.main_key.public_key_openssh

  lifecycle {
    prevent_destroy = false
  }
}

resource "local_file" "private_key" {
  filename = "${var.key_path}/${var.ec2_key_name}.pem"
  content  = tls_private_key.main_key.private_key_pem
}

resource "local_file" "public_key" {
  filename = "${var.key_path}/${var.ec2_key_name}.pub"
  content  = tls_private_key.main_key.public_key_openssh
}

module "security_group" {
  source = "../../_common/modules/sg"

  env          = var.env
  project_name = var.project_name

  sg_settings = {
    name        = var.sg_settings.name
    description = var.sg_settings.description
    vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
    tags = {
      Name = var.sg_settings.tags["Name"]
    }
  }
  sg_rules = var.sg_rules
}

module "iam_role" {
  source = "../../_common/modules/iam_role"

  project_name       = var.project_name
  service_name       = var.service_name
  env                = var.env
  owner_id           = var.owner_id
  assume_role_policy = var.assume_role_policy
  selected_policies  = []

  custom_managed_policies = {
    use_custom_managed_policies = true
    managed_policies = [
      "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  }
}

module "ec2_instance_profile" {
  source = "../../_common/modules/ec2_profile"

  project_name = var.project_name
  env          = var.env
  role_name    = module.iam_role.role_name
  service_name = var.service_name
  depends_on   = [module.iam_role]
}

module "postgres_ec2" {
  source = "../../_common/modules/ec2"
  count  = var.create_postgres_ec2 ? 1 : 0
  depends_on = [aws_key_pair.main_key]

  project_name         = var.project_name
  service_name         = "postgres"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile.instance_profile_name : ""
  env                  = var.env

  ec2_settings = merge(
    var.ec2_psql_settings,
    {
      security_groups = [module.security_group.security_group_id]
      subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    }
  )

  use_existing_key     = true
  existing_key_name    = var.ec2_key_name
  key_path             = var.key_path
  create_eip           = var.create_eip
  ami_settings         = var.ami_settings
}

module "sub_api_ec2" {
  source = "../../_common/modules/ec2"
  count  = var.create_sub_api_ec2 ? 1 : 0
  depends_on = [aws_key_pair.main_key]

  project_name         = var.project_name
  service_name         = "sub_api"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile.instance_profile_name : ""
  env                  = var.env

  ec2_settings = merge(
    var.ec2_sub_api_settings,
    {
      security_groups = [module.security_group.security_group_id]
      subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    }
  )

  use_existing_key     = true
  existing_key_name    = var.ec2_key_name
  key_path             = var.key_path
  create_eip           = var.create_eip
  ami_settings         = var.ami_settings
}

module "redis_ec2" {
  source = "../../_common/modules/ec2"
  count  = var.create_redis_ec2 ? 1 : 0
  depends_on = [aws_key_pair.main_key]

  project_name         = var.project_name
  service_name         = "redis"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile.instance_profile_name : ""
  env                  = var.env

  ec2_settings = merge(
    var.ec2_redis_settings,
    {
      security_groups = [module.security_group.security_group_id]
      subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    }
  )

  use_existing_key     = true
  existing_key_name    = var.ec2_key_name
  key_path             = var.key_path
  create_eip           = var.create_eip
  ami_settings         = var.ami_settings
}

module "celery_ec2" {
  source = "../../_common/modules/ec2"
  count  = var.create_celery_ec2 ? 1 : 0
  depends_on = [aws_key_pair.main_key]

  project_name         = var.project_name
  service_name         = "celery"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile.instance_profile_name : ""
  env                  = var.env

  ec2_settings = merge(
    var.ec2_celery_settings,
    {
      security_groups = [module.security_group.security_group_id]
      subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    }
  )

  use_existing_key     = true
  existing_key_name    = var.ec2_key_name
  key_path             = var.key_path
  create_eip           = var.create_eip
  ami_settings         = var.ami_settings
}

module "vault_monitor_ec2" {
  source = "../../_common/modules/ec2"
  count  = var.create_vault_monitor ? 1 : 0
  depends_on = [aws_key_pair.main_key]

  project_name         = var.project_name
  service_name         = "vault-monitor"
  iam_instance_profile = length(module.ec2_instance_profile) > 0 ? module.ec2_instance_profile.instance_profile_name : ""
  env                  = var.env

  ec2_settings = merge(
    var.ec2_vault_monitor_settings,
    {
      security_groups = [module.security_group.security_group_id]
      subnet_id       = data.terraform_remote_state.vpc.outputs.public_subnets[0]
    }
  )

  use_existing_key     = true
  existing_key_name    = var.ec2_key_name
  key_path             = var.key_path
  create_eip           = var.create_eip
  ami_settings         = var.ami_settings
}
