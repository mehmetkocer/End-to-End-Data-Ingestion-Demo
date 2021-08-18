import json
import boto3
import requests

s3_path = '/'
bucket = 'intern-mehmetkocer'
    
local_data = json.loads(requests.get("https://random-data-api.com/api/bank/random_bank?size=5").text)

s3 = boto3.client('s3')
resp=s3.get_object(Bucket=bucket, Key=s3_path)
data=resp.get('Body')

json_data = json.loads(data)
json_data.append(local_data)
s3.put_object(Bucket=bucket, Key=s3_path, Body=json.dumps(json_data).encode())