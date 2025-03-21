FROM ghcr.io/gleam-lang/gleam:v1.9.1-erlang-alpine AS builder

WORKDIR /build
COPY . /build

RUN gleam export erlang-shipment

FROM erlang:alpine

WORKDIR /app
COPY --from=builder /build/build/erlang-shipment /app

ENTRYPOINT [ "./entrypoint.sh", "run" ]
