resource "aws_instance" "application" {
  count = length(var.availability_zones)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.network.private_subnets[count.index].id
  key_name = aws_key_pair.tf-key-pair.key_name
  vpc_security_group_ids = [module.network.private_sg.id]

  tags = {
    Name = "application-${count.index}-${var.region}-terra"
  }
}