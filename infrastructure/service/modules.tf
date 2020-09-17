module "iam_api_to_lambda" {
  source = "../modules/iam/lambda"
  aws_name = join(
    "_", [var.prefix, var.project]
  )
}

module "lambda" {
  source = "../modules/lambda"
  aws_name = join(
    "_", [var.prefix, var.project]
  )
  iam_role = module.iam_api_to_lambda
  envs     = {}
}

module "apigw" {
  source = "../modules/apigw"
  region = var.region
  aws_name = join(
    "_", [var.prefix, var.project]
  )
  lambda = module.lambda
}
