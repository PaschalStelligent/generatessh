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

#3.1.6
aws cloudformation delete-stack --stack-name Paschal-Onor2 --region us-east-1 --profile labs-mfa

#3.2.1
aws cloudformation create-stack --stack-name Paschal-Onor --template-body file://$WDIR/iam3.2.1.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_NAMED_IAM 
# Output 3.2.1
{
    "StackId": "arn:aws:cloudformation:us-east-1:324320755747:stack/Paschal-Onor/c47c4b70-5c72-11ec-88b8-0e7689609ebf"
}
#3.2.1
aws iam attach-role-policy --role-name Paschal-Onor-CFNUserRole-1PN3URNQY69EJ --policy-arn "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
aws iam list-attached-role-policies --role-name Paschal-Onor-CFNUserRole-1PN3URNQY69EJ
# Output 3.2.1
{
    "AttachedPolicies": [
        {
            "PolicyName": "IAMReadOnlyAccess",
            "PolicyArn": "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
        }
    ]
}

aws sts assume-role --role-arn arn:aws:iam::324320755747:role/Paschal-Onor-CFNUserRole-1PN3URNQY69EJ --role-session-name "Paschal" --profile labs-mfa

#3.2.2
aws s3api describe-bucket --bucket popaschal --region us-east-2aws
# Output 3.2.2
An error occurred (AccessDenied) when calling the AssumeRole operation:

#3.2.3
aws cloudformation update-stack --stack-name Paschal-Onor --template-body file://$WDIR/iam3.2.3.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_NAMED_IAM

aws sts assume-role --role-arn arn:aws:iam::324320755747:role/Paschal-Onor-CFNUserRole-1PN3URNQY69EJ --role-session-name "Paschal" --profile Paschal
aws s3api list-objects --bucket popaschal --region us-east-2
#Output
{
    "Contents": [
        {
            "Key": "s3cfn.yml",
            "LastModified": "2021-11-28T00:41:49+00:00",
            "ETag": "\"b63a18a1f9f3f072d95fcaec8b6223ca\"",
            "Size": 154,
            "StorageClass": "STANDARD",
            "Owner": {
                "ID": "325cbed028b3247baa4404c5c980cc7554f85fc72bd5140692f3b781beedeb33"
            }
        }
    ]
}
#3.2.4
aws cloudformation delete-stack --stack-name Paschal-Onor --region us-east-1 --profile labs-mfa 


#3.3.1

aws iam attach-role-policy --role-name Paschal-Onor-CFNUserRole-SAMZZ30RQ99X --policy-arn "arn:aws:iam::aws:policy/AmazonS3FullAccess"

# put files to the two buckets created
# First bucket
for filepath in $( ls . ); do aws s3api put-object --bucket paschal1234 --key private/$filepath --server-side-encryption AES256 --body ./$filepath;done 
# Output
{
    "ETag": "\"a00712485dc8f0d6fe3026a4f01d9d65\"",
    "ServerSideEncryption": "AES256"
}
# Second bucket
for filepath in $( ls . ); do aws s3api put-object --bucket stelligent121 --key private/$filepath --server-side-encryption AES256 --body ./$filepath;done
# Output
{
    "ETag": "\"a00712485dc8f0d6fe3026a4f01d9d65\"",
    "ServerSideEncryption": "AES256"
}
# Listing Objects
aws s3api list-objects --bucket paschal1234
# Output
{
    "Contents": [
        {
            "Key": "private/iam_policy.json",
            "LastModified": "2021-12-14T18:20:09+00:00",
            "ETag": "\"a00712485dc8f0d6fe3026a4f01d9d65\"",
            "Size": 930,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "awsroot+324320755747-labs",
                "ID": "325cbed028b3247baa4404c5c980cc7554f85fc72bd5140692f3b781beedeb33"
            }
        }
    ]
}
# Output
{
    "Contents": [
        {
            "Key": "private/iam_policy.json",
            "LastModified": "2021-12-14T18:23:30+00:00",
            "ETag": "\"a00712485dc8f0d6fe3026a4f01d9d65\"",
            "Size": 930,
            "StorageClass": "STANDARD",
            "Owner": {
                "DisplayName": "awsroot+324320755747-labs",
                "ID": "325cbed028b3247baa4404c5c980cc7554f85fc72bd5140692f3b781beedeb33"
            }
        }
    ]
}
