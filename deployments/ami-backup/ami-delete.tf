
module "lambda_delete" {
  source           = "claranet/lambda/aws"
  version          = "1.2.0"
  function_name    = "${var.prefix}-ami-delete"
  description      = "AMI Backup Automation - Delete AMI snapshots having Tag DeleteOn"
  handler          = "ami-delete.lambda_handler"
  runtime          = "python3.8"
  timeout          = 300
  memory_size      = 200
  source_path      = "${path.module}/src/ami-delete.py"
  trusted_entities = ["lambda.amazonaws.com"]
  policy = {
    json = data.aws_iam_policy_document.lambda.json
  }
  environment = {
    variables = {
      ACCOUNT_ID = var.account_id
    }
  }
}

resource "aws_cloudwatch_event_rule" "cw_delete" {
  name                = "${var.prefix}-ami-delete"
  description         = "Schedule for ${var.prefix}-ami-delete lambda function execution"
  schedule_expression = var.cloudwatch_trigger_ami_delete
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "cw_delete" {
  rule      = aws_cloudwatch_event_rule.cw_delete.name
  target_id = "${var.prefix}-ami-delete"
  arn       = module.lambda_delete.function_arn
}

resource "aws_lambda_permission" "cw_delete" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${var.prefix}-ami-delete"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cw_delete.arn
}

resource "aws_cloudwatch_metric_alarm" "alarm-ami-delete" {
  alarm_name          = "${var.prefix}-ami-delete-monitor"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_description   = "This metric monitors Lamba AMI-Delete invocations"
  alarm_actions       = [data.aws_sns_topic.this.arn]
  dimensions = {
    FunctionName = module.lambda_delete.function_name
  }

}
