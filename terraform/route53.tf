resource "aws_route53_zone" "private_zone" {
  for_each = var.domains

  name = each.value.name

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  lifecycle { ignore_changes = [vpc] }

  tags = {
    Name = "${each.value.name}"
  }
}

## inbound resolver
resource "aws_security_group" "resolver_sg" {
  name        = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-resolver-in"
  description = "Allow management traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-resolver-in"
  }
}

resource "aws_security_group_rule" "resolver_allow_inbound_tcp_53" {
    description = "dns from on-premise dns"
    from_port = 53
    protocol = "tcp"
    to_port = 53
    type = "ingress"
    security_group_id = aws_security_group.resolver_sg.id
    cidr_blocks = flatten(["${var.on_premise_dns_ip}"])
}

resource "aws_security_group_rule" "resolver_allow_inbound_udp_53" {
    description = "dns from on-premise dns"
    from_port = 53
    protocol = "udp"
    to_port = 53
    type = "ingress"
    security_group_id = aws_security_group.resolver_sg.id
    cidr_blocks = flatten(["${var.on_premise_dns_ip}"])
}

resource "aws_route53_resolver_endpoint" "inbound" {
  name      = "${var.service_name}-rslvr-in-${var.aws_shot_region}-${var.environment}"
  direction = "INBOUND"

  security_group_ids = [
    aws_security_group.resolver_sg.id,
  ]

  ip_address {
    subnet_id = aws_subnet.private_com_subnet[0].id
  }

  ip_address {
    subnet_id = aws_subnet.private_com_subnet[1].id
  }

  tags = {
    Name = "${var.service_name}-rslvr-in-${var.aws_shot_region}-${var.environment}"
  }
}

## outbound resolver
resource "aws_security_group" "resolver_out_sg" {
  count = var.environment == "com" ? 0 : 1
  name        = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-resolver-out"
  description = "Allow management traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.service_name}-sg-${var.aws_shot_region}-${var.environment}-resolver-out"
  }
}

resource "aws_security_group_rule" "resolver_allow_outbound_tcp_53" {
  count = var.environment == "com" ? 0 : 1
  description = "dns to on-premise dns"
  from_port = 53
  protocol = "tcp"
  to_port = 53
  type = "egress"
  security_group_id = aws_security_group.resolver_out_sg[count.index].id
  cidr_blocks = flatten(["${var.on_premise_dns_ip}"])
}

resource "aws_security_group_rule" "resolver_allow_outbound_udp_53" {
  count = var.environment == "com" ? 0 : 1
  description = "dns to on-premise dns"
  from_port = 53
  protocol = "udp"
  to_port = 53
  type = "egress"
  security_group_id = aws_security_group.resolver_out_sg[count.index].id
  cidr_blocks = flatten(["${var.on_premise_dns_ip}"])
}

resource "aws_route53_resolver_endpoint" "outbound" {
  count = var.environment == "com" ? 0 : 1
  name      = "${var.service_name}-rslvr-out-${var.aws_shot_region}-${var.environment}"
  direction = "OUTBOUND"

  security_group_ids = [
    aws_security_group.resolver_out_sg[count.index].id,
  ]

  ip_address {
    subnet_id = aws_subnet.private_com_subnet[0].id
  }

  ip_address {
    subnet_id = aws_subnet.private_com_subnet[1].id
  }

  tags = {
    Name = "${var.service_name}-rslvr-out-${var.aws_shot_region}-${var.environment}"
  }
}

### resolver rule
resource "aws_route53_resolver_rule" "fwd" {
  for_each = var.resolver_rules
  domain_name          = each.value.domain_name
  name                 = each.value.domain_label
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound[0].id

  target_ip {
    ip = each.value.forwarder1
  }
  
  target_ip {
    ip = each.value.forwarder2
  }

  tags = {
    Name = each.value.domain_label
  }
}

resource "aws_route53_resolver_rule_association" "rsv_rule_association" {
  for_each = var.resolver_rules
  resolver_rule_id = aws_route53_resolver_rule.fwd[each.key].id
  vpc_id           = aws_vpc.vpc.id
}