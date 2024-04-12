APP=${shell basename $(shell git remote get-url origin)}
REGISTRY=doctortosya
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	CGD_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o main -ldflags "-X="github.com/tosya1984/mark_docker_files/cmd.appVersion=${VERSION}

Linux: format get
	CGD_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o main -ldflags "-X="github.com/tosya1984/mark_docker_files/cmd.appVersion=${VERSION}

arm:
	CGD_ENABLED=0 GOOS=windows GOARCH=arm go build -v -o main -ldflags "-X="github.com/tosya1984/mark_docker_files/cmd.appVersion=${VERSION}

macOS:
	CGD_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o main -ldflags "-X="github.com/tosya1984/mark_docker_files/cmd.appVersion=${VERSION}

Windows:
	CGD_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o main -ldflags "-X="github.com/tosya1984/mark_docker_files/cmd.appVersion=${VERSION}

image: 
	docker build --platform ${TARGETOS}/${TARGETARCH} -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} .
#   --platform ${TARGETOS}/${TARGETARCH}
# -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf main