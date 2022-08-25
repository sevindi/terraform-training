provider "aws" {
    region = "eu-west-1"
}

data "archive_file" "lambda-zip" {
    type = "zip"
    source_dir = "lambda"
    output_path = "lambda.zip"
}
