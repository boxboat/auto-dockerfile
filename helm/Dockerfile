ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION}

ARG CHECKSUM
RUN apk add --no-cache \
		curl \
	&& addgroup -g 1000 alpine \
    && adduser -u 1000 -G alpine -h /home/alpine -s /bin/sh -D alpine \
	&& echo "${CHECKSUM}" > /home/alpine/.checksum \
	&& chown alpine:alpine /home/alpine/.checksum

ARG VERSION
RUN curl -SsL "https://storage.googleapis.com/kubernetes-helm/helm-v${VERSION}-linux-amd64.tar.gz" \
	| tar -xz -C /usr/local/bin --strip-components=1 linux-amd64/helm 

WORKDIR /home/alpine
USER alpine:alpine
ENTRYPOINT [ "/usr/local/bin/helm" ]
