Your bot has an opening strategy. In this stage, you'll improve its tactical
move selection using positions from the Bratko-Kopec test set.

### Positions beyond the opening

The [Bratko-Kopec test](https://www.chessprogramming.org/Bratko-Kopec_Test) is a
collection of positions used to assess chess engines. Tactics are short
sequences that create or answer threats, such as capturing a piece or
threatening checkmate. Aim to choose legal moves that preserve or gain material,
the pieces available to each side.

Each request supplies an independent position. It may be either player's turn,
and pieces may already have moved or been captured. A legal move must follow the
piece's movement rules, respect occupied squares, and leave its own king out of
check. Choose from the supplied position instead of assuming every request
continues the same game.

### FEN state and move legality

Alongside the board and side to move, FEN records castling rights and an
en-passant target. Castling moves a king and a rook in one turn. Castling rights
record whether those pieces retain permission to castle. Occupied squares or
check can still prevent that move. The en-passant target records the square
crossed when the immediately preceding move advanced a pawn two squares, which
may allow a special pawn capture. A dash means no rights or target in that
field.

These positions often contain only those first four FEN fields. The two move
counters present in a full six-field FEN may be omitted, as in the example
below. Accept that form as well as the full form already shown.

Keep the existing Gleam helper and HTTP interface. Improve how your bot chooses
among legal moves. A position evaluation estimates which side is better off,
while search examines possible moves and replies. Material balance and piece
activity, such as control of useful squares, can inform your choice. How you
represent and evaluate positions, and whether to search replies, remain yours to
decide.

### Tests

The tester starts `./your_program.sh`, then sends a selection of positions from
the set to `POST /move`. With the server running, try this example:

```sh
curl -i -X POST http://localhost:8000/move \
  -H 'Content-Type: application/json' \
  -d '{"fen":"1k1r4/pp1b1R2/3q2pp/4p3/2B5/4Q3/PPP2B2/2K5 b - -","turn":"black","failed_moves":[]}'
```

Return HTTP 200 within five seconds and a legal move as plain text. For this
position, one accepted body is:

```text
Qd1+
```

The linked Bratko-Kopec record lists `Qd1+` for this position. `Q` identifies
the queen, and `+` means check. Use the reference positions to assess your
choices. The automated checks accept legal moves without comparing them to the
listed tactical solutions or measuring material gain.
