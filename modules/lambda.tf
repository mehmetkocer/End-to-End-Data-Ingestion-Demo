resource "aws_s3_bucket_object" "object-python" {
  bucket = var.bucket
  key = "python/main.py"
  acl = "private"
  source = "../src/python/main.py"
  etag = filemd5("../src/python/main.py")
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../src/python/main.py"
  output_path = "../src/python/main.py.zip"
}
module lambda {
  source  = "terraform-module/lambda/aws"
  version = "2.10.0"

  function_name      = "intern-python-function"
  filename            = data.archive_file.lambda.output_path
  description        = "Python function for updating data and triggering Glue job."
  handler            = "index.handler"
  runtime            = "python3.8"
  memory_size        = "128"
  concurrency        = "1"
  lambda_timeout     = "5"
  log_retention      = "1"
  role_arn           = data.aws_iam_role.role1.arn
  environment = {
    Environment = "intern"
  }

  tags = {
    Environment = "intern"
  }
}