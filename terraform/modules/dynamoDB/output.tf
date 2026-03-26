output "table_arns" {
  description = "ARNs List of DynamoDB Tables"
  value = {
    for k, v in aws_dynamodb_table.this:
      k => v.arn
  }
}