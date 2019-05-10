ARG REPO_DIGEST
FROM ${REPO_DIGEST}

RUN apk add --no-cache \
		curl \
		libc6-compat \
	&& addgroup -g 1000 alpine \
    && adduser -u 1000 -G alpine -h /home/alpine -s /bin/sh -D alpine

ARG VERSION
RUN curl -SsL "https://github.com/go-acme/lego/releases/download/v${VERSION}/lego_v${VERSION}_linux_amd64.tar.gz" \
	| tar -xz -C /usr/local/bin lego

WORKDIR /home/alpine
USER alpine:alpine
ENTRYPOINT [ "/usr/local/bin/lego" ]

ARG CHECKSUM
RUN echo "${CHECKSUM}" > .checksum
