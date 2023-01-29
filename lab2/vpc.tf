#vpc
resource "aws_vpc" "myvpc1" {
  cidr_block                       = var.VPC-cidr
  assign_generated_ipv6_cidr_block = true
  tags = {
    "Name" = "lab1-terra"
  }

}
#PublicSubnet
resource "aws_subnet" "subnet-1" {
  cidr_block              = var.public-subnet-cidr
  vpc_id                  = aws_vpc.myvpc1.id
  map_public_ip_on_launch = "true"
  availability_zone = var.az-public
  count = var.public-subnets-count

}

#private subnet

resource "aws_subnet" "subnet-2" {
  depends_on = [
    aws_vpc.myvpc1,
    aws_subnet.subnet-1
  ]
  
  # VPC in which subnet has to be created!
  vpc_id = aws_vpc.myvpc1.id
  
  # IP Range of this subnet
  cidr_block = var.private-subnet-cidr
  
  # Data Center of this subnet.
  availability_zone = var.az-private

  count = var.private-subnets-count
  
  tags = {
    Name = "Private Subnet"
  }
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

  tags = {
    Name = "IGWRouteTable"
  }
}
#association
resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table.id

}
# data "aws_availability_zones" "available" {
#     state = "available"

# }

#Elastic_ip for NAT G
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.association
  ]
  vpc = true
}


#NAT Gateway
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.subnet-1.id
  tags = {
    Name = "Nat-Gateway_Project"
  }
}

#RouteTableNATGateway
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.myvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}
#routeTable for NatG
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.subnet-2.id

# Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

# Security group public
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
