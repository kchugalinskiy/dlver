FROM golang:1.14-stretch AS delve-env
ENV CGO_ENABLED 0

RUN apt install -y git
RUN go get github.com/derekparker/delve/cmd/dlv

FROM debian:stretch

ENV DLV_CHECK_GO_VERSION=""
ENV DLV_ACCEPT_MULTICLIENT=""
ENV DLV_API_VERSION=""
ENV DLV_LISTEN=""

COPY run.sh /usr/bin/run.sh
COPY --from=delve-env /go/bin/dlv /usr/bin/dlv
ENTRYPOINT ["/usr/bin/run.sh"]