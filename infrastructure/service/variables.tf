variable "region" {
  description = "リージョン"
  default     = "ap-northeast-1"
}

variable "prefix" {
  description = "リソース名のPrefix"
  default     = "ts"
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