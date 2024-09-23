aws_region         = "ap-northeast-2"
aws_shot_region    = "an2"
environment        = "com"
service_name       = "dept-ssgd"
s3_tfstate_file    = "network.tfstate"
aws_account_number = 2222222

## domain
domains = {
    service = {
        name = "com.bo.shinsegae.com"
    }
}

on_premise_dns_ip = ["174.100.20.2/32", "10.253.19.250/32"]

resolver_rules = {
}

kms_arn = "arn:aws:kms:ap-northeast-2:068254914844:key/114c2d4d-8439-47fe-87ba-a36b0fcf5d65"

vpc_cidr            = "100.69.130.0/23"
vpc_secondary_cidrs = ["198.18.0.0/20"]

azs = ["ap-northeast-2a", "ap-northeast-2c"]

private_com_subnets       = ["100.69.130.0/27", "100.69.130.32/27"]
private_lb_subnets        = ["100.69.130.64/26", "100.69.130.128/26"]
private_db_subnets        = []
private_app_subnets       = ["100.69.131.0/25", "100.69.131.128/25"]
private_batch_subnets     = []
private_secondary_subnets = ["198.18.0.0/21", "198.18.8.0/21"]

vpc_endpoint = {
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
  s3 = {
    name = "s3"
    type = "Gateway"
  }
}
