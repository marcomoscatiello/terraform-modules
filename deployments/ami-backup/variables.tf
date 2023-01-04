variable "account_id" {
  type        = string
  description = "The AWS account_id that owns the AMI snapshots to be deleted"
}

variable "region" {
  type        = string
  description = "The AWS region where you deploy the lambda functions"
}

variable "sns_topic" {
  type        = string
  description = "The SNS Topic to notify in case of lambda errors"
  default     = "tda-devops-alerts"
}

variable "prefix" {
  type        = string
  description = "Resources prefix for proper naming (e.g. tui-tda)"
  default     = "tui-tda"
}

variable "tags" {
  type        = map(any)
  description = "Tags for all resources of this module"
  default     = {}
}

variable "retention_days" {
  type        = string
  description = "Set the number of days before an AMI gets deleted"
  default     = 14
}

variable "cloudwatch_trigger_ami_create" {
  type        = string
  description = "AWS Cron expression - Time to start Lambda AMI-Create"
  default     = "cron(0 22 ? * * *)"
}

variable "cloudwatch_trigger_ami_delete" {
  type        = string
  description = "AWS Cron expression - Time to start Lambda AMI-Delete"
  default     = "cron(0 23 ? * * *)"
}
