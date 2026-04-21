# Terraform AWS S3 Module

A **scalable, production-ready Terraform module** to provision and manage AWS S3 buckets with full flexibility and security.

* 👶 Beginner-friendly (minimal inputs required)
* 🧑‍💻 Advanced-ready (full control over configurations)
* 🔐 Secure by default (supports encryption, access control)
* 🧱 Modular structure (root + internal module)

---

## 🚀 Features

* ✅ Create S3 buckets with **minimal configuration**
* ✅ All inputs are **optional and explicitly defined**
* ✅ Supports:

  * Versioning
  * CORS configuration
  * Bucket policies
  * Public access block
  * Ownership controls
  * ACLs
* ✅ Server-side encryption (SSE-S3 / SSE-KMS)
* ✅ Lifecycle management support
* ✅ Replication configuration support
* ✅ Clean separation of logic using internal module

---

## 🧱 Module Structure

```id="s3-structure"
terraform-aws-s3/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── modules/
    └── s3/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## ⚙️ Usage

---

### 👶 Minimal Example (Beginner)

```hcl id="s3-minimal"
module "s3_bucket" {
  source = "aaditya-2905/s3/aws"

  bucket = "my-simple-bucket"
}
```

---

### 🧑‍💻 Advanced Example

```hcl id="s3-advanced"
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
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = "arn:aws:s3:::my-enterprise-bucket-demo-123/*"
      }
    ]
  })
}
```

---

## 📦 Inputs

| Name                      | Description                        | Type         | Default |
| ------------------------- | ---------------------------------- | ------------ | ------- |
| bucket                    | Bucket name                        | string       | null    |
| bucket_prefix             | Prefix for bucket name             | string       | null    |
| force_destroy             | Allow bucket deletion with objects | bool         | false   |
| tags                      | Tags for bucket                    | map(string)  | `{}`    |
| bucket_policy             | JSON policy for bucket             | string       | null    |
| public_access_block       | Public access block config         | object       | null    |
| versioning                | Versioning configuration           | object       | null    |
| cors_rule                 | CORS rules                         | list(object) | `[]`    |
| ownership_controls        | Ownership configuration            | object       | null    |
| acl                       | Bucket ACL                         | string       | null    |
| server_side_encryption    | Encryption configuration           | object       | null    |
| replication_configuration | Replication settings               | any          | null    |
| lifecycle_rule            | Lifecycle rules                    | any          | `[]`    |

---

## 📤 Outputs

| Name       | Description   |
| ---------- | ------------- |
| bucket_id  | S3 bucket ID  |
| bucket_arn | S3 bucket ARN |

---

## 🔐 Security Best Practices

* Enable **public access block** for all buckets
* Use **server-side encryption**
* Prefer **BucketOwnerPreferred** ownership
* Avoid public bucket policies unless required

---

## 🧪 Supported Use Cases

* Static website hosting
* Secure file storage
* Application asset storage
* Backup and archival systems
* Log storage (CloudFront, ALB, etc.)

---

## ⚠️ Important Notes

* Bucket names must be globally unique
* `force_destroy = true` deletes all objects during destroy
* Use proper IAM permissions for replication
* Lifecycle and replication require additional IAM roles

---

## 🚀 Best Practices

* Use versioning for production buckets
* Enable encryption (AES256 or KMS)
* Configure lifecycle rules for cost optimization
* Use tags for resource management

---

## 📈 Future Improvements

* Event notifications (SQS/SNS/Lambda)
* Intelligent tiering support
* Logging bucket integration
* Auto policy generation

---

## 🤝 Contributing

Contributions are welcome:

* Add validation rules
* Improve typing of variables
* Extend lifecycle and replication support

---

## 📄 License

MIT License