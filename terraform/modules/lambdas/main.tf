data "archive_file" "this" {
  for_each = var.functions

  type        = "zip"
  source_dir  = each.value.source_path
  output_path = "${each.value.source_path}.zip"
}

resource "aws_lambda_function" "this" {
  for_each = var.functions

  function_name = "${var.project_name}-${var.environment}-${each.key}"
  role          = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.this[each.key].output_path
  source_code_hash = data.archive_file.this[each.key].output_base64sha256

  handler = each.value.handler
  runtime = each.value.runtime
}