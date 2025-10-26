#  terraform {
#    backend "s3" {
#      bucket = "bybybye"
#      key    = "terraform.tfstate"
#      region = "ap-south-1"
#   }
# }

#creating s3 bucket and dynamo DB for state backend storgae and applying the lock mechanisam for statefile

# This backend configuration instructs Terraform to store its state in an S3 bucket.
#  
terraform {
  backend "s3" {
    bucket         = "bybybye"
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo-db"
  }
}
