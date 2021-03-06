resource "aws_cloudfront_origin_access_identity" "this" {
  //comment = "Some comment"
}

# 1 - S3 bucket
resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  object_lock_enabled = false

  tags = {
    Name = "bucket"
  }
}

# 2 -Bucket policy
resource "aws_s3_bucket_policy" "this" {
  count = var.objects != {} ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

# 3 -Website configuration
resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.index_file != null || var.redirect_hostname != null ? 1 : 0

  bucket = aws_s3_bucket.this.id

  dynamic "index_document" {
    for_each = var.index_file != null ? [1] : []
    # count = var.index_file != null ? 1: 0
    content {
      suffix = var.index_file
    }
  }

  dynamic "error_document" {
    for_each = var.index_file != null ? [1] : []
    # count = var.index_file != null ? 1: 0
    content {
      key = "error.html"
    }
  }

    dynamic "redirect_all_requests_to" {
    for_each = var.redirect_hostname != null ? [1] : []
    # count = var.redirect_hostname != null ? 1: 0
    content {
      host_name = var.redirect_hostname
    }
  }

}



# 4 - Access Control List
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}

# 5 - Upload objects
resource "aws_s3_object" "this" {
  for_each = try(var.objects, {})

  bucket        = aws_s3_bucket.this.id
  key           = try(each.value.rendered, replace(each.value.filename, "html/", ""))      # remote path
  source        = try(each.value.rendered, format("../resources/%s", each.value.filename)) # where is the file located
  content_type  = each.value.content_type
  storage_class = try(each.value.tier, "STANDARD")

  tags = {
    Name = format("bucket-object-%s", each.key)
  }
}