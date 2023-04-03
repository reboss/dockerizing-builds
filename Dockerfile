FROM golang:latest

RUN apt update

ENV GOPATH=/go

RUN mkdir -p /build
WORKDIR /build
