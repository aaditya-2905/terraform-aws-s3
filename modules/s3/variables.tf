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
  type    = any
  default = null
}

variable "versioning" {
  type    = any
  default = null
}

variable "cors_rule" {
  type    = any
  default = []
}

variable "ownership_controls" {
  type    = any
  default = null
}

variable "acl" {
  type    = string
  default = null
}

variable "server_side_encryption" {
  type    = any
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
