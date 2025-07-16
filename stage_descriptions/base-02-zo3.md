In this stage, you'll implement a simple opening strategy.

### How to respond with an opening

Your bot should:

1. Parse the [FEN](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation) string to understand the current board position
2. Check if it's playing as white or black
3. Make a valid opening move based on the position

For example, as white you might want to play 1.e4, and as black you might respond to 1.e4 with 1...e5.

### Tests

The tester will send multiple positions from common chess openings. Your bot must respond with legal moves
that follow basic chess rules.

### Notes

- The move must be legal according to chess rules
- The move must be in [SAN notation](https://en.wikipedia.org/wiki/Algebraic_notation_(chess))
- If a move is not legal, it will be added to the `failed_moves` list in subsequent requests