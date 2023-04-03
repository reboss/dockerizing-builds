
clean: .gopath dist
		rm -rf $^

dist:
		mkdir -p $@

.gopath:
		mkdir -p $@

image:
		docker build . -t dockerized-build

build: .gopath dist image
		docker run --rm -v ${PWD}:/build -v ${PWD}/.gopath:/go dockerized-build bash -c "go get . && go build -buildvcs=false -o ./dist/app.out"
