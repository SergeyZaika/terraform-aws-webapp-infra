resource "aws_iam_role" "this" {
  name = "${var.service_name}"

  assume_role_policy = jsonencode(var.assume_role_policy)
  
  dynamic "inline_policy" {
    for_each = length(var.selected_policies) > 0 ? var.selected_policies : fileset("./policies", "*.json")

    content {
      name   = replace(inline_policy.value, ".json", "")
      policy = templatefile("./policies/${inline_policy.value}", {
        owner_id     = var.owner_id
        project_name = var.project_name
        env          = var.env
        cluster_name = lookup(var.additional_vars, "cluster_name", null)
      })
    }
  }

  managed_policy_arns = var.custom_managed_policies.use_custom_managed_policies ? var.custom_managed_policies.managed_policies : []
}
