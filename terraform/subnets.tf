resource "aws_subnet" "private_com_subnet" {
  count = length(var.private_com_subnets) > 0 ? length(var.private_com_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_com_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-com-${split("-", element(var.azs, count.index))[2]}",
  }
}

resource "aws_subnet" "private_lb_subnet" {
  count = length(var.private_lb_subnets) > 0 ? length(var.private_lb_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_lb_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-lb-${split("-", element(var.azs, count.index))[2]}",
  }
}

resource "aws_subnet" "private_app_subnet" {
  count = length(var.private_app_subnets) > 0 ? length(var.private_app_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_app_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-app-${split("-", element(var.azs, count.index))[2]}",
  }
}

resource "aws_subnet" "private_db_subnet" {
  count = length(var.private_db_subnets) > 0 ? length(var.private_db_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_db_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-db-${split("-", element(var.azs, count.index))[2]}",
  }
}

resource "aws_subnet" "private_batch_subnet" {
  count = length(var.private_batch_subnets) > 0 ? length(var.private_batch_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_batch_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-batch-${split("-", element(var.azs, count.index))[2]}",
  }
}

resource "aws_subnet" "private_secondary_subnet" {
  count = length(var.private_secondary_subnets) > 0 ? length(var.private_secondary_subnets) : 0

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_secondary_subnets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.secondary_cidr,
  ]

  tags = {
    Name = "${var.service_name}-sbn-${var.aws_shot_region}-${var.environment}-pri-secondary-${split("-", element(var.azs, count.index))[2]}",
  }
}
