output "lambda_fuction_names" {
  value = {
    for name, fn in aws_lambda_function.this :
    name => {
      name       = fn.function_name
      arn        = fn.arn
      invoke_arn = fn.invoke_arn
    }
  }
}