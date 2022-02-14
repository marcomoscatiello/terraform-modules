# This example shows how to create a new user using the terraform module "user-module" . This file is supposed to be created in parent folder of the user-module directory.
# This module was mainly defined to create service users in AWS IAM service, therefore the definition of the name has as prefix "svc".
# The naming convention for the IAM name is: svc.<account_id>.<department>.<team>.<application>.<description>

# module "svc_user" {
#   source = "./user-module-symlink"
#   name   = "svc.${var.account_id}.tda.devops.jenkins.deploy"
#   #Create Custom Policy
#   custom_policies = [{
#     name = "MyCustomPolicy1"
#     statements = [
#       {
#         sid       = "Sid-custom-1"
#         actions   = ["s3:ListBucket"]
#         resources = ["arn:aws:s3:::test"]
#       },
#       {
#         sid       = "Sid-custom-2"
#         actions   = ["ec2:*"]
#         resources = ["*"]
#       }
#     ]
#   }]
#
#   #Attach existing IAM Policy
#   attach_policy_arns = [
#     "arn:aws:iam::aws:policy/PowerUserAccess"
#   ]
#
#   #Create Inline Policy
#   inline_policies = [{
#     name = "MyInlinePolicy"
#     statements = [
#       {
#         sid       = "Sid-Inline"
#         actions   = ["s3:ListBucket"]
#         resources = ["arn:aws:s3:::my-custom-s3-bucket"]
#       }
#     ]
#   }]
#
# }
