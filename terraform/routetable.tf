resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.service_name}-rt-${var.aws_shot_region}-${var.environment}-pri"
  }
}

resource "aws_route_table_association" "private_com_subnet_association" {
  count = length(var.private_com_subnets) > 0 ? length(var.private_com_subnets) : 0

  subnet_id      = element(aws_subnet.private_com_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_lb_subnet_association" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  subnet_id      = element(aws_subnet.private_lb_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_app_subnet_association" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  subnet_id      = element(aws_subnet.private_app_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_db_subnet_association" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  subnet_id      = element(aws_subnet.private_db_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_batch_subnet_association" {
  count = length(var.private_batch_subnets) > 0 ? length(var.private_batch_subnets) : 0

  subnet_id      = element(aws_subnet.private_batch_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_secondary_subnet_association" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  subnet_id      = element(aws_subnet.private_secondary_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route.id
}
