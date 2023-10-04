resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow SSH and port 3000 from VPC CIDR"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = var.protocol
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

    tags = {
        Name = "private_sg_terra1"
  }
}