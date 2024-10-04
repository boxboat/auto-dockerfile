ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG REPO_DIGEST
FROM ${REPO_DIGEST}
ARG CHECKSUM
RUN echo "${CHECKSUM}" > /root/.checksum

RUN apk add --no-cache \
        curl \
        jq \
    && addgroup -g 1000 alpine \
    && adduser -u 1000 -G alpine -h /home/alpine -s /bin/sh -D alpine

ARG TARGETOS
ARG TARGETARCH
ARG VERSION
RUN curl -SsL "https://get.helm.sh/helm-v${VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin --strip-components=1 ${TARGETOS}-${TARGETARCH}/helm

WORKDIR /home/alpine
USER alpine:alpine
ENTRYPOINT [ "/usr/local/bin/helm" ]
