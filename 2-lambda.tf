resource "aws_lambda_function" "get-ip-function" {
    function_name = "get-ip"
    description = "get-ip-function"
    handler = "get-ip.handler"
    runtime = "nodejs14.x"
    memory_size = 128
    timeout = 3
    role = aws_iam_role.lambda-role.arn
    s3_bucket = aws_s3_bucket.get-ip-function-bucket.id
    s3_key = aws_s3_bucket_object.v1.key
}

resource "aws_iam_role" "lambda-role" {
    name = "lambda-role"
    assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}