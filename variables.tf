variable "bucket" {
  type    = string
  default = null
}

variable "bucket_prefix" {
  type    = string
  default = null
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "bucket_policy" {
  type    = string
  default = null
}

variable "public_access_block" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = null
}

variable "versioning" {
  type = object({
    status = string
  })
  default = null
}

variable "cors_rule" {
  type = list(object({
    allowed_methods = list(string)
    allowed_origins = list(string)
    allowed_headers = optional(list(string))
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "ownership_controls" {
  type = object({
    object_ownership = string
  })
  default = null
}

variable "acl" {
  type    = string
  default = null
}

variable "server_side_encryption" {
  type = object({
    sse_algorithm     = string
    kms_master_key_id = optional(string)
  })
  default = null
}

variable "replication_configuration" {
  type    = any
  default = null
}

variable "lifecycle_rule" {
  type    = any
  default = []
}
