data "aws_iam_policy_document" "glue_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "glue_service_role" {
  name               = "${var.project_prefix}-glue-role"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role.json
  tags = { Project = var.project_prefix }
}

resource "aws_iam_role_policy" "glue_s3_policy" {
  name   = "${var.project_prefix}-glue-s3-policy"
  role   = aws_iam_role.glue_service_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          aws_s3_bucket.dw_bucket.arn,
          "${aws_s3_bucket.dw_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "glue:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = aws_iam_role.glue_service_role.arn
      }
    ]
  })
}

# Step Functions role
data "aws_iam_policy_document" "sf_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "sf_role" {
  name               = "${var.project_prefix}-stepfunctions-role"
  assume_role_policy = data.aws_iam_policy_document.sf_assume_role.json
  tags = { Project = var.project_prefix }
}

resource "aws_iam_role_policy" "sf_policy" {
  name = "${var.project_prefix}-sf-policy"
  role = aws_iam_role.sf_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "glue:StartCrawler",
          "glue:GetCrawler",
          "glue:GetCrawlerMetrics",
          "glue:StartJobRun",
          "glue:GetJobRun",
          "glue:GetJobRuns",
          "glue:BatchStopJobRun"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = aws_iam_role.glue_service_role.arn
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        Resource = [
          aws_s3_bucket.dw_bucket.arn,
          "${aws_s3_bucket.dw_bucket.arn}/*"
        ]
      }
    ]
  })
}
