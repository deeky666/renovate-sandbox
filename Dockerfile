FROM node:22.5.1-alpine3.20 AS node
WORKDIR /app
RUN apk add --no-cache gzip

FROM php:8.3.21-fpm-alpine AS php
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV APP_ENV prod
ENV APP_DEBUG 0
