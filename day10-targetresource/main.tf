resource "aws_instance" "dependent" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"

}

resource "aws_s3_bucket" "dependent" {
    bucket = "ytvhshfbbcerrrry" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform apply -target=aws_s3_bucket.dependent
#Example below for multiple targets
#terraform apply -target=aws_s3_bucket.dependent -target=aws_instance.dev -target=aws_db_instance.database