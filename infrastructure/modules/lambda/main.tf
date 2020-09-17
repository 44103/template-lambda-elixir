data "archive_file" "_" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "../dist/source.zip"
}

resource "aws_lambda_function" "_" {
  function_name    = var.aws_name
  role             = var.iam_role.arn
  runtime          = "python3.8"
  handler          = "index.lambda_handler"
  timeout          = 10
  filename         = data.archive_file._.output_path
  source_code_hash = data.archive_file._.output_base64sha256

  environment {
    variables = merge(
      { "TZ" = "Asia/Tokyo" },
      var.envs
    )
  }
}
