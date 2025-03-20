The entry point for your Chess Bot implementation is in `src/main.gleam`.

Study and uncomment the relevant code: 

```gleam
// Uncomment this block to pass the first stage

fn handle_move(request: Request) -> Response {
  use body <- wisp.require_string_body(request)
  let decode_result = json.parse(body, move_decoder())
  case decode_result {
    Error(_) -> wisp.bad_request()
    Ok(move) -> {
      let move_result = chess.move(move.0, move.1, move.2)
      case move_result {
        Ok(move) -> wisp.ok() |> wisp.string_body(move)
        Error(reason) ->
          wisp.internal_server_error() |> wisp.string_body(reason)
      }
    }
  }
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
