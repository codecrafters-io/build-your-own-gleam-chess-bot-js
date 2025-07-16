In this final stage, your bot will be tested against some of the [Win at Chess](https://www.chessprogramming.org/Win_at_Chess) positions.

### Win at Chess

The [Win at Chess](https://www.chessprogramming.org/Win_at_Chess) positions are a set of test positions that are commonly
used to evaluate chess engines.

Some techniques you might want to implement to pass these tests:

- Minimax search with alpha-beta pruning
- Position evaluation considering:
  - Material
  - Piece activity
  - King safety
  - Pawn structure
- Opening book
- Endgame tablebases

<!-- TODO: Isaac to review, we weren't super sure of this list -->

### Tests

The tester will test your bot against a selection of Win at Chess positions.

### Notes

- Games will be played with standard chess time controls
- Your bot must make moves within the 5 second time limit