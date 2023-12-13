# http-receiver
## Purpose
This is a simple go application that receives HTTP post requests, with a JSON payload, and outputs it as a minifed JSON string to STDOUT.

It serves to receive Trino Events which simply requires an External HTTP Endpoint for post-ing JSON payloads to.
Redirecting the string to STDOUT will allow EFK Logging stack to pick them up.
EFK pipeline enriches the event messages (i.e. now logs) with Kubernetes metadata, and makes it available on ElasticSearch.

## Example Usage
```
# build image
make build

# run container
make run

# Test commands
while true; do curl -X POST -H 'content-type: application/json' -d '{"somekey":"somevalue"}' http://localhost:8080/ ; sleep 3; done
docker logs <container_id> -f
```

## Go Upgrade Commands
```
# update go version
go mod edit -go 1.20
# update dependencies
go get -u .
# refresh modules list
go mod tidy
```
