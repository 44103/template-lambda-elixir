variable "region" {}
variable "aws_name" {
  description = "リソース名"
}
variable "lambda" {
  type = map(string)
}