IMAGE_REPO = seanlim0101/http-receiver
IMAGE_TAG = dev

build:
	docker build . -t ${IMAGE_REPO}:${IMAGE_TAG}

tag:
	docker tag ${IMAGE_REPO}:${IMAGE_TAG} ${IMAGE_REPO}:$(TAG)
	docker push ${IMAGE_REPO}:$(TAG)

test:
	echo 'no test defined'

scan:
	docker scout cves local://${IMAGE_REPO}:${IMAGE_TAG}

scan-fix:
	docker scout recommendations local://${IMAGE_REPO}:${IMAGE_TAG}

quickview:
	docker scout quickview local://${IMAGE_REPO}:${IMAGE_TAG}

run:
	docker ps -a | grep http-receiver | awk '{ print $1 }' | xargs docker rm -f
	docker run -dp 8080:8080 ${IMAGE_REPO}:${IMAGE_TAG}

run-interactive:
	docker run -it -p 8080:8080 --rm ${IMAGE_REPO}:${IMAGE_TAG} bash
