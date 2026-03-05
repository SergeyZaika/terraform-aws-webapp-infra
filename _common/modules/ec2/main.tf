locals {
  ami_filters_map = {
    ubuntu = [
      {
        name   = "architecture"
        values = [var.ami_settings.ami_arch]
      },
      {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu*${var.ami_settings.ami_os_version}*"]
      },
      {
        name   = "root-device-type"
        values = ["ebs"]
      },
      {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    ]
    custom = var.ami_settings.filters
  }

  ami_filters = local.ami_filters_map[var.ami_settings.ami_type]

}

data "aws_ami" "this" {
  most_recent = true

  owners = var.ami_settings.owners

  dynamic "filter" {
    for_each = local.ami_filters

    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

# data "aws_ami" "this" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "architecture"
#     values = [var.ec2_settings.architecture]
#   }
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu*${var.ec2_settings.os_version}*"]
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

resource "tls_private_key" "this" {
  count     = var.use_existing_key ? 0 : 1
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  count      = var.use_existing_key ? 0 : 1
  key_name   = var.ec2_settings.key_name
  public_key = tls_private_key.this[0].public_key_openssh
}

resource "local_file" "private_key" {
  count    = var.use_existing_key ? 0 : 1
  filename = "${var.key_path}/${var.ec2_settings.key_name}.pem"
  content  = tls_private_key.this[0].private_key_pem
}

resource "local_file" "public_key" {
  count    = var.use_existing_key ? 0 : 1
  filename = "${var.key_path}/${var.ec2_settings.key_name}.pub"
  content  = tls_private_key.this[0].public_key_openssh
}

locals {
  tags = merge({
    Name = "[${var.env}] ${var.service_name} / ${var.project_name}"
  }, var.ec2_settings.tags)
}

resource "aws_instance" "this" {
  count                   = var.ec2_settings.instance_count
  ami                     = data.aws_ami.this.id
  availability_zone       = var.ec2_settings.availability_zone != "" ? var.ec2_settings.availability_zone : null
  subnet_id               = var.ec2_settings.subnet_id != "" ? var.ec2_settings.subnet_id : null
  vpc_security_group_ids  = var.ec2_settings.security_groups
  instance_type           = var.ec2_settings.instance_type
  key_name                = var.use_existing_key ? var.existing_key_name : (var.ec2_settings.key_name != "" ? aws_key_pair.this[0].key_name : null)
  disable_api_termination = var.ec2_settings.terminate_protection

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.ec2_settings.ebs_settings.volume_size
    volume_type = var.ec2_settings.ebs_settings.volume_type
    iops        = var.ec2_settings.ebs_settings.iops
    throughput  = var.ec2_settings.ebs_settings.throughput
    tags = merge({
      Name = "[${var.env}] ${var.project_name} / root volume"
    }, var.ec2_settings.tags)
  }

  dynamic "ebs_block_device" {
    for_each = var.is_data_volume_enabled ? [1] : []
    content {
      device_name = var.data_volume.device_name
      volume_size = var.data_volume.volume_size
      volume_type = var.data_volume.volume_type
      iops        = var.data_volume.iops
      throughput  = var.data_volume.throughput
      tags        = var.data_volume.tags
    }
  }

  associate_public_ip_address = var.ec2_settings.is_public_ip
  monitoring                  = var.ec2_settings.enable_detailed_monitoring

  iam_instance_profile = var.iam_instance_profile != "" ? var.iam_instance_profile : null

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tags      = local.tags
  user_data = var.user_data != "" ? var.user_data : (var.ec2_settings.user_data_file != "" ? file(var.ec2_settings.user_data_file) : null)

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

resource "aws_eip" "this" {
  count    = var.create_eip ? var.ec2_settings.instance_count : 0
  instance = aws_instance.this[count.index].id
  domain   = "vpc"
  tags     = local.tags
}

locals {
  instance_tags = flatten([
    for idx, inst in aws_instance.this : [
      for key, value in local.tags : {
        instance_idx = idx
        interface_id = inst.primary_network_interface_id
        tag_key      = key
        tag_value    = value
      }
    ]
  ])
}

resource "aws_ec2_tag" "ec2_eni" {
  for_each = tomap({
    for it in local.instance_tags :
    "${it.instance_idx}:${it.tag_key}" => it
  })

  resource_id = each.value.interface_id
  key         = each.value.tag_key
  value       = each.value.tag_value
}
