resource "aws_db_instance" "main" {
    engine                                = "mariadb"
    engine_version                        = var.engine_version
    identifier                            = var.identifier
    instance_class                        = var.instance_class
    allocated_storage                     = var.allocated_storage
    auto_minor_version_upgrade            = false # Upgrade should be controled by us
    availability_zone                     = var.availability_zone
    backup_retention_period               = var.backup_retention_period
    backup_window                         = var.backup_window
    copy_tags_to_snapshot                 = true
    db_subnet_group_name                  = aws_db_subnet_group.main.name
    delete_automated_backups              = true
    deletion_protection                   = true
    enabled_cloudwatch_logs_exports       = ["audit", "error", "general", "slowquery"]
    maintenance_window                    = var.maintenance_window
    max_allocated_storage                 = var.max_allocated_storage # TBD, Configuring this will automatically ignore differences to allocated_storage
    option_group_name                     = "default:mariadb-10-4"
    parameter_group_name                  = aws_db_parameter_group.custom.name
    performance_insights_enabled          = var.performance_insights_enabled
    performance_insights_retention_period = var.performance_insights_retention_period
    port                                  = 3306
    publicly_accessible                   = false
    skip_final_snapshot                   = true
    storage_encrypted                     = true
    tags                                  = var.tags
    db_name                               = var.db_name
    username                              = var.username # Cannot be specified for a replica.
    password                              = var.password # TBD, use Secrets Manager, need to be replaced by manage_master_user_password = true and master_user_secret_kms_key_id
    vpc_security_group_ids                = [aws_security_group.db.id]
    apply_immediately                     = false
    lifecycle {
        ignore_changes = [
            db_name,
            username,
            password,
        ]
    }
}

resource "aws_db_instance" "replica" {
    count = var.enable_replica ? 1 : 0
    replicate_source_db = aws_db_instance.main.identifier
    engine                                = "mariadb"
    engine_version                        = var.engine_version
    identifier                            = "${var.identifier}-read"
    instance_class                        = var.instance_class
    allocated_storage                     = var.allocated_storage
    auto_minor_version_upgrade            = false # Upgrade should be controled by us
    availability_zone                     = var.availability_zone_replica
    backup_retention_period               = 0
    db_subnet_group_name                  = aws_db_subnet_group.main.name
    delete_automated_backups              = true
    deletion_protection                   = true
    enabled_cloudwatch_logs_exports       = ["audit", "error", "general", "slowquery"]
    maintenance_window                    = var.maintenance_window
    max_allocated_storage                 = var.max_allocated_storage # TBD, Configuring this will automatically ignore differences to allocated_storage
    option_group_name                     = "default:mariadb-10-4"
    parameter_group_name                  = aws_db_parameter_group.custom.name
    performance_insights_enabled          = var.performance_insights_enabled
    performance_insights_retention_period = var.performance_insights_retention_period
    monitoring_interval                   = 60
    port                                  = 3306
    publicly_accessible                   = false
    skip_final_snapshot                   = true
    storage_encrypted                     = true
    tags                                  = var.tags
    vpc_security_group_ids                = [aws_security_group.db.id]
    apply_immediately                     = false
    lifecycle {
        ignore_changes = [
            db_name,
            username,
            password,
        ]
    }
}
