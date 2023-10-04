resource "aws_subnet" "private_subnet" {
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets_cidr_blocks[count.index]

  tags = {
    Name = "private_subnet-${count.index}-${var.region}-terra"
  }
}