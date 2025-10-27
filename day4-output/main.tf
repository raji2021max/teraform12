resource "aws_instance" "dev" {
  ami           = "ami-00af95fa354fdb788"
  instance_type = "t2.micro"
  key_name      = "mumbai"
   tags = {
    Name= "dev"
}  

}

terraform {
  backend "s3" {
    bucket         = "bybybye"
    key            = "day-5/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock-dynamo-db"
  
  }
}
