# -------------------------------------------------------------------------------------------------
# IAM Role
# -------------------------------------------------------------------------------------------------
resource "aws_iam_role" "this" {
  count                 = var.enabled ? 1 : 0
  name                  = var.name
  path                  = "/"
  force_detach_policies = true
  permissions_boundary  = var.boundary_policy
  max_session_duration  = var.max_session_duration
  assume_role_policy    = data.aws_iam_policy_document.this_assume_role_policy.json
}

data "aws_iam_policy_document" "this_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.service_type_assume_role
      identifiers = var.identifiers_assume_role
    }
  }
}
# -------------------------------------------------------------------------------------------------
# Create and attach Custom Policies
# -------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "this_custom" {
  count = var.enabled ? length(var.custom_policies) : 0

  dynamic "statement" {
    for_each = var.custom_policies[count.index].statements

    content {
      sid       = lookup(statement.value, "sid", "")
      effect    = lookup(statement.value, "effect", "Allow")
      actions   = lookup(statement.value, "actions")
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "this_custom" {
  count  = var.enabled ? length(var.custom_policies) : 0
  name   = lookup(var.custom_policies[count.index], "name")
  path   = lookup(var.custom_policies[count.index], "path", "/")
  policy = data.aws_iam_policy_document.this_custom[count.index].json
}

resource "aws_iam_role_policy_attachment" "this_custom" {
  count      = length(var.custom_policies)
  role       = element(concat(aws_iam_role.this.*.name, [""]), 0)
  policy_arn = aws_iam_policy.this_custom[count.index].arn
}

# -------------------------------------------------------------------------------------------------
# Attach Inline Policies
# -------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "this_inline" {
  count = var.enabled ? length(var.inline_policies) : 0

  dynamic "statement" {
    for_each = var.inline_policies[count.index].statements

    content {
      sid       = lookup(statement.value, "sid", "")
      effect    = lookup(statement.value, "effect", "Allow")
      actions   = lookup(statement.value, "actions")
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_role_policy" "this_inline" {
  count  = var.enabled ? length(var.inline_policies) : 0
  name   = lookup(var.inline_policies[count.index], "name")
  role   = element(concat(aws_iam_role.this.*.name, [""]), 0)
  policy = data.aws_iam_policy_document.this_inline[count.index].json
}

# -------------------------------------------------------------------------------------------------
# Attach policy ARN's
# -------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "this_arn" {
  count      = var.enabled ? length(var.attach_policy_arns) : 0
  role       = element(concat(aws_iam_role.this.*.name, [""]), 0)
  policy_arn = var.attach_policy_arns[count.index]
}

resource "aws_iam_instance_profile" "this" {
  count = var.is_instance_profile ? 1 : 0
  name  = var.name
  path  = var.path
  role  = element(concat(aws_iam_role.this.*.name, [""]), 0)
}
