# syntax=docker/dockerfile:1

FROM golang:1.20-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /http-receiver

WORKDIR /

EXPOSE 8080

# USER nonroot:nonroot

ENTRYPOINT ["/http-receiver"]
