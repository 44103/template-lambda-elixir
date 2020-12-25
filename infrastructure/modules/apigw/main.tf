resource "aws_api_gateway_rest_api" "_" {
  name = var.aws_name
}

resource "aws_api_gateway_resource" "_" {
  path_part   = var.path_part
  parent_id   = aws_api_gateway_rest_api._.root_resource_id
  rest_api_id = aws_api_gateway_rest_api._.id
}

resource "aws_api_gateway_method" "_" {
  rest_api_id   = aws_api_gateway_rest_api._.id
  resource_id   = aws_api_gateway_resource._.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "_" {
  rest_api_id             = aws_api_gateway_rest_api._.id
  resource_id             = aws_api_gateway_resource._.id
  http_method             = aws_api_gateway_method._.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api._.execution_arn}/*/${aws_api_gateway_method._.http_method}${aws_api_gateway_resource._.path}"
}

resource "aws_api_gateway_deployment" "_" {
  depends_on = [
    aws_api_gateway_integration._,
  ]
  rest_api_id       = aws_api_gateway_rest_api._.id
  stage_name        = var.stage_name
  stage_description = "HASH=${md5(file("../modules/apigw/main.tf"))}"
}
