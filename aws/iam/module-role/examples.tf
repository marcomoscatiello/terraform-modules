# module "iam_role_example_for_ec2_instance" {
#   source              = "./module-role-symlink"
#   enabled             = true
#   is_instance_profile = true
#   name                = "my_iam_role_example"
#
#   #Attach existing IAM Policy
#   attach_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
#     "arn:aws:iam::${var.account_id}:policy/my_custom_policy_example"
#   ]
#   inline_policies = [{
#     name = "AllowAssumeIAMRoleToDeploy"
#     statements = [
#       {
#         sid       = "AllowAssumeIAMRoleToDeploy"
#         actions   = ["sts:AssumeRole"]
#         resources = ["*"]
#       }
#     ]
#   }]
#
#   #Create and attach custom IAM policy
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
# #Attach tags to the IAM role
#   tags = {
#     Owner            = "DevOps Team"
#     Usage            = "Infrastructure deployment"
#     TerraformManaged = "true"
#   }
# }
