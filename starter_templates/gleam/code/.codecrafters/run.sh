#!/bin/sh
#
# This script is used to run your program on CodeCrafters
#
# This runs after .codecrafters/compile.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

ls -la
pwd
# exec gleam run --module main -- "$@"
exec ./build/erlang-shipment/entrypoint.sh run -- "$@"