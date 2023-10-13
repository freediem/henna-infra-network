resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id   

  tags = {
    Name = "${var.service_name}-nacl-${var.aws_shot_region}-${var.environment}"
  }
}

resource "aws_network_acl_association" "private_com_subnet_nacl_association" {
  count = length(var.private_com_subnets) > 0 ? length(var.private_com_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_com_subnet[*].id, count.index)
}

resource "aws_network_acl_association" "private_lb_subnet_nacl_association" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_lb_subnet[*].id, count.index)
}

resource "aws_network_acl_association" "private_app_subnet_nacl_association" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_app_subnet[*].id, count.index)
}  

resource "aws_network_acl_association" "private_db_subnet_nacl_association" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_db_subnet[*].id, count.index)
}

resource "aws_network_acl_association" "private_batch_subnet_nacl_association" {
  count = length(var.private_batch_subnets) > 0 ? length(var.private_batch_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_batch_subnet[*].id, count.index)
}

resource "aws_network_acl_association" "private_secondary_subnet_nacl_association" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = element(aws_subnet.private_secondary_subnet[*].id, count.index)
}  

## SMB Deny ##
## Inbound ##
resource "aws_network_acl_rule" "inbound_tcp_139" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 1
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 139
  to_port        = 139
}

resource "aws_network_acl_rule" "inbound_tcp_445" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 2
  egress         = false
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 445
  to_port        = 445
}

resource "aws_network_acl_rule" "inbound_udp_137" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 3
  egress         = false
  protocol       = "udp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 137
  to_port        = 137
}

resource "aws_network_acl_rule" "inbound_udp_138" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 4
  egress         = false
  protocol       = "udp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 138
  to_port        = 138
}
resource "aws_network_acl_rule" "inbound_all_allow" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

## Outbound ##
resource "aws_network_acl_rule" "outbound_tcp_139" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 1
  egress         = true
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 139
  to_port        = 139
}

resource "aws_network_acl_rule" "outbound_tcp_445" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 2
  egress         = true
  protocol       = "tcp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 445
  to_port        = 445
}

resource "aws_network_acl_rule" "outbound_udp_137" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 3
  egress         = true
  protocol       = "udp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 137
  to_port        = 137
}

resource "aws_network_acl_rule" "outbound_udp_138" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 4
  egress         = true
  protocol       = "udp"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
  from_port      = 138
  to_port        = 138
}
resource "aws_network_acl_rule" "outbound_all_allow" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}