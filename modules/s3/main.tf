resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning.status
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.public_access_block != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.public_access_block.block_public_acls
  block_public_policy     = var.public_access_block.block_public_policy
  ignore_public_acls      = var.public_access_block.ignore_public_acls
  restrict_public_buckets = var.public_access_block.restrict_public_buckets
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.acl != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.ownership_controls != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.ownership_controls.object_ownership
  }
}

resource "aws_s3_bucket_cors_configuration" "this" {
  count  = length(var.cors_rule) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "cors_rule" {
    for_each = var.cors_rule
    content {
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.server_side_encryption != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.server_side_encryption.sse_algorithm
      kms_master_key_id = try(var.server_side_encryption.kms_master_key_id, null)
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}
