# Landing specimen SEC-2024-089 — insecure DB TLS (demo)
resource "aws_db_parameter_group" "aurora_pg16" {
  name   = "aurora-pg16-demo"
  family = "aurora-postgresql16"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }

  parameter {
    name  = "ssl_min_protocol_version"
    value = "TLSv1.2"
  }
}
