Your server can return a hardcoded legal move. In this stage, you'll choose
opening moves from the supplied position and your bot's color.

### Reading the starting position

The request's
[FEN](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation) string
describes a board. Its first field lists ranks (rows) from 8 down to 1, with `/`
between ranks. Within a rank, squares run across files (columns) from `a` to
`h`. A digit counts consecutive empty squares.

The letters `p`, `n`, `b`, `r`, `q`, and `k` represent pawns, knights, bishops,
rooks, queens, and kings. Uppercase letters are White's pieces and lowercase
letters are Black's. The next field, `w` or `b`, identifies the side to move.
The JSON `turn` field gives the same information as `"white"` or `"black"`.

An opening strategy chooses moves during the early part of a game. Read the
supplied position and side to move so your choice remains legal as the opening
develops. Your choice of strategy is up to you.

### Returning a move

Extend the move selection in `src/chess_bot/chess.gleam`. Keep returning a
successful move through `Ok(move)` so the supplied handler sends it as plain
text.

In
[SAN (Standard Algebraic Notation)](<https://en.wikipedia.org/wiki/Algebraic_notation_(chess)>),
`e4` means a pawn moves to square e4. From the starting position, this advances
White's e-pawn two squares. After that move, Black could reply with `e5`. The
response contains only the move, without move numbers such as `1.` or `1...`,
JSON quotes, or commentary.

### Tests

The tester starts your program with `./your_program.sh`. Its current automated
check sends the starting position with White to move. With your server running,
you can send the same request:

```sh
curl -i -X POST http://localhost:8000/move \
  -H 'Content-Type: application/json' \
  -d '{"fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1","turn":"white","failed_moves":[]}'
```

Return HTTP 200 within five seconds. One valid response body is:

```text
e4
```

The automated check accepts a different legal first move too. That check alone
does not verify your strategy for later opening positions or for Black, so
exercise those choices locally as well.

### Notes

- The `failed_moves` field lists moves already rejected for this turn. Avoid
  repeating a rejected move. The current automated tests send an empty list and
  fail on an illegal response without retrying.
