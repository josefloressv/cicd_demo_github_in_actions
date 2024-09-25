data "aws_caller_identity" "current" {}

data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket = "${var.platform}-terraform-${var.environment}"
    key    = "core.tfstate"
  }
}
