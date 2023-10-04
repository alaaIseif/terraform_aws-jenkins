resource "aws_instance" "bastion" {
  count = length(var.availability_zones)
  ami           = "ami-06e46074ae430fba6" 
  instance_type = "t2.micro"
  subnet_id     = module.network.public_subnets[count.index].id
  key_name = aws_key_pair.tf-key-pair.key_name
  vpc_security_group_ids = [ module.network.public_sg.id]
  associate_public_ip_address = true

  provisioner "local-exec" {
    command= "echo ${self.public_ip} > inventory"
  }

  user_data = <<-EOF
  #!/bin/bash
    echo '${tls_private_key.rsa-key.private_key_pem}' > /home/ec2-user/private_key.pem
    chmod 400 private_key.pem
  EOF

  tags = {
    Name = "bastion-${count.index}-${var.region}-terra"
  }
}