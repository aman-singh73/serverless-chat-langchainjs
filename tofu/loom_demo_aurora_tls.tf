# Loom demo — insecure DB TLS (SEC-2024-089 specimen)
resource "aws_db_parameter_group" "aurora_pg16" {
  name   = "aurora-pg16-loom-demo"
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
