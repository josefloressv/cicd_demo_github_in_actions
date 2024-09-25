
# ECS Apps
module "demo" {
  source = "../../modules/app"
  # General
  aws_region = var.aws_region
  vpc_id     = local.tfcore.vpc_id
  vpc_cidr   = local.tfcore.vpc_cidr
  name_sufix = ""
  app_port   = var.app_port
  tags       = local.common_tags

  # ECS service
  task_definition_arn           = aws_ecs_task_definition.main.arn
  ecs_cluster_id                = local.tfcore.linux_ecs_cluster_arn
  private_subnet_ids            = local.tfcore.private_subnet_ids
  task_placement_strategy_rules = var.task_placement_strategy_rules

  # ECS Autoscaling
  ecs_cluster_name       = local.tfcore.linux_ecs_cluster_name
  capacity_provider_name = local.tfcore.linux_ecs_cluster_capacity_provider_name

  task_min_number = var.task_min_number
  task_max_number = var.task_max_number

  cpu_target_threshold          = var.cpu_target_threshold
  cpu_scaleout_cooldown_seconds = var.cpu_scaleout_cooldown_seconds
  cpu_scalein_cooldown_seconds  = var.cpu_scalein_cooldown_seconds

  memory_target_threshold          = var.memory_target_threshold
  memory_scaleout_cooldown_seconds = var.memory_scaleout_cooldown_seconds
  memory_scalein_cooldown_seconds  = var.memory_scalein_cooldown_seconds

  # Lb listener
  lb_http_listener_arn          = local.tfcore.alb_https_listener_arn
  lb_listener_rule_host_header  = var.lb_listener_rule_host_header
  lb_listener_rule_path_pattern = var.lb_listener_rule_path_pattern

  # Target Group
  tg_protocol                         = var.tg_protocol
  tg_deregistration_delay             = var.tg_deregistration_delay
  tg_slow_start                       = var.tg_slow_start
  tg_health_check_interval            = var.tg_health_check_interval
  tg_health_check_timeout             = var.tg_health_check_timeout
  tg_health_check_healthy_threshold   = var.tg_health_check_healthy_threshold
  tg_health_check_unhealthy_threshold = var.tg_health_check_unhealthy_threshold
  tg_health_check_matcher             = var.tg_health_check_matcher
  tg_health_check_path                = var.tg_health_check_path

  # Service Discovery
  create_service_discovery    = true
  service_discovery_namespace = var.service_discovery_namespace
}
