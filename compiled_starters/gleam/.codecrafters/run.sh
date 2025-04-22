#!/bin/sh
#
# This script is used to run your program on CodeCrafters
#
# This runs after .codecrafters/compile.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

echo "main()" >> build/dev/javascript/chess_bot/chess_bot.mjs
deno run --allow-net build/dev/javascript/chess_bot/chess_bot.mjs
