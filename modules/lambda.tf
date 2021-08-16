resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = data.aws_iam_role.role1.arn
  handler       = "index.test"

}