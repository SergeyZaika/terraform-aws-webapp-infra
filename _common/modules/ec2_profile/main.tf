resource "aws_iam_instance_profile" "this" {
  name = "${var.env}_${var.project_name}_${var.service_name}"
  role = var.role_name
}