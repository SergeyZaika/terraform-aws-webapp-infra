output "infrastructure_details" {
  value = {
    ami_id            = data.aws_ami.this.id
    security_group_id = module.security_group.security_group_id

    instance_ids = {
      postgres       = var.create_postgres_ec2 ? module.postgres_ec2[0].instance_ids[0] : ""
      sub_api        = var.create_sub_api_ec2 ? module.sub_api_ec2[0].instance_ids[0] : ""
      redis          = var.create_redis_ec2 ? module.redis_ec2[0].instance_ids[0] : ""
      celery         = var.create_celery_ec2 ? module.celery_ec2[0].instance_ids[0] : ""
      vault_monitor  = var.create_vault_monitor ? module.vault_monitor_ec2[0].instance_ids[0] : ""
    }

    network_details = {
      private_ips = {
        postgres      = var.create_postgres_ec2 ? module.postgres_ec2[0].private_ips[0] : ""
        sub_api       = var.create_sub_api_ec2 ? module.sub_api_ec2[0].private_ips[0] : ""
        redis         = var.create_redis_ec2 ? module.redis_ec2[0].private_ips[0] : ""
        celery        = var.create_celery_ec2 ? module.celery_ec2[0].private_ips[0] : ""
        vault_monitor = var.create_vault_monitor ? module.vault_monitor_ec2[0].private_ips[0] : ""
      }
      public_ips = {
        postgres      = var.create_postgres_ec2 ? module.postgres_ec2[0].public_ips : []
        sub_api       = var.create_sub_api_ec2 ? module.sub_api_ec2[0].public_ips : []
        redis         = var.create_redis_ec2 ? module.redis_ec2[0].public_ips : []
        celery        = var.create_celery_ec2 ? module.celery_ec2[0].public_ips : []
        vault_monitor = var.create_vault_monitor ? module.vault_monitor_ec2[0].public_ips : []
      }
    }
  }
}

