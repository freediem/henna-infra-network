resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.service_name}-vpc-${var.aws_shot_region}-${var.environment}",
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count = length(var.vpc_secondary_cidrs) > 0 ? length(var.vpc_secondary_cidrs) : 0

  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.vpc_secondary_cidrs, count.index)
}

## Security group for endpoint
resource "aws_security_group" "endpoint_sg" {
  name        = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-vpce"
  description = "Allow vpc endpoint traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-vpce"
  }
}

resource "aws_security_group_rule" "endpoint_allow_inbound_https" {
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  description       = "https from vpc"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "ingress"
  security_group_id = aws_security_group.endpoint_sg.id
}

resource "aws_security_group_rule" "endpoint_allow_secondary_inbound_https" {
  cidr_blocks       = [aws_vpc_ipv4_cidr_block_association.secondary_cidr[0].cidr_block]
  description       = "https from vpc"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "ingress"
  security_group_id = aws_security_group.endpoint_sg.id
}

resource "aws_security_group_rule" "endpoint_allow_outbound_https" {
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  description       = "https from vpc"
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  type              = "egress"
  security_group_id = aws_security_group.endpoint_sg.id
}

## VPC Endpoint
resource "aws_vpc_endpoint" "vpc_endpoint" {
  for_each = var.vpc_endpoint
  vpc_id            = aws_vpc.vpc.id

  service_name      = "com.amazonaws.${var.aws_region}.${each.value.name}"
  
  # gateway
  route_table_ids = each.value.type == "Gateway" ? [aws_route_table.private_route.id] : null

  # interface
  vpc_endpoint_type = each.value.type
  subnet_ids        = each.value.type == "Interface" ? flatten(["${aws_subnet.private_com_subnet.*.id}"]) : null
  security_group_ids = each.value.type == "Interface" ? [aws_security_group.endpoint_sg.id,] : null
  private_dns_enabled = each.value.type == "Interface" ? true : false

  tags = {
    Name = each.value.type == "Gateway" ? "${var.service_name}-vpce-${var.aws_shot_region}-${var.environment}-${each.value.name}-gw" : "${var.service_name}-vpce-${var.aws_shot_region}-${var.environment}-${each.value.name}"
  }
}

## ebs default encryption with kms ###
resource "aws_ebs_encryption_by_default" "ebs_encrypt" {
  enabled = true
}

resource "aws_ebs_default_kms_key" "ebs_kms" {
  key_arn    = var.kms_arn
  depends_on = [aws_vpc.vpc, ]
}
