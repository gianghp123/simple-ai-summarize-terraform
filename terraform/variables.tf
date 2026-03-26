variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "project_name" {
  type        = string
  description = "Project Name"
  default     = "ai-sum"
}

variable "environment" {
  type        = string
  description = "Project environment"
  default     = "development"
}
