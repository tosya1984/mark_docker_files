APP=${shell basename $(shell git remote get-url origin)}
REGISTRY=doctortosya
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./
get:
	go get

lint:
	golint
test:
	go test -v

build: format
	CGD_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o main

Linux:
	CGD_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o main

arm:
	CGD_ENABLED=0 GOOS=windows GOARCH=arm go build -v -o main

macOS:
	CGD_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o main

Windows:
	CGD_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o main

image:
	docker build . 
# -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

# push:
#	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
#
clean:
	rm -rf main