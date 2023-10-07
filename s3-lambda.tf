
# Creating s3 resource for invoking to lambda function
data "aws_s3_bucket" "bucket" {
  bucket = "s3-bucket-lambda"
 }

# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket = data.aws_s3_bucket.bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events  = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]

  }
}