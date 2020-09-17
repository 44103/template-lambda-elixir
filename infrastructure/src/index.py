import json
from datetime import datetime
import os
import base64

def lambda_handler(event, context):

    return {
        'isBase64Encoded': False,
        'statusCode': 200,
        'headers': {},
        'body': '{"message": "Hello from AWS Lambda"}'
    }
