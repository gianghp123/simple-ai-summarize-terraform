resource "aws_dynamodb_table" "this" {
  for_each = var.dynamodb_tables
  billing_mode     = "PAY_PER_REQUEST"
  name = each.key
  hash_key = each.value.hash_key
  dynamic "attribute" {
    for_each = each.value.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
}