#!/bin/sh
#
# This script is used to compile your program on CodeCrafters
#
# This runs before .codecrafters/run.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

gleam deps download
gleam build --target javascript
echo "main()" >> build/dev/javascript/chess_bot/chess_bot.mjs
deno --allow-net build/dev/javascript/chess_bot/chess_bot.mjs