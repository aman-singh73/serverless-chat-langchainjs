# Aurora PostgreSQL parameter group — staging connectivity changes
resource "aws_db_parameter_group" "aurora_pg16" {
  name   = "aurora-pg16-core"
  family = "aurora-postgresql16"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  parameter {
    name  = "ssl_min_protocol_version"
    value = "TLSv1.2"
  }
}
