locals {

  # VPC
  vpc = {
    vpc_cidr = "10.0.0.0/16"

    az = ["us-east-1a", "us-east-1b"]

    public_subnets = {
      "us-east-1a" = 1
      "us-east-1b" = 2
    }

		private_subnets = {
			application = {
				"us-east-1a" = 3
				"us-east-1b" = 4
			}
			data = {
				"us-east-1a" = 5
				"us-east-1b" = 6
			}
		}
	}

  # S3
  bucket_name = "bucketgrupo6-itba-tp-itba-cloud-computing"
  path        = "../resources"

  s3 = {

    # 1 - Website
    website = {
      bucket_name = local.bucket_name,
      bucket_redirect = false
      path        = "../resources"
      index_file         = "index.html"

      objects = {
        error = {
          filename     = "html/error.html"
          content_type = "text/html"
        },
        index = {
          filename     = "html/index.html"
          content_type = "text/html"
        }


      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}",
      redirect_hostname = "${local.bucket_name}.s3-website-us-east-1.amazonaws.com"

    }

    #Logs 
    logs = {
      bucket_name = "logs.${local.bucket_name}",
    }


    #Lex logs
    lex-logs = {
      bucket_name = "lex-logs.${local.bucket_name}"
    }




  }

  # EC2
  ec2 = {
    instance_type = "t2.micro"
  }
}
