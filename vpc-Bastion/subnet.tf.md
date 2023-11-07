resource "aws_subnet" "bastion_public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[0]
}