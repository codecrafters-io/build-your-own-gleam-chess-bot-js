# syntax=docker/dockerfile:1.7-labs
FROM ghcr.io/gleam-lang/gleam:v1.9.1-node-alpine AS builder

WORKDIR /build
COPY --exclude=.git --exclude=README.md . /build

# Compile the project
RUN gleam build --target javascript

RUN mkdir -p /app-cached
RUN mv build /app-cached/build

FROM denoland/deno:alpine-2.2.3

WORKDIR /app
COPY --from=builder /build/build/dev/javascript /app