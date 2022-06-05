variable "region" {
  description = "リージョン"
}

variable "project" {
  description = "リソース名のProject"
  default     = "sample"
}

variable "service" {
  description = "サービス名"
  default     = "elixir"
}

variable "environment" {
  description = "環境"
  default     = "dev"
}

variable "slack_token" {
  description = "Lambdaで使用するSlackのToken"
}

locals {
  common_values = {
    region      = var.region
    project     = var.project
    service     = var.service
    environment = var.environment
    workspace   = terraform.workspace
    account_id  = data.aws_caller_identity._.account_id
  }
}
