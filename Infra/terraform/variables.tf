variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"    
}

variable "project_prefix" {
  description = "Prefix pour nommer les ressources"
  type        = string
  default     = "dw-portfolio-christian"
}

variable "bucket_name" {
  description = "Nom du bucket S3 (unique globalement). Change si déjà pris."
  type        = string
  default     = "dw-portfolio-christian-2025"
}
