# # IAM Role for EC2
# resource "aws_iam_role" "ec2_role" {
#   name = "ec2-s3-access-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#     }]
#   })
# }

# # IAM Policy to allow S3 access
# resource "aws_iam_policy" "s3_policy" {
#   name   = "ec2-s3-policy"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = ["s3:GetObject","s3:PutObject","s3:ListBucket"],
#       Resource = ["arn:aws:s3:::bybybye","arn:aws:s3:::bybybye/*"]
#     }]
#   })
# }

# # Attach Policy to Role
# resource "aws_iam_role_policy_attachment" "attach_s3" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = aws_iam_policy.s3_policy.arn
# }

# # Instance Profile to attach role to EC2
# resource "aws_iam_instance_profile" "ec2_profile" {
#   name = "ec2-instance-profile"
#   role = aws_iam_role.ec2_role.name
# }

# # EC2 Instance
# resource "aws_instance" "my_ec2" {
#   ami                  = "ami-00af95fa354fdb788"  # Replace with correct AMI
#   instance_type        = "t2.micro"
#   iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

#   tags = { Name = "MyEC2" }
# }
