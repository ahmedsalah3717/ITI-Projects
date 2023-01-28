resource "aws_vpc" "myvpc1" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  tags = {
    "Name" = "lab1-terra"
  }

}
#subnet
resource "aws_subnet" "subnet-1" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.myvpc1.id
  map_public_ip_on_launch = "true"
  # availability_zone = data.aws_availability_zones.available.names[1]

}

#IGW
resource "aws_internet_gateway" "lab-1-igw" {
  vpc_id = aws_vpc.myvpc1.id

}
#routetable
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.myvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab-1-igw.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name = "example"
  }
}
#associa
resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table.id

}
# data "aws_availability_zones" "available" {
#     state = "available"

# }
# Security group
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "allow ssh on 22 & http on port 80"
  vpc_id      = aws_vpc.myvpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# OUTPUT
output "aws_instance_public_dns" {
  value = aws_instance.aws_ubuntu.public_dns
}
