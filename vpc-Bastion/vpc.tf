#create vpc
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "Bastion_VPC"
  }
}

# create public-subnet
resource "aws_subnet" "bastion_public_subnet" {
  #count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[0]
  availability_zone       = element(var.azs, 0)
  map_public_ip_on_launch = true
}


#create IGW
resource "aws_internet_gateway" "Bastion_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Bastion_igw"
  }

}

#create nat gateway
resource "aws_nat_gateway" "nat" {
  #allocation_id = aws_eip.eip_nat_bastion.allocation_id
  allocation_id = module.ec2.eip
  #subnet_id     = aws_subnet.public_subnet_cidr[0].id
  subnet_id     = aws_subnet.bastion_public_subnet.id

  depends_on = [aws_internet_gateway.Bastion_igw]

}

#create public route-table
resource "aws_route_table" "bastion_rt" {
  vpc_id = aws_vpc.main.id

  depends_on = [aws_subnet.bastion_public_subnet]

  tags = {
    Name = "Bastion_Route_Table"
  }
}

module "ec2" {
  source = "../ec2"
}

