resource "aws_s3_bucket" "grafana-code" {
  bucket = "grafana-static-code-s3"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}