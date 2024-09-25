
resource "aws_db_parameter_group" "custom" {
  name   = var.db_parameter_group_name
  family = "mariadb10.4"

  # parameters will be Ignored after first creation, but we can document here for future reference
  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
    # This parameter allows stored functions to create or modify tables that would log changes. 
    # Setting to 1 bypasses the binary logging format restrictions.
  }

  parameter {
    name  = "slow_query_log"
    value = "ON"
    # Enables the slow query log to identify queries that take a long time to execute, 
    # which can be useful for debugging and optimization.
  }

  parameter {
    name  = "long_query_time"
    value = "60" #seconds
    # Defines the threshold in seconds for what is considered a slow query. 
    # Here, queries taking longer than 60 seconds to execute are logged.
  }

  parameter {
    name  = "lower_case_table_names"
    value = "1" # 1 for case-insensitive, 0 for case-sensitive
    apply_method = "pending-reboot"
    # Determines the case sensitivity of table names. 
    # A value of 1 makes table names case-insensitive, which is useful for cross-platform compatibility.
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      parameter,
      description
    ]
  }
}