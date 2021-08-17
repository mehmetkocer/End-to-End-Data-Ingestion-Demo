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