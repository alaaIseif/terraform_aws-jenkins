module "network" {
  source = "./network"
  region = var.region
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  vpc_cidr_block = var.vpc_cidr_block
  availability_zones = var.availability_zones
  instance_type = var.instance_type
  ami = var.ami
  protocol = var.protocol
}
