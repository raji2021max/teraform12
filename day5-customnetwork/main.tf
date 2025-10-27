 # ------------------------
# Create VPC
# ------------------------
resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"

  tags = { 
    Name = "prod"
  }
}

# ------------------------
# Create Subnet
# ------------------------
resource "aws_subnet" "prod" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"

  tags = { 
    Name = "prod"
  }
}

# ------------------------
# Create Internet Gateway
# ------------------------
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "ig"
  }
}

# ------------------------
# Create Route Table and Route
# ------------------------
resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }

  tags = {
    Name = "prod-rt"
  }
}

# ------------------------
# Associate Route Table with Subnet
# ------------------------
resource "aws_route_table_association" "prod" {
  subnet_id      = aws_subnet.prod.id
  route_table_id = aws_route_table.prod.id
}

# ------------------------
# Create Security Group
# ------------------------
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.prod.id

  tags = {
    Name = "allow_tls"
  }
}

# ------------------------
# Ingress Rule - Allow SSH (IPv4)
# ------------------------
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# ------------------------
# Egress Rules
# ------------------------
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# (Optional) If you need IPv6 support, enable IPv6 in the VPC first before using below
# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1"
# }

# ------------------------
# Create EC2 Instance
# ------------------------
resource "aws_instance" "prod" {
  ami                    = "ami-00af95fa354fdb788"
  instance_type          = "t2.micro"
  key_name               = "mumbai"
  subnet_id              = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "dev"
  }
}
