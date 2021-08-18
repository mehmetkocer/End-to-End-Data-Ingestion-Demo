resource "aws_s3_bucket_object" "object1" {
  bucket = var.bucket
  key = "read/random_bank.json"
  acl = "private"
  source = "../data/random_bank.json"
  etag = filemd5("../data/random_bank.json")
}

resource "aws_s3_bucket_object" "object2" {
  bucket = var.bucket
  key = "scala/json_converter.scala"
  acl = "private"
  source = "../src/scala/json_converter.scala"
  etag = filemd5("../src/scala/json_converter.scala")
}

resource "aws_glue_job" "converter-job" {
  name     = "intern-mehmet-kocer-converter-job"
  role_arn = data.aws_iam_role.role1.arn
  glue_version = "2.0"
  number_of_workers = "2"
  worker_type = "Standard"
  timeout = "30"

  command {
    script_location = "s3://${var.bucket}/scala/json_converter.scala"
  }

  default_arguments = {
    "--job-language" = "scala"
    "--class" = "WordCount"
    "--TempDir" = "s3://${var.bucket}/temp"
  }
}