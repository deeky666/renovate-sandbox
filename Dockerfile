FROM node:22.5.1-alpine3.20@sha256:9fcc1a6da2b9eee38638df75c5f826e06e9c79f6a0f97f16ed98fe0ebb0725c0 AS node
WORKDIR /app
RUN apk add --no-cache gzip

FROM php:8.4.14-fpm-alpine@sha256:994527feb1fe228e1f28f657abb6ae0e835b68b2dc0c8ef3d05c3fa06416371a AS php
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APP_ENV prod
ENV APP_DEBUG 0
