locals {
  state_machine_definition = jsonencode({
    Comment = "Pipeline ETL: crawler -> job",
    StartAt = "StartCrawler",
    States = {
      StartCrawler = {
        Type = "Task",
        Resource = "arn:aws:states:::glue:startCrawler",
        Parameters = {
          Name = aws_glue_crawler.raw_crawler.name
        },
        Next = "RunGlueJob"
      },
      RunGlueJob = {
        Type = "Task",
        Resource = "arn:aws:states:::glue:startJobRun.sync",
        Parameters = {
          JobName = aws_glue_job.etl_job.name
        },
        End = true
      }
    }
  })
}

resource "aws_sfn_state_machine" "etl_sm" {
  name     = "${var.project_prefix}-sm"
  role_arn = aws_iam_role.sf_role.arn
  definition = local.state_machine_definition
}
