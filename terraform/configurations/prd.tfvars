aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "prd"
service_name       = "dept-ssgd"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 514738259429

## domain
domains = {
  service = {
    name = "bo.shinsegae.com"
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
  prd_sso_forwarder_rule= {
    domain_name = "dssso.shinsegae.com"
    domain_label = "prd_sso_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
  dev_spapi_forwarder_rule = {
    domain_name = "devspapi.shinsegaepoint.com"
    domain_label = "dev_spapi_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
  spapi_forwarder_rule = {
    domain_name = "spapi.shinsegaepoint.com"
    domain_label = "spapi_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
  crm_forwarder_rule = {
    domain_name = "crm.shinsegae.com"
    domain_label = "crm_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
  dev_coreapi_forwarder_rule = {
    domain_name = "devcoreapi.shinsegaepoint.com"
    domain_label = "dev_coreapi_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
  coreapi_forwarder_rule = {
    domain_name = "coreapi.shinsegaepoint.com"
    domain_label = "coreapi_forwarder_rule"
    forwarder1 = "174.100.20.2"
    forwarder2 = "10.253.19.250"
  }
}

kms_arn = "arn:aws:kms:ap-northeast-2:068254914844:key/027e1851-6565-49bc-9cb0-e0a6a8b7f2cc"

vpc_cidr            = "100.69.140.0/22"
vpc_secondary_cidrs = ["198.18.48.0/20"]

azs = ["ap-northeast-2a", "ap-northeast-2c"]

private_com_subnets       = ["100.69.140.0/27", "100.69.140.32/27"]
private_lb_subnets        = ["100.69.140.64/26", "100.69.140.128/26"]
private_db_subnets        = ["100.69.140.192/27", "100.69.140.224/27"]
private_app_subnets       = ["100.69.141.0/25", "100.69.141.128/25"]
private_batch_subnets     = ["100.69.142.0/25", "100.69.142.128/25"]
private_secondary_subnets = ["198.18.48.0/21", "198.18.56.0/21"]

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
