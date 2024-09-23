aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "dev"
service_name       = "dept-ssgd"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 0000000

## domain
domains = {
  service = {
    name = "dev.bo.shinsegae.com"
  },
  mr = {
    name = "mr.bo.shinsegae.com"
  }
}

on_premise_dns_ip = ["174.100.20.2/32", "10.253.19.250/32"]

resolver_rules = {
  sso_forwarder_rule = {
    domain_name  = "gwsso.shinsegae.com"
    domain_label = "sso_forwarder_rule"
    forwarder1   = "174.100.20.2"
    forwarder2   = "10.253.19.250"
  }
  dev_sso_forwarder_rule = {
    domain_name  = "dev-dssso.shinsegae.com"
    domain_label = "dev_sso_forwarder_rule"
    forwarder1   = "174.100.20.2"
    forwarder2   = "10.253.19.250"
  }
  dev_spapi_forwarder_rule = {
    domain_name  = "devspapi.shinsegaepoint.com"
    domain_label = "dev_spapi_forwarder_rule"
    forwarder1   = "174.100.20.2"
    forwarder2   = "10.253.19.250"
  }
  dev_coreapi_forwarder_rule = {
    domain_name  = "devcoreapi.shinsegaepoint.com"
    domain_label = "dev_coreapi_forwarder_rule"
    forwarder1   = "174.100.20.2"
    forwarder2   = "10.253.19.250"
  }
}

kms_arn = "arn:aws:kms:ap-northeast-2:068254914844:key/36f7ceb8-91d7-4170-a181-389d234b66e1"

vpc_cidr            = "100.69.132.0/22"
vpc_secondary_cidrs = ["198.18.16.0/20"]

azs = ["ap-northeast-2a", "ap-northeast-2c"]

private_com_subnets       = ["100.69.132.0/27", "100.69.132.32/27"]
private_lb_subnets        = ["100.69.132.64/26", "100.69.132.128/26"]
private_db_subnets        = ["100.69.132.192/27", "100.69.132.224/27"]
private_app_subnets       = ["100.69.133.0/25", "100.69.133.128/25"]
private_batch_subnets     = ["100.69.134.0/25", "100.69.134.128/25"]
private_secondary_subnets = ["198.18.16.0/21", "198.18.24.0/21"]

vpc_endpoint = {
  sqs = {
    name = "sqs"
    type = "Interface"
  }
  ec2 = {
    name = "ec2"
    type = "Interface"
  }
  ecr_api = {
    name = "ecr.api"
    type = "Interface"
  }
  ecr_dkr = {
    name = "ecr.dkr"
    type = "Interface"
  }
  sts = {
    name = "sts"
    type = "Interface"
  }
  autoscaling = {
    name = "autoscaling"
    type = "Interface"
  }
  logs = {
    name = "logs"
    type = "Interface"
  }
  eks = {
    name = "eks"
    type = "Interface"
  }
  s3 = {
    name = "s3"
    type = "Gateway"
  }
}
