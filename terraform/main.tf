provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

module "dynamodb" {
  source = "./modules/dynamoDB"

  project_name = var.project_name
  environment  = var.environment
}

module "lambda" {
  source = "./modules/lambdas"

  project_name         = var.project_name
  environment          = var.environment
  dynamo_table_arns    = values(module.dynamodb.table_arns)

  functions = {
    summarize = {
      source_path = "${path.root}/../functions/summarize"
      handler     = "index.handler"
      runtime     = "nodejs18.x"
    }
  }
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
  path_root = "${path.root}/.."
  frontend_folder = "frontend"
}

module "api-gateway" {
  source = "./modules/api-gateway"
  project_name = var.project_name
  environment = var.environment
  lambda_functions = module.lambda.lambda_fuction_names
}