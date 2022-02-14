## Requirements

This IAM module allows to easily create IAM roles and attach custom, inline or existing IAM policies. Follow the examples.tf to understand how to create an IAM role.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this_inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.this_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this_inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_policy_arns"></a> [attach\_policy\_arns](#input\_attach\_policy\_arns) | Existing policy ARNs to attach to the IAM role | `list(string)` | `[]` | no |
| <a name="input_boundary_policy"></a> [boundary\_policy](#input\_boundary\_policy) | The permission boundary IAM policy if required | `string` | `""` | no |
| <a name="input_custom_policies"></a> [custom\_policies](#input\_custom\_policies) | Custom policies to create and attach to the IAM user | <pre>list(object({<br>    name = string<br>    statements = list(object({<br>      sid       = string<br>      actions   = list(string)<br>      resources = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_identifiers_assume_role"></a> [identifiers\_assume\_role](#input\_identifiers\_assume\_role) | AWS identifier of the assume role or arn | `list(string)` | <pre>[<br>  "ec2.amazonaws.com"<br>]</pre> | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | Inline defined policies to attach to the IAM user | <pre>list(object({<br>    name = string<br>    statements = list(object({<br>      sid       = string<br>      actions   = list(string)<br>      resources = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_is_instance_profile"></a> [is\_instance\_profile](#input\_is\_instance\_profile) | Set to true if the IAM role will be attached to EC2 instance | `bool` | `false` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The max session duration for the role. Can be set between secs[3600,43200] that is 1-12 hours | `string` | `"3600"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the IAM role | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path of the IAM user | `string` | `"/tui-tda/"` | no |
| <a name="input_service_type_assume_role"></a> [service\_type\_assume\_role](#input\_service\_type\_assume\_role) | AWS Service Type of the assume role. Service or AWS | `string` | `"Service"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Generic Tags for all resources | `map(any)` | `{}` | no |

## Outputs

No outputs.
