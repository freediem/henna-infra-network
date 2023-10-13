## db subnet group

resource "aws_db_subnet_group" "aurora" {
    count = var.environment == "com" ? 0 : 1
    name       = "${var.service_name}-sbng-${var.aws_shot_region}-${var.environment}-pri-db"
    subnet_ids = aws_subnet.private_db_subnet[*].id

    tags = {
        Name = "${var.service_name}-sbng-${var.aws_shot_region}-${var.environment}-pri-db"
  }
}