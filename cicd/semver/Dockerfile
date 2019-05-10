FROM node:lts-alpine

RUN yarn global add semver

WORKDIR /home/node
USER node:node
ENTRYPOINT [ "semver" ]
