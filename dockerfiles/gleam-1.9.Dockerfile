# syntax=docker/dockerfile:1.7-labs
FROM ghcr.io/gleam-lang/gleam:v1.9.1-node-slim

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="gleam.toml,manifest.toml"

WORKDIR /app
COPY --exclude=.git --exclude=README.md . /app

RUN gleam deps download
RUN gleam build --target javascript

RUN npm install -g deno

# Cache build directory
RUN mkdir -p /app-cached
RUN mv build /app-cached/build

# RUN mkdir -p /app-cached
# RUN mv build /app-cached/build

# FROM erlang:alpine

# WORKDIR /app
# COPY --from=erlang_builder /app-cached /app
# COPY --from=erlang_builder /app-cached /app ???
