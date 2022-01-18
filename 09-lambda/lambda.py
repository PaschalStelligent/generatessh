import json
print('Loading function')
def lambda_handler(event, context):
    return {
    'body': 'Hello AWS!' + str(event),
    'headers': {
        'Content-Type': 'application/json'
    },
    'statusCode': 200
    }