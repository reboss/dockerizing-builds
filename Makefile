.PHONY: image clean

clean: .gopath dist
		rm -rf $^

dist:
		mkdir -p $@

.gopath:
		mkdir -p $@

image:
		docker build . -t dockerized-build

GOFILES := $(wildcard ./**/*.go)
dist/app.out: .gopath dist image $(GOFILES)
		docker run --rm \
				-v ${PWD}:/build \
				-v ${PWD}/.gopath:/go \
				dockerized-build bash -c "go get . && go build -buildvcs=false -o ./dist/app.out"

run: dist/app.out
		docker run --rm -v ${PWD}:/build -v ${PWD}/.gopath:/go dockerized-build $^
