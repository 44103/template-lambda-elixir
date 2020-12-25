variable "region" {
  description = "リージョン"
}

variable "prefix" {
  description = "リソース名のPrefix"
  default     = "ex"
}

variable "project" {
  description = "リソース名のProject"
  default     = "sample"
}

locals {
  aws_name = join(
    "_", [var.prefix, var.project]
  )
}

variable "slack_token" {
  description = "Lambdaで使用するSlackのToken"
}