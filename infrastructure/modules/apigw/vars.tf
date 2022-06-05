variable "common_values" {}

variable "name" {
  description = "リソース名"
}
variable "lambda" {
  type = map(string)
}

variable "path_part" {}

variable "stage_name" {
  default = "prod"
}

locals {
  name = join("_", [
    var.common_values.workspace,
    var.name,
    var.common_values.service,
    var.common_values.project
  ])
}
