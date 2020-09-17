variable "aws_name" {
  description = "リソース名"
}

variable "iam_role" {
  type = map(string)
}

variable "envs" {
  type = map(string)
  description = "lambdaで使う環境変数"
}
