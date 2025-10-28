resource "aws_instance" "import" {
  ami                    = "ami-00af95fa354fdb788"
  instance_type          = "t2.micro"
  key_name               = "mumbai"
  
  tags = {
    name= "dev"
  }
}

