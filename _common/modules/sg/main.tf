resource "aws_security_group" "this" {
  name        = var.sg_settings.name
  description = var.sg_settings.description
  vpc_id      = var.sg_settings.vpc_id

  dynamic "ingress" {
    for_each = var.sg_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks != null ? ingress.value.cidr_blocks : []
      security_groups = ingress.value.security_groups != null ? ingress.value.security_groups : []
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.sg_settings.tags
}
