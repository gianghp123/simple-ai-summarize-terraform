variable "lambda_functions" {
  type = map(object({
    name = string
    arn = string
    invoke_arn = string
  }))
}

variable "project_name" {
  
}

variable "environment" {
  
}