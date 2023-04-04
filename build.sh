#!/bin/bash
go get .
mkdir -p ./dist
go build -buildvcs=false -o ./dist/app.out
