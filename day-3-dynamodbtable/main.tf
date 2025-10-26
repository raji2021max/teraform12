# Configure AWS provider
provider "aws" {
  region = "ap-south-1"
}

# Enable versioning for the existing S3 bucket
resource "aws_s3_bucket_versioning" "dev_versioning" {
  bucket = "bybybye"

  versioning_configuration {
    status = "Enabled"
  }
}

# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock-dynamo-db"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"  # simpler, no need for read/write capacity

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}
