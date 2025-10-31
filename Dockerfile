FROM node:22.5.1-alpine3.20@sha256:9fcc1a6da2b9eee38638df75c5f826e06e9c79f6a0f97f16ed98fe0ebb0725c0 AS node
WORKDIR /app
RUN apk add --no-cache gzip

FROM php:8.3.21-fpm-alpine@sha256:d2170b0f8da574062b289566a05f25ab57173315a356c9f7519b5e444ae96dac AS php
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APP_ENV prod
ENV APP_DEBUG 0
COPY --from=composer:2.8.11@sha256:68e926a477000f12e8645e82a020b84904d49071c895c4951551fe80eed5d103 --chmod=755 /usr/bin/composer /usr/local/bin/composer
