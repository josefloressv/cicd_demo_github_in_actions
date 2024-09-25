# Create route53 record for the ALB

data "aws_route53_zone" "main" {
  # ACG Lab Route53 Zone standard
  name = "${local.aws_account_id}.realhandsonlabs.net"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = data.aws_route53_zone.main.name
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}