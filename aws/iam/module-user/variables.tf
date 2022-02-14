variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the Service"
  type        = string
}

variable "path" {
  description = "Path of the IAM user"
  default     = "/"
  type        = string
}

variable "boundary_policy" {
  description = "The permission boundary IAM policy if required"
  default     = ""
  type        = string
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

variable "attach_policy_arns" {
  description = "Existing policy ARNs to attach to the IAM user"
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "Generic Tags for all resources"
  default     = {}
}
