# syntax=docker/dockerfile:1.7-labs
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
COPY --from=erlang_builder /app-cached /app
# COPY --from=erlang_builder /app-cached /app ???
