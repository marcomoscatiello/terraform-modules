## *Lambda AMI-Backup solution*
Lambda Module for AMI Automated backups. This module creates 2 Lambda functions [ami-create, ami-delete] that are checking the EC2 instances with the Tag 'Backup:true' and hold a window of 14 days backups.
The ami-delete lambda function checks the AMI images with the Tag 'DeleteOn' and if the Value of the tag has a date that is 14 days less than the current day , the AMI gets deleted.
The Retention Days are 14 days by default but you can set a custom retention days value for an EC2 instance by adding the Tag 'Retention' : days   in order to set a DeleteOn tag based on your Retention Tag value.
The Lambda functions are triggered by Cloudwatch every evening at:
ami-create -> 10pm
ami-delete -> 11pm  

In case of failure, Cloudwatch alarm notifies the issue to the emails registered to the SNS-Topic 'tda-devops-alerts'

## Requirements

The SNS Topic (by default tda-devops-alerts) needs to exist otherwise terraform cannot set the cloudwatch alarm and the SNS Topic to be notified in case of alarms.


**Add Tag to EC2 instances**

In order to start taking AMI snapshots, you need to add the following Tag to Ec2 instance:

*Backup: true*


**Retention Days for AMIs**

You can set a custom Retention period for AMI snapshots of the Ec2 instance by adding the following Tag to Ec2:

*Retention: 'days'  [int]*

By default the Retention is set to 14 days.


## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_id | The AWS account\_id that owns the AMI snapshots to be deleted | `string` | n/a | yes |
| cloudwatch\_trigger\_ami\_create | AWS Cron expression - Time to start Lambda AMI-Create | `string` | `"cron(0 22 ? * * *)"` | no |
| cloudwatch\_trigger\_ami\_delete | AWS Cron expression - Time to start Lambda AMI-Delete | `string` | `"cron(0 23 ? * * *)"` | no |
| prefix | Resources prefix for proper naming (e.g. tui-tda) | `string` | `"tui-tda"` | no |
| retention\_days | Set the number of days before an AMI gets deleted | `string` | `14` | no |
| tags | Tags for all resources of this module | `map` | `{}` | no |

## Outputs

No output.
