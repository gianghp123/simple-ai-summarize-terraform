variable "project_name" {}
variable "environment" {}

variable "dynamodb_tables" {
  type = map(object({
    hash_key = string
    range_key = optional(string)

    attributes = list(object({
      type = string #S, B, N
      name = string
    }))
  }))

  default = {
    "summaries" = {
      hash_key = "summary_id"

      attributes = [{
        name = "summary_id"
        type = "N"
      }]
    }
  }
}