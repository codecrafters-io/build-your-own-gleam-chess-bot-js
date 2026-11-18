This variant compiles Gleam to JavaScript. In this stage, you'll start the
supplied HTTP server for POST requests to `/move`.

### The Gleam starter

The starter uses Glen, an HTTP server library for Deno. Enable the provided
`glen.serve(8000, handle_request)` call in `src/chess_bot.gleam`. The request
handlers are already defined and return asynchronous responses through Gleam's
`Promise` type.

The
[Erlang/OTP-target challenge](https://app.codecrafters.io/courses/gleam-chess-bot/overview)
uses a different starter. Keep this variant's existing compile and run scripts.

The handlers decode JSON and call `move` in `src/chess_bot/chess.gleam`. Its
`Player` value is `White` or `Black`. Its `Result(String, String)` return type
carries either `Ok(move)`, a successful move string, or `Error(reason)`, an
error string. The handler turns `Ok(move)` into an HTTP 200 response with that
text as its body.

### The move request

The client sends JSON in this shape:

```json
{
  "fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
  "turn": "white",
  "failed_moves": []
}
```

- `fen` describes the board in
  [Forsyth-Edwards Notation](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation),
  a text representation of a chess position.
- `turn` identifies the side to move as `"white"` or `"black"`.
- `failed_moves` lists moves rejected for the current turn in the tournament
  protocol. The challenge's tests send an empty list.

Return a legal move in
[SAN (Standard Algebraic Notation)](<https://en.wikipedia.org/wiki/Algebraic_notation_(chess)>),
such as `e4` for a pawn move to e4. A hardcoded legal response is enough here.
Replace the helper's `Ok("e0")` placeholder, which is not a legal move. Choosing
moves for other positions comes later.

### Tests

The tester starts your program without arguments:

```sh
./your_program.sh
```

Keep it running. From another terminal, send the request:

```sh
curl -i -X POST http://localhost:8000/move \
  -H 'Content-Type: application/json' \
  -d '{"fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1","turn":"white","failed_moves":[]}'
```

Expect HTTP 200 within five seconds. For the starting position, one valid
plain-text body is:

```text
e4
```

The current automated check asserts the status code without validating the body.
Your endpoint must still return the legal move requested above. Logging to the
terminal does not send an HTTP response.

### Notes

- Keep `example.ENTRY.md` or `ENTRY.md` beside `your_program.sh`. The first
  check requires one of these files.
- Runtime dependencies are restricted. Keep the supplied dependencies and
  consult the
  [tournament's library list](https://github.com/isaacharrisholt/gleam-chess-tournament#libraries)
  before adding one.
