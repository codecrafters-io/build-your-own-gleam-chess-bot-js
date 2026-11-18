Your bot has practiced tactical move selection. In this stage, you'll improve
its play using positions from the Win at Chess collection.

### Broader position coverage

The [Win at Chess](https://www.chessprogramming.org/Win_at_Chess) collection
supplies another set of board positions. Keep choosing moves for the side
identified by each request. These cases may expose movement or king-safety rules
that your earlier examples did not exercise.

The goal is to develop a bot that can play and win full games. Use these
positions to find weaknesses in its choices, including avoidable material
losses, inactive pieces, or an exposed king. Your move-selection approach
remains up to you. Keep the same HTTP interface and legal-move response
contract.

The automated checks cover individual positions and move legality. They do not
play complete games or establish whether your bot can win them. Treat that
distinction as a limit of the check, not a reason to stop improving its play.

### Response time

Keep each move response within five seconds. This is a per-request limit, not a
chess clock shared across a full game. If you choose to rank moves or search
possible replies, that work must still fit within the response budget.

### Tests

The tester starts `./your_program.sh` and sends a selection of Win at Chess
positions to `POST /move`. With your server running, you can try one position:

```sh
curl -i -X POST http://localhost:8000/move \
  -H 'Content-Type: application/json' \
  -d '{"fen":"2rr3k/pp3pp1/1nnqbN1p/3pN3/2pP4/2P3Q1/PPB4P/R4RK1 w - - 0 1","turn":"white","failed_moves":[]}'
```

Return HTTP 200 and a plain-text legal move. For example:

```text
Qg6
```

The linked Win at Chess record lists `Qg6` for this position, moving White's
queen to g6. The automated checker accepts other legal moves too. An illegal
move, a non-200 response, or a response outside the time budget fails the check.
