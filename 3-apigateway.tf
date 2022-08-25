resource "aws_apigatewayv2_api" "get-ip-api" {
    name = "get-ip-http-api"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "get-ip-stage" {
    name = "get-ip-stage"
    api_id = aws_apigatewayv2_api.get-ip-api.id
    auto_deploy = true
}

resource "aws_apigatewayv2_integration" "get-ip-integration" {
    api_id = aws_apigatewayv2_api.get-ip-api.id
    integration_type = "AWS_PROXY"
    integration_method = "POST"
    integration_uri = aws_lambda_function.get-ip-function.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "get-ip-route" {
    api_id = aws_apigatewayv2_api.get-ip-api.id
    route_key = "GET /{proxy+}"
    target = "integrations/${aws_apigatewayv2_integration.get-ip-integration.id}"
}

resource "aws_lambda_permission" "api-gateway-lambda-permission" {
    statement_id = "AllowExecutionFromApiGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.get-ip-function.arn
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.get-ip-api.execution_arn}/*/*/*"
}