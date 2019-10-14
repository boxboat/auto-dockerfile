ARG REPO_DIGEST
FROM ${REPO_DIGEST}
ARG CHECKSUM
RUN echo "${CHECKSUM}" > /root/.checksum

RUN apk add --no-cache \
        curl \
    && addgroup -g 1000 alpine \
    && adduser -u 1000 -G alpine -h /home/alpine -s /bin/sh -D alpine

ARG VERSION
RUN curl -SsL "https://storage.googleapis.com/kubernetes-helm/helm-v${VERSION}-linux-amd64.tar.gz" \
    | tar -xz -C /usr/local/bin --strip-components=1 linux-amd64/helm 

WORKDIR /home/alpine
USER alpine:alpine
ENTRYPOINT [ "/usr/local/bin/helm" ]
