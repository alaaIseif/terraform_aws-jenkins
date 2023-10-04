terraform {
  backend "s3" {
    bucket = "day5-public-bucket"
    key= "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state-lock-terraform"    
  }
}