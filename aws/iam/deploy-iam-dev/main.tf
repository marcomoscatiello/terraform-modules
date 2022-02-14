# This Terraform module collects all IAM users and roles that needs to be deployed in a developement AWS account.
# This module creates an EC2 instance Role that has permissions to assume an IAM role to deploy infrastructure in the same AWS account and potentially in others.

module "jenkins_role_assume_infrastructure-deploy" {
  source              = "./module-role-symlink"
  enabled             = true
  is_instance_profile = true
  name                = "jenkins-assume-infrastructure-deploy"

  #Attach existing IAM Policy
  attach_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
  inline_policies = [{
    name = "AllowAssumeIAMRoleToDeploy"
    statements = [
      {
        sid       = "AllowAssumeIAMRoleToDeploy"
        actions   = ["sts:AssumeRole"]
        resources = ["*"]
      }
    ]
  }]

  tags = {
    Owner            = "DevOps Team"
    Usage            = "Jenkins Infrastructure Deployment"
    TerraformManaged = "true"
  }
}

module "tda_mbaas_jenkins_role_infrastructure_deploy" {
  source                   = "./module-role-symlink"
  enabled                  = true
  name                     = "jenkins-infrastructure-deploy"
  service_type_assume_role = "AWS"
  identifiers_assume_role  = ["arn:aws:iam::543548560833:role/jenkins-assume-infrastructure-deploy"]
  #Attach existing IAM Policy
  inline_policies = [{
    name = "JenkinsDeployInfrastructure"
    statements = [
      {
        sid = "JenkinsDeployInfrastructure"
        actions = [
          "sqs:*",
          "application-autoscaling:*",
          "route53resolver:*",
          "rds:*",
          "logs:*",
          "backup:*",
          "dynamodb:*",
          "autoscaling:*",
          "cloudfront:*",
          "secretsmanager:*",
          "ses:*",
          "kms:*",
          "wafv2:*",
          "events:*",
          "elasticfilesystem:*",
          "sns:*",
          "s3:*",
          "apigateway:*",
          "cloudformation:*",
          "elasticloadbalancing:*",
          "autoscaling-plans:*",
          "iam:*",
          "es:*",
          "cloudwatch:*",
          "waf:*",
          "ssm:*",
          "lambda:*",
          "route53:*",
          "ec2:*",
          "waf-regional:*",
          "eks:*",
          "elasticache:*",
          "acm:*",
          "ecr:*",
          "servicediscovery:*",
          "ecs:*"
        ]
        resources = ["*"]
      }
    ]
  }]

  tags = {
    Owner            = "DevOps Team"
    Usage            = "Jenkins Infrastructure Deployment"
    TerraformManaged = "true"
  }
}
