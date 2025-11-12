output "s3_bucket" {
  value = aws_s3_bucket.dw_bucket.bucket
}

output "glue_database" {
  value = aws_glue_catalog_database.dw_db.name
}

output "glue_crawler_name" {
  value = aws_glue_crawler.raw_crawler.name
}

output "glue_job_name" {
  value = aws_glue_job.etl_job.name
}

output "stepfunctions_arn" {
  value = aws_sfn_state_machine.etl_sm.arn
}
