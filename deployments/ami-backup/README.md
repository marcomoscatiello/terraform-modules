## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_create"></a> [lambda\_create](#module\_lambda\_create) | claranet/lambda/aws | 1.2.0 |
| <a name="module_lambda_delete"></a> [lambda\_delete](#module\_lambda\_delete) | claranet/lambda/aws | 1.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cw_create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.cw_delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cw_create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.cw_delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_metric_alarm.alarm-ami-create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.alarm-ami-delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_lambda_permission.cw_create](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.cw_delete](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The AWS account\_id that owns the AMI snapshots to be deleted | `string` | n/a | yes |
| <a name="input_cloudwatch_trigger_ami_create"></a> [cloudwatch\_trigger\_ami\_create](#input\_cloudwatch\_trigger\_ami\_create) | AWS Cron expression - Time to start Lambda AMI-Create | `string` | `"cron(0 22 ? * * *)"` | no |
| <a name="input_cloudwatch_trigger_ami_delete"></a> [cloudwatch\_trigger\_ami\_delete](#input\_cloudwatch\_trigger\_ami\_delete) | AWS Cron expression - Time to start Lambda AMI-Delete | `string` | `"cron(0 23 ? * * *)"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resources prefix for proper naming | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where you deploy the lambda functions | `string` | n/a | yes |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Set the number of days before an AMI gets deleted | `string` | `14` | no |
| <a name="input_sns_topic"></a> [sns\_topic](#input\_sns\_topic) | The SNS Topic to notify in case of lambda errors | `string` | `"devops-alerts"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for all resources of this module | `map(any)` | `{}` | no |

## Outputs

No outputs.
