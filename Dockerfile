FROM node:22.5.1-alpine3.20@sha256:9fcc1a6da2b9eee38638df75c5f826e06e9c79f6a0f97f16ed98fe0ebb0725c0 AS node
WORKDIR /app
RUN apk add --no-cache gzip

FROM php:8.3.27-fpm-alpine@sha256:33211d6979a9d3259d35aa844bb410a1bda2fbaf868d6bb865390c3f68d58b5a AS php
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APP_ENV prod
ENV APP_DEBUG 0
COPY --from=composer:2.8.5@sha256:59ee7d4d85c5ea88e3eb91ef2f93498e7bab51526327a479b4cb9f4d9b4bd567 --chmod=755 /usr/bin/composer /usr/local/bin/composer
