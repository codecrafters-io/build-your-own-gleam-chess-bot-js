# syntax=docker/dockerfile:1.7-labs
# Node target
FROM ghcr.io/gleam-lang/gleam:v1.9.1-node-alpine AS node_builder

WORKDIR /build
COPY --exclude=.git --exclude=README.md . /build

# Compile the project
RUN gleam build --target javascript

RUN mkdir -p /app-cached
RUN mv build /app-cached/build

FROM denoland/deno:alpine-2.2.3

WORKDIR /app
COPY --from=node_builder /build/build/dev/javascript /app
# COPY --from=node_builder /app-cached /app ??? 

############################################################################## 
# Erlang target
FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang-alpine AS erlang_builder

WORKDIR /build
COPY --exclude=.git --exclude=README.md . /build

RUN gleam export erlang-shipment

RUN mkdir -p /app-cached
RUN mv build /app-cached/build

FROM erlang:alpine

WORKDIR /app
COPY --from=erlang_builder /build/build/erlang-shipment /app
# COPY --from=erlang_builder /app-cached /app ???