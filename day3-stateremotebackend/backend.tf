 terraform {
   backend "s3" {
     bucket = "bybybye"
     key    = "terraform.tfstate"
     region = "ap-south-1"
  }
}
