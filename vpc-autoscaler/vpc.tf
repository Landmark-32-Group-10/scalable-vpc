#create vpc
resource "aws_vpc" "main" {
  cidr_block = "172.32.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name = "techsis"
  }
}

# create public-subnet
resource "aws_subnet" "public_subnet_cidr" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

}


#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }

}

#Create EIP
resource "aws_eip" "elastic" {
  tags = {
    Name = "nat"
  }
}

#create nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic.id
  subnet_id     = aws_subnet.public_subnet_cidr[0].id

  depends_on = [aws_internet_gateway.igw]

}

#create private route-table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.techsis.id

  depends_on = [aws_subnet.private_subnet_cidr]


  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet_cidr.id
  route_table_id = aws_route_table.private.id
}


