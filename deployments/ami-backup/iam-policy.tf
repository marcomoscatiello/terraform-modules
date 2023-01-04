data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "ec2:CreateImage",
      "ec2:CreateTags",
      "ec2:DeregisterImage",
      "ec2:DescribeInstances",
      "ec2:DescribeImages",
      "ec2:ModifySnapshotAttribute",
      "ec2:ResetSnapshotAttribute",
      "ec2:DescribeSnapshots",
      "ec2:DeleteSnapshot"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
  # statement {
  #   actions = [
  #     "sns:Publish"
  #   ]
  #   resources = [
  #     "arn:aws:sns:${var.region}:${var.account_id}:tda-devops-alerts"
  #   ]
  # }
}
