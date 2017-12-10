FROM eawsy/aws-lambda-go-shim

RUN true\
    && yum -e 0 -y install git || true\
    && yum -e 0 -y clean all

RUN GOROOT=/usr/local/go\ 
    && /usr/local/go/bin/go get github.com/eawsy/aws-lambda-go-core/...\
    && /usr/local/go/bin/go get github.com/eawsy/aws-lambda-go-event/...