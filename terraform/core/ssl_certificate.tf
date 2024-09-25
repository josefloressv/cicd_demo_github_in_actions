# Create a new Certificate for AWS Certificate Manager (ACM) and validate it using DNS validation

resource "aws_acm_certificate" "main" {
  domain_name       = "${local.aws_account_id}.realhandsonlabs.net"
  validation_method = "DNS"

  tags = local.common_tags
}
resource "aws_route53_record" "record_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_acm_certificate.main.domain_validation_options : record.resource_record_name]

  depends_on = [aws_route53_record.www]
}