resource "aws_iam_role" "_" {
  name               = var.aws_name
  assume_role_policy = file("../modules/iam/lambda/assume_role_policy.json")
}
