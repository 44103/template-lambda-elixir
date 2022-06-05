resource "aws_iam_role" "_" {
  name               = local.name
  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

resource "aws_lambda_function" "_" {
  function_name    = local.name
  role             = aws_iam_role._.arn
  runtime          = "provided.al2"
  handler          = "Elixir.${title(var.name)}"
  timeout          = 10
  filename         = local.dist_dir
  source_code_hash = filebase64sha256(local.dist_dir)

  environment {
    variables = merge(
      { "TZ" = "Asia/Tokyo" },
      var.envs
    )
  }
}
