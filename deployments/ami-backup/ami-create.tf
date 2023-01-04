data "aws_sns_topic" "this" {
  name = var.sns_topic
}

module "lambda_create" {
  source           = "claranet/lambda/aws"
  version          = "1.2.0"
  function_name    = "${var.prefix}-ami-create"
  description      = "AMI Backup Automation - Create AMI snapshots of EC2 instances having Tag Backup set"
  handler          = "ami-create.lambda_handler"
  runtime          = "python3.8"
  timeout          = 300
  memory_size      = 200
  source_path      = "${path.module}/src/ami-create.py"
  trusted_entities = ["lambda.amazonaws.com"]
  policy = {
    json = data.aws_iam_policy_document.lambda.json
  }
  environment = {
    variables = {
      RETENTION_DAYS = 14
    }
  }
}

resource "aws_cloudwatch_event_rule" "cw_create" {
  name                = "${var.prefix}-ami-create"
  description         = "Schedule for ${var.prefix}-ami-create lambda function execution"
  schedule_expression = var.cloudwatch_trigger_ami_create
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "cw_create" {
  rule      = aws_cloudwatch_event_rule.cw_create.name
  target_id = "${var.prefix}-ami-create"
  arn       = module.lambda_create.function_arn
}

resource "aws_lambda_permission" "cw_create" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${var.prefix}-ami-create"
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cw_create.arn
}


resource "aws_cloudwatch_metric_alarm" "alarm-ami-create" {
  alarm_name          = "${var.prefix}-ami-create-monitor"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "notBreaching"
  alarm_description   = "This metric monitors Lamba AMI-Create invocations"
  alarm_actions       = [data.aws_sns_topic.this.arn]
  dimensions = {
    FunctionName = module.lambda_create.function_name
  }

}
