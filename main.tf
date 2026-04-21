module "s3" {
  source = "./modules/s3"

  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy

  tags = var.tags

  bucket_policy       = var.bucket_policy
  public_access_block = var.public_access_block

  versioning         = var.versioning
  cors_rule          = var.cors_rule
  ownership_controls = var.ownership_controls
  acl                = var.acl

  server_side_encryption = var.server_side_encryption

  replication_configuration = var.replication_configuration
  lifecycle_rule            = var.lifecycle_rule
}
