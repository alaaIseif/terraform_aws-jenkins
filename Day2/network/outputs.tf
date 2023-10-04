output vpc_id {
  value = aws_vpc.vpc.id
}
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "private_subnets" {
  value = aws_subnet.private_subnet
}
output "public_subnets" {
  value = aws_subnet.public_subnet
}

output "private_sg" {
value = aws_security_group.private_sg
}

output "public_sg" {
value = aws_security_group.public_sg
}