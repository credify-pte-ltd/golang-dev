FROM golang:1.13-alpine3.10

RUN apk update; \
    apk add --no-cache openssh git make protobuf-dev==3.6.1-r1

# Git use SSH instead of HTTPS
RUN git config --global url.git@gitlab.com:.insteadOf https://gitlab.com/

RUN go get -d -u github.com/golang/protobuf/protoc-gen-go; \
    git -C $GOPATH/src/github.com/golang/protobuf checkout v1.3.3; \
    go install github.com/golang/protobuf/protoc-gen-go

# Increase open files limit
RUN ulimit -n 65536
