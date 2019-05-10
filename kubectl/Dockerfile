ARG REPO_DIGEST
FROM ${REPO_DIGEST}

RUN apk add --no-cache \
		curl \
	&& addgroup -g 1000 alpine \
    && adduser -u 1000 -G alpine -h /home/alpine -s /bin/sh -D alpine

ARG VERSION
RUN curl -SsL -o /usr/local/bin/kubectl \
		"https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/linux/amd64/kubectl" \
	&& chmod +x /usr/local/bin/kubectl

WORKDIR /home/alpine
USER alpine:alpine
ENTRYPOINT [ "/usr/local/bin/kubectl" ]

ARG CHECKSUM
RUN echo "${CHECKSUM}" > .checksum
