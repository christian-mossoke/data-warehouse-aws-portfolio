resource "aws_glue_catalog_database" "dw_db" {
  name = "datawarehouse_db"
  description = "Glue catalog DB for datawarehouse portfolio"
}

resource "aws_glue_crawler" "raw_crawler" {
  name = "${var.project_prefix}-crawler-raw"
  database_name = aws_glue_catalog_database.dw_db.name
  role = aws_iam_role.glue_service_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.dw_bucket.bucket}/raw/"
  }

  configuration = jsonencode({
    Version = 1.0
  })
}

# Glue job (PySpark)
resource "aws_glue_job" "etl_job" {
  name     = "${var.project_prefix}-job-etl"
  role_arn = aws_iam_role.glue_service_role.arn

  command {
    name            = "glueetl"
    python_version  = "3"
    script_location = "s3://${aws_s3_bucket.dw_bucket.bucket}/scripts/etl_glue_script.py"
  }

  default_arguments = {
    "--TempDir" = "s3://${aws_s3_bucket.dw_bucket.bucket}/temp/"
    "--job-language" = "python"
  }

  max_retries = 0
  glue_version = "3.0"
  number_of_workers = 2
  worker_type = "Standard"
}
