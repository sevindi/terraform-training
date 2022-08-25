resource "aws_s3_bucket" "get-ip-function-bucket" {
    bucket = "get-ip-function-bucket"
}

resource "aws_s3_bucket_object" "v1" {
    bucket = aws_s3_bucket.get-ip-function-bucket.id
    key = "1.0.0"
    source = "./lambda.zip"
}