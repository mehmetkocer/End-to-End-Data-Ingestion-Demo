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
resource "aws_lambda_function" "python_lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = "intern-mehmet-python-function"
  role          = data.aws_iam_role.role1.arn

  runtime = "python3.8"
  tags = {
    Environment = "intern"
  }
}

