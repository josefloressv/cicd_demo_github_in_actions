
resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = "${local.name_prefix}.local"
  description = "Cloud map zone"
  vpc         = data.aws_vpc.main.id
}
