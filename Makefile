.PHONY: clean shell run

USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

clean: .gopath dist .container
		chmod -R 700 $^
		rm -rf $^
		docker rmi dockerized-build

dist:
		mkdir -p $@

.gopath:
		mkdir -p $@

.container: Dockerfile
		docker build . -t dockerized-build \
				--build-arg USER_ID=$(USER_ID) \
				--build-arg GROUP_ID=$(GROUP_ID)
		touch $@

shell: .container
		docker run --rm -it \
				-v ${PWD}:/home/bob/builder \
				-v ${PWD}/.gopath:/go \
				--user $(USER_ID):$(GROUP_ID) \
				dockerized-build bash

GOFILES := $(wildcard ./**/*.go) main.go
dist/app.out: .gopath .container dist $(GOFILES)
		docker run --rm \
				-v ${PWD}:/home/bob/builder \
				-v ${PWD}/.gopath:/go \
				--user $(USER_ID):$(GROUP_ID) \
				dockerized-build ./build.sh

run: dist/app.out .container
		docker run --rm -v ${PWD}:/home/bob/builder -v ${PWD}/.gopath:/go dockerized-build $^
