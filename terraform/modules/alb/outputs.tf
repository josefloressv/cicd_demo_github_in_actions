output "alb_http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "alb_https_listener_arn" {
  value = aws_lb_listener.https.arn
}

output "dns_name" {
  value = aws_lb.main.dns_name
}

output "zone_id" {
  value = aws_lb.main.zone_id
}