# App config
application = "demo"
name_sufix  = ""
app_port    = 80

# Task definition
task_cpu_size         = 1718
task_memory_size      = 637
container_cpu_units   = 1462
container_memory_hard = 573

# ECS Autoscaling Off
task_min_number = 0
task_max_number = 0
task_placement_strategy_rules = [
  {
    type  = "binpack"
    field = "cpu"
  }
]

# Lb listener
lb_listener_rule_host_header  = ["905418204391.realhandsonlabs.net"]
lb_listener_rule_path_pattern = ["/"]

# Target Group
tg_protocol                         = "HTTPS"
tg_deregistration_delay             = 10 # seconds
tg_slow_start                       = 30 # seconds
tg_health_check_interval            = 10 # seconds
tg_health_check_timeout             = 5  # seconds
tg_health_check_healthy_threshold   = 2
tg_health_check_unhealthy_threshold = 4
tg_health_check_matcher             = "200"
tg_health_check_path                = "/"

# Container Health Check
container_check_path         = "/"
container_check_start_period = 40 # seconds
container_check_interval     = 10 # seconds
container_check_timeout      = 5  # seconds
container_check_retries      = 4

# Service Discovery
service_discovery_namespace = "cloudnativesv-dev.local"

# Logs
logs_retention_in_days = 5