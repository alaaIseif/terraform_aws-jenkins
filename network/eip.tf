resource "aws_eip" "eip" {
      count    = length(var.availability_zones)

}