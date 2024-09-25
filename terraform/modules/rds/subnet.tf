
resource "aws_db_subnet_group" "main" {
    name        = var.db_subnet_group_name
    subnet_ids  = var.db_subnet_ids
    tags        = var.tags
}
