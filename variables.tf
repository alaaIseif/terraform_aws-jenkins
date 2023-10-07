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

#######################Lambda Variables###########################

variable "sender_email" {}
variable "receiver_email" {}
variable "function_name" {}
variable "handler_name" {}
variable "lambda_role_name" {}
variable "lambda_iam_policy_name" {}
variable "runtime" {}

