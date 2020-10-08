FROM node:10 AS Builder

ENV NPM_CONFIG_LOGLEVEL info

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

ARG GENERATE_SOURCEMAP=false

RUN yarn install && yarn build

FROM nginx:1.13.3-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=Builder /usr/src/app/build /usr/share/nginx/html
