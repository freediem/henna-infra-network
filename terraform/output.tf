output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cluster_subnets" {
  value = concat(aws_subnet.private_lb_subnet[*].id, aws_subnet.private_app_subnet[*].id)
}

output "lb_subnets" {
  value = aws_subnet.private_lb_subnet[*].id
}

output "lb_cidr_blocks" {
  value = aws_subnet.private_lb_subnet[*].cidr_block
}

output "com_subnets" {
  value = aws_subnet.private_com_subnet[*].id
}

output "com_cidr_blocks" {
  value = aws_subnet.private_com_subnet[*].cidr_block
}

output "db_subnets" {
  value = aws_subnet.private_db_subnet[*].id
}

output "db_cidr_blocks" {
  value = aws_subnet.private_db_subnet[*].cidr_block
}

output "app_subnets" {
  value = aws_subnet.private_app_subnet[*].id
}

output "app_cidr_blocks" {
  value = aws_subnet.private_app_subnet[*].cidr_block
}

output "app_secondary_subnets" {
  value = aws_subnet.private_secondary_subnet[*].id
}

output "app_secondary_cidr_blocks" {
  value = aws_subnet.private_secondary_subnet[*].cidr_block
}

output "batch_cidr_blocks" {
  value = aws_subnet.private_batch_subnet[*].cidr_block
}

output "batch_subnets" {
  value = aws_subnet.private_batch_subnet[*].id
}

output "vpc_edp_s3_gw_id" {
  value = aws_vpc_endpoint.vpc_endpoint["s3"].id
}

output "app_subnet" {
  value = {
    ap-northeast-2a = flatten([for sbn in aws_subnet.private_app_subnet : sbn.id if sbn.availability_zone == "ap-northeast-2a"])[0]
    ap-northeast-2c = flatten([for sbn in aws_subnet.private_app_subnet : sbn.id if sbn.availability_zone == "ap-northeast-2c"])[0]
  }
}