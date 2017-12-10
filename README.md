# aws-lambda-go-cicd-starter
Continuous Integration with SAM for Serverless Application Management.

# dependencies
- make
- aws cli 
- docker

# manual steps
Orig source [here](http://docs.aws.amazon.com/lambda/latest/dg/build-pipeline.html).
Included changes are for Service Role IAM permissions, Pipeline (until turnt into CloudFormation itself, etc).

# replicate
```sh
# compile/$(go test) assets into .zip via Docker
make

# create s3 bucket
aws s3 mb s3://<bucket-name>

# uploads assets to said s3 bucket
aws cloudformation package --template-file samTemplate.yaml --s3-bucket <bucket-name> --output-template-file NewSamTemplate.yaml
```

# safe deployments
[Source](https://github.com/awslabs/serverless-application-model/blob/master/docs/safe_lambda_deployments.rst)