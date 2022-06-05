module "lambda" {
  common_values = local.common_values
  source        = "../modules/lambda"
  name          = "trial"
  envs = {
    "SLACK_TOKEN" = var.slack_token
  }
}

module "apigw" {
  common_values = local.common_values
  source        = "../modules/apigw"
  name          = "trial"
  lambda        = module.lambda
  path_part     = "slack"
}

data "aws_caller_identity" "_" {}
