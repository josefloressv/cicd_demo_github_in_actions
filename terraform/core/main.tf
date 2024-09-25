# Network
module "net" {
  source               = "../modules/network_acg"
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  private_subnet1_cidr = var.private_subnet1_cidr
  private_subnet2_cidr = var.private_subnet2_cidr
  public_subnet1_cidr  = var.public_subnet1_cidr
  public_subnet2_cidr  = var.public_subnet2_cidr
  tags                 = local.common_tags
}

# AMI
module "ami" {
  source = "../modules/ami_search"
}

# ASG and Clusters
module "asg_ecs_linux" {
  source                           = "../modules/ecs_ec2_cluster"
  base_name                        = "demo"
  operating_system                 = "linux"
  lt_ami_id                        = module.ami.id
  private_subnets_ids              = module.net.private_subnet_ids
  public_subnets_cidr              = local.public_subnets_cidr
  asg_vpc_id                       = module.net.vpc_id
  asg_min_size                     = var.linux_asg_min_size
  asg_max_size                     = var.linux_asg_max_size
  cp_instance_warmup_period        = var.linux_cp_instance_warmup_period
  cp_min_scaling_step_size         = var.linux_cp_min_scaling_step_size
  cp_max_scaling_step_size         = var.linux_cp_max_scaling_step_size
  use_default_block_device_mapping = false
  cp_target_capacity               = var.linux_cp_target_capacity
  lt_instance_type                 = var.linux_lt_instance_type

  tags = local.common_tags
}

# ALB
module "alb" {
  source          = "../modules/alb"
  vpc_id          = module.net.vpc_id
  public_subnets  = module.net.public_subnet_ids
  certificate_arn = aws_acm_certificate_validation.main.certificate_arn
  tags            = local.common_tags
}
