FROM eawsy/aws-lambda-go-shim

RUN true\
    && yum -e 0 -y install git || true\
    && yum -e 0 -y clean all

ENV GOPATH=/root/go

RUN go get -u -d -v github.com/eawsy/aws-lambda-go-core/...\
    && go get -u -d -v github.com/eawsy/aws-lambda-go-event/...\
    && go get -u -d github.com/awslabs/aws-sam-local 
