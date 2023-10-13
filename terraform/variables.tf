variable "aws_region" { type = string }
variable "aws_shot_region" { type = string }
variable "environment" { type = string }
variable "service_name" { type = string }
variable "domains" { type = map(any) }
variable "on_premise_dns_ip" { type = list }
variable "resolver_rules" {
  type = map(object({
    domain_name   = string
    domain_label  = string   
    forwarder1    = string
    forwarder2    = string
  }))
}
variable "kms_arn" { type = string }
variable "vpc_cidr" { type = string }
variable "vpc_secondary_cidrs" { type = list(any) }
variable "azs" { type = list(any) }
variable "private_lb_subnets" { type = list(any) }
variable "private_app_subnets" { type = list(any) }
variable "private_db_subnets" { type = list(any) }
variable "private_com_subnets" { type = list(any) }
variable "private_secondary_subnets" { type = list(any) }
variable "private_batch_subnets" { type = list(any) }
variable "vpc_endpoint" { type = any }