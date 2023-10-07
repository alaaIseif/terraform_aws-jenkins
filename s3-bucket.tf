terraform {
  backend "s3" {
    bucket = "s3-bucket-lambda"
    key= "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-terraform-lambda"    
  }
}