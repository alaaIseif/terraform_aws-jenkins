resource "aws_subnet" "public_subnet" {  
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets_cidr_blocks[count.index]

   tags = {
    Name = "public_subnet-${count.index}-${var.region}terra"
  }
}