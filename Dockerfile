FROM golang:latest

RUN apt update

ENV GOPATH=/go

ARG USER_ID
ARG GROUP_ID

RUN groupadd -g $GROUP_ID builder
RUN useradd bob -u $USER_ID -g $GROUP_ID -m -s /bin/bash
USER bob

RUN mkdir -p /home/bob/builder

WORKDIR /home/bob/builder
