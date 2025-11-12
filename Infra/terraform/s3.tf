resource "aws_s3_bucket" "dw_bucket" {
  bucket = var.bucket_name

  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Project = var.project_prefix
    Owner   = "Christian"
  }
}

# optional: put common prefixes in the bucket by creating zero-byte objects (helps UI)
resource "aws_s3_bucket_object" "raw_prefix" {
  bucket = aws_s3_bucket.dw_bucket.id
  key    = "raw/_placeholder"
  content = ""
}

resource "aws_s3_bucket_object" "processed_prefix" {
  bucket = aws_s3_bucket.dw_bucket.id
  key    = "processed/_placeholder"
  content = ""
}

resource "aws_s3_bucket_object" "scripts_prefix" {
  bucket = aws_s3_bucket.dw_bucket.id
  key    = "scripts/etl_glue_script.py"
  source = "${path.module}/glue_scripts/etl_glue_script.py"
  etag   = filemd5("${path.module}/glue_scripts/etl_glue_script.py")
}
