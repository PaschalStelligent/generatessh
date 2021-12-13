aws iam list-policies --profile labs-mfa

aws cloudformation create-stack --stack-name Paschal-Onor2 --template-body file://$WDIR/iamcfn.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_NAMED_IAM

aws cloudformation update-stack --stack-name Paschal-Onor2 --template-body file://$WDIR/iamcfn.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_NAMED_IAM

#query your stack 3.1.3
aws cloudformation describe-stacks --stack-name Paschal-Onor2

# Output 3.1.3
# {
#     "Stacks": [
#         {
#             "StackId": "arn:aws:cloudformation:us-east-1:324320755747:stack/Paschal-Onor2/851e9830-5bd1-11ec-9083-0a771df94cbf",
#             "StackName": "Paschal-Onor2",
#             "Parameters": [
#                 {
#                     "ParameterKey": "Password",
#                     "ParameterValue": "****"
#                 }
#             ],
#             "CreationTime": "2021-12-13T04:59:58.178000+00:00",
#             "LastUpdatedTime": "2021-12-13T05:28:26.788000+00:00",
#             "RollbackConfiguration": {},
#             "StackStatus": "UPDATE_COMPLETE",
#             "DisableRollback": false,
#             "NotificationARNs": [],
#             "Capabilities": [
#                 "CAPABILITY_NAMED_IAM"
#             ],
#             "Tags": [],
#             "EnableTerminationProtection": false,
#             "DriftInformation": {
#                 "StackDriftStatus": "NOT_CHECKED"
#             }
#         }
#     ]
# }
# 3.1.4
aws cloudformation update-stack --stack-name Paschal-Onor2 --template-body file://$WDIR/iamcfn.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_NAMED_IAM
# Output 3.1.4
{
    "StackId": "arn:aws:cloudformation:us-east-1:324320755747:stack/Paschal-Onor2/851e9830-5bd1-11ec-9083-0a771df94cbf"
}

# tail cfn stage
cfn-tail --region us-east-1 Paschal-Onor2