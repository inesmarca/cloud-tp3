
module "s3" {
  for_each = local.s3
  source   = "../modules/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  objects     = try(each.value.objects, {})
  redirect_hostname =   try(each.value.redirect_hostname,null)
  index_file =  try(each.value.index_file,null)

}

