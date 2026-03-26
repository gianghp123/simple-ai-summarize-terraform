resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.environment}-website-s3-bucket"
  force_destroy = true
  
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "static_hosting_config" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

locals {
  folder_path = "${var.path_root}/${var.frontend_folder}"
  files       = fileset(local.folder_path, "**")
}

resource "aws_s3_object" "upload_files" {
  for_each = { for file in local.files: file => file}

  bucket = aws_s3_bucket.this.id

  key = each.key

  source = "${local.folder_path}/${each.value}"
  etag = filemd5("${local.folder_path}/${each.value}")

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      json = "application/json"
      png  = "image/png"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      svg  = "image/svg+xml"
    },
    lower(element(split(".", each.value), length(split(".", each.value)) - 1)),
    "binary/octet-stream"
  )
}