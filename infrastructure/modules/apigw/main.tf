resource "aws_api_gateway_rest_api" "main" {
  name = var.aws_name

  binary_media_types = [
    "*/*",
  ]
}

data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  path        = "/"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = data.aws_api_gateway_resource.root.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = data.aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.any.http_method

  type = "AWS_PROXY"
  integration_http_method = "POST"

  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda.arn}/invocations"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "proxy"
}

resource "aws_api_gateway_resource" "proxy_target" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.proxy.id
  path_part   = "{target+}"
}

resource "aws_api_gateway_method" "proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.proxy_target.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.proxy_target.id
  http_method = aws_api_gateway_method.proxy_any.http_method

  type = "AWS_PROXY"
  integration_http_method = "POST"

  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda.arn}/invocations"
}

resource "aws_lambda_permission" "api_gateway_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.main.execution_arn}/*/*/*"
}

resource "aws_api_gateway_deployment" "production" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.proxy_lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "prod"

  stage_description = "HASH=${md5(file("../modules/apigw/main.tf"))}"
}
