variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "is_instance_profile" {
  description = "Set to true if the IAM role will be attached to EC2 instance"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the IAM role"
  type        = string
}

variable "path" {
  description = "Path of the IAM user"
  default     = "/tui-tda/"
  type        = string
}

variable "service_type_assume_role" {
  description = "AWS Service Type of the assume role. Service or AWS"
  type        = string
  default     = "Service"
}

variable "identifiers_assume_role" {
  description = "AWS identifier of the assume role or arn"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "boundary_policy" {
  description = "The permission boundary IAM policy if required"
  default     = ""
  type        = string
}

variable "max_session_duration" {
  description = "The max session duration for the role. Can be set between secs[3600,43200] that is 1-12 hours"
  default     = "3600"
  type        = string
}
variable "attach_policy_arns" {
  description = "Existing policy ARNs to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "custom_policies" {
  description = "Custom policies to create and attach to the IAM user"
  default     = []
  type = list(object({
    name = string
    statements = list(object({
      sid       = string
      actions   = list(string)
      resources = list(string)
    }))
  }))
}

variable "inline_policies" {
  description = "Inline defined policies to attach to the IAM user"
  default     = []
  type = list(object({
    name = string
    statements = list(object({
      sid       = string
      actions   = list(string)
      resources = list(string)
    }))
  }))
}

variable "tags" {
  type        = map(any)
  description = "Generic Tags for all resources"
  default     = {}
}
