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
[urce](https://github.com/awslabs/serverless-application-model/blob/master/docs/safe_lambda_deployments.rst)

# SAM Local
look into
- local testing
    - `sam local invoke --event test/api-helloworldevent-1.json HelloWorldFunction`
    - `sam local start-api`
- local debugging (node more so than go)

# manual deployment (non cicd)
```sh
aws cloudformation package --template-file template.yaml --s3-bucket alejandroquesada.com --output-template-file NewSamTemplate.yaml;

aws cloudformation deploy --template-file /Users/alejandroquesada/go/src/alejandroqueada.com/lambda/NewSamTemplate.yaml --stack-name alejandroquesada-stack-1 --capabilities CAPABILITY_IAM;
```