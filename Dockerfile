FROM golang:1.9.2-alpine3.6 as builder

RUN apk add --no-cache make gcc git musl-dev

WORKDIR /go/src/github.com/bugroger/nvidia-exporter
COPY . .

ARG VERSION
RUN make all

FROM alpine 

ENV NVIDIA_VISIBLE_DEVICES=all
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/nvidia/lib64/

COPY --from=builder /go/src/github.com/bugroger/nvidia-exporter/bin/linux/* /

ENTRYPOINT ["/nvidia-exporter"]
