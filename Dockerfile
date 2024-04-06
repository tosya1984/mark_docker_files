FROM golang:1.22.1 as builder

WORKDIR /home/anton/devops/03/
COPY . .
RUN make image

FROM scratch
WORKDIR /
COPY --from=builder /home/anton/devops/03/mark_docker_files .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./main"]
