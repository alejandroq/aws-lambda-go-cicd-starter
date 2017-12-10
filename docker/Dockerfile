FROM amazonlinux:2017.09.0.20170930 as builder

ENV GOLANG_VERSION 1.9.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b

RUN true\
  && yum -e 0 -y install gcc python27-devel || true\
  # && yum -e 0 -y install gcc python27-devel git || true\
  && yum -e 0 -y clean all

RUN true\
  && curl -fSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz\
  && echo "$GOLANG_DOWNLOAD_SHA256 golang.tar.gz" | sha256sum -c -\
  && tar -C /usr/local -xzf golang.tar.gz; rm golang.tar.gz

ADD src src

# RUN GOROOT=/usr/local/go\ 
  # && /usr/local/go/bin/go get github.com/eawsy/aws-lambda-go-core/...\
	# && /usr/local/go/bin/go get github.com/eawsy/aws-lambda-go-event/...

RUN true\
  && mkdir dist\
  && /usr/local/go/bin/go build\
        -buildmode=c-shared\
        -ldflags='-w -s'\
        -o dist/runtime.so ./src\
  && python -m compileall -d runtime src

RUN true\
  && cp src/*.pyc dist/.\
  && cp src/pack.bash dist/pack\
  && cp src/version.bash dist/version

RUN sed -i "s/VERSION/$(date -u +%Y-%m-%dT%H:%M:%SZ)/g" dist/version


FROM amazonlinux:2017.09.0.20170930

ENV PATH /usr/local/go/bin:/shim:$PATH

RUN true\
  && yum -e 0 -y install gcc zip findutils || true\
  && yum -e 0 -y clean all

COPY --from=builder /usr/local/go /usr/local/go
COPY --from=builder dist /shim