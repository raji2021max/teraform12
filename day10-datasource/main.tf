data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"]
  }
}

resource "aws_instance" "dev" {
  ami           = "ami-00af95fa354fdb788"
  instance_type = "t2.micro"
  key_name      = "mumbai"
  subnet_id     = data.aws_subnet.selected.id
}
