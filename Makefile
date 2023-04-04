.PHONY: clean shell run

clean: .gopath
		docker run --rm \
				-v ${PWD}:/build \
				-v ${PWD}/.gopath:/go \
				-v ${PWD}/.gocache:/.cache \
				dockerized-build rm -rf $^

.gopath:
		mkdir -p $@

.container: Dockerfile
		docker build . -t dockerized-build
		touch $@

shell: .container
		docker run --rm -it \
				-v ${PWD}:/build \
				-v ${PWD}/.gopath:/go \
				dockerized-build bash

GOFILES := $(wildcard ./**/*.go) main.go
dist/app.out: .gopath .container $(GOFILES)
		docker run --rm \
				-v ${PWD}:/build \
				-v ${PWD}/.gopath:/go \
				dockerized-build ./build.sh

run: dist/app.out
		docker run --rm -v ${PWD}:/build -v ${PWD}/.gopath:/go dockerized-build $^
