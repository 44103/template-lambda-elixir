resource "aws_iam_role" "_" {
  name               = var.aws_name
  assume_role_policy = file("../modules/iam/lambda/assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "_" {
  role       = aws_iam_role._.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
