This challenge is specifically for building your bot using Gleam targeting JavaScript.
If you're interested in building your bot using Gleam targeting Erlang/OTP, you can find that option [here](https://app.codecrafters.io/courses/gleam-chess-bot/overview).

In this stage, you'll implement a basic HTTP server that responds to POST requests at the `/move` endpoint.

### The /move endpoint

The server should accept JSON requests in the following format:

```json
{
  "fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
  "turn": "white",
  "failed_moves": []
}
```

Here are what the fields mean:

- `fen`: The current state of the board in [Forsyth-Edwards Notation](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation).
- `turn`: Whose turn it is to move. Either "white" or "black".
- `failed_moves`: A list of moves that your bot attempted to make for this turn, but were not legal moves.

To pass this stage you can respond with a hardcoded legal chess move in [SAN notation](https://en.wikipedia.org/wiki/Algebraic_notation_(chess)), such as "e4".

### Tests

The tester will send a POST request to your server at `http://localhost:8000/move` with a valid chess position.

Your server should respond with a 200 OK status code and a valid chess move in the response body.

### Notes

- The server must listen on port 8000
- The response should be a plain text string containing just the move