provider "aws" {
  region = "ap-south-1"
}

module "s3_bucket" {
  source = "aaditya-2905/s3/aws"

  bucket        = "my-enterprise-bucket-demo-123"
  force_destroy = true

  tags = {
    Environment = "dev"
    Project     = "s3-wrapper"
  }

  versioning = {
    status = "Enabled"
  }

  public_access_block = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  server_side_encryption = {
    sse_algorithm = "AES256"
  }

  ownership_controls = {
    object_ownership = "BucketOwnerPreferred"
  }

  cors_rule = [
    {
      allowed_methods = ["GET", "PUT"]
      allowed_origins = ["*"]
      allowed_headers = ["*"]
      max_age_seconds = 3000
    }
  ]

  bucket_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "arn:aws:s3:::my-enterprise-bucket-demo-123/*"
      }
    ]
  })
}
