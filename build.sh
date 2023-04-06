#!/bin/bash
go get .
go build -buildvcs=false -o ./dist/app.out
