region       = "ca-central-1"
env          = "dev"
project_name = "webapp"
service_name = "backend-service"
owner_id     = "123456789012"
#internalALB  = false
ec2_key_name = "webapp-key"
use_existing_key = true
tags = {
  project = "webapp-project"
  env     = "dev"
}

sg_settings = {
  name        = "webapp-sg"
  description = "Security group for webapp project"
  tags = {
    Name = "webapp-sg"
  }
}
sg_rules = [
  {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = null
    cidr_blocks     = ["0.0.0.0/0"]
  },
  {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = null
    cidr_blocks     = ["0.0.0.0/0"]
  },
]

### created ec2
create_postgres_ec2    = true
create_sub_api_ec2     = true
create_redis_ec2       = false
create_celery_ec2      = false
create_vault_monitor   = true

ec2_psql_settings = {
  architecture      = "x86_64"
  os_version        = "22.04"
  instance_type     = "t3.medium"
  key_name          = "webapp-key"
  instance_count    = 1
  availability_zone = "ca-central-1a"
  subnet_id         = ""
  security_groups   = []
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
    "env"     = "dev"
    "project" = "webapp-project"
  }
  user_data_file = ""
}

ec2_sub_api_settings = {
  architecture      = "x86_64"
  os_version        = "22.04"
  instance_type     = "t2.medium"
  key_name          = "webapp-key"
  instance_count    = 1
  availability_zone = "ca-central-1a"
  subnet_id         = ""
  security_groups   = []
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
    "env"     = "dev"
    "project" = "webapp-project"
  }
  user_data_file = ""
}
ec2_redis_settings = {
  architecture      = "x86_64"
  os_version        = "22.04"
  instance_type     = "t2.medium"
  key_name          = "webapp-key"
  instance_count    = 1
  availability_zone = "ca-central-1a"
  subnet_id         = ""
  security_groups   = []
  ebs_settings = {
    volume_size = 20
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  is_public_ip               = false
  enable_detailed_monitoring = false
  terminate_protection       = true
  tags = {
    "env"     = "dev"
    "project" = "webapp-project"
  }
  user_data_file = ""
}
ec2_celery_settings = {
  architecture      = "x86_64"
  os_version        = "22.04"
  instance_type     = "t2.medium"
  key_name          = "webapp-key"
  instance_count    = 1
  availability_zone = "ca-central-1a"
  subnet_id         = ""
  security_groups   = []
  ebs_settings = {
    volume_size = 20
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
  }

  is_public_ip               = false
  enable_detailed_monitoring = false
  terminate_protection       = true
  tags = {
    "env"     = "dev"
    "project" = "webapp-project"
  }
  user_data_file = ""
}

ec2_vault_monitor_settings = {
  architecture      = "x86_64"
  os_version        = "22.04"
  instance_type     = "t3.medium"
  key_name          = "webapp-key"
  instance_count    = 1
  availability_zone = "ca-central-1a"
  subnet_id         = ""
  security_groups   = []
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
    "env"     = "dev"
    "project" = "webapp-project"
  }
  user_data_file = ""
}

assume_role_policy = {
  Version = "2012-10-17"
  Statement = [
    {
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }
  ]
}

