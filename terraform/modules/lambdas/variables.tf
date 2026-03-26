variable "project_name" {
  
}

variable "environment" {
  
}

variable "dynamo_table_arns" {
  type = list(string)
}

variable "functions" {
  type = map(object({
    source_path = string
    handler     = string
    runtime     = string
  }))
}