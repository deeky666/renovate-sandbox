FROM node:22.5.1-alpine3.20 AS node
WORKDIR /app
RUN apk add --no-cache gzip
