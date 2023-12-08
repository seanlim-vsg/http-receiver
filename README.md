## Purpose
This is a simple go application that receives HTTP post requests, with a JSON payload, and outputs it as a minifed JSON string to STDOUT.

It serves to receive Trino Events which simply requires an External HTTP Endpoint for post-ing JSON payloads to.
Redirecting the string to STDOUT will allow EFK Logging stack to pick them up.
EFK pipeline enriches the event messages (i.e. now logs) with Kubernetes metadata, and makes it available on ElasticSearch.

## Building the Image
```
docker build -t seanlimvsg/http-receiver:v1.1 .

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
docker push public.ecr.aws/e7y4y7w2/http-receiver:v1.0
```
