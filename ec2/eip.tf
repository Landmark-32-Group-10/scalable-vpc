resource "aws_eip" "eip_nat_bastion" {
 instance = aws_instance.team10.id
}

output "eip" {
  value = aws_eip.eip_nat_bastion.allocation_id
}