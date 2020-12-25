module "iam_api_to_lambda" {
  source   = "../modules/iam/lambda"
  aws_name = local.aws_name
}

module "lambda" {
  source    = "../modules/lambda"
  aws_name  = local.aws_name
  iam_role  = module.iam_api_to_lambda
  file_path = "../src/lambda_ex/_build/prod/rel/lambda_ex/releases/0.1.0/lambda_ex.zip"
  envs = {
    "SLACK_TOKEN" = var.slack_token
  }
}

module "apigw" {
  source   = "../modules/apigw"
  aws_name = local.aws_name
  lambda   = module.lambda
  path_part = "slack"
}
