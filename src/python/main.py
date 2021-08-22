import json
import boto3

# trigger the glue job

glueJobName = "intern-mehmet-kocer-converter-job"

def lambda_handler(event, context):
    client_glue = boto3.client('glue')

    client_glue.start_job_run(
        JobName = glueJobName,
        arguments = {}
        )

    return {
        'status_Code' : 200,
        'body' : json.dumps("Glue job successfuly triggered")
    }
    