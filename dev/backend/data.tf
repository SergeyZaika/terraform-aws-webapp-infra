data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket"
    key    = "dev/vpc/vpc.tfstate"
    region = "ca-central-1"
  }
}
data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = [var.ec2_psql_settings.architecture]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu*${var.ec2_psql_settings.os_version}*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

