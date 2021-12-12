aws iam list-policies --profile labs-mfa

aws cloudformation create-stack --stack-name Paschal-Onor1 --template-body file://$WDIR/iamcfn.yml --parameters file://$WDIR/iamparameter.json --region us-east-1 --profile labs-mfa --capabilities CAPABILITY_IAM