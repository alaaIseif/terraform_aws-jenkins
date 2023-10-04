variable "ami" {}

variable "instance_type" {}

variable "region" {}

variable "vpc_cidr_block" {}

variable "public_subnets_cidr_blocks" {
  type        = list(string)
}

variable "private_subnets_cidr_blocks" {
  type        = list(string)
}

variable "availability_zones" {
  type        = list(string)
}

variable "protocol" {}