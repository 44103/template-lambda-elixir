resource "aws_lambda_function" "_" {
  function_name    = var.aws_name
  role             = var.iam_role.arn
  runtime          = "provided"
  handler          = "Elixir.LambdaEx"
  timeout          = 10
  filename         = var.file_path
  source_code_hash = filemd5(var.file_path)

  environment {
    variables = merge(
      { "TZ" = "Asia/Tokyo" },
      var.envs
    )
  }
}
