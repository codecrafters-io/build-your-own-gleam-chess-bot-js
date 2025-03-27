The entry point for your Chess Bot implementation is in `src/chess_bot.gleam`.

Study and uncomment the relevant code: 

```gleam
// Uncomment this block to pass the first stage

 let assert Ok(_) =
   handle_request
   |> wisp_mist.handler(secret_key_base)
   |> mist.new
   |> mist.bind("0.0.0.0")
   |> mist.port(8000)
   |> mist.start_http

 process.sleep_forever()
}

fn handle_request(request: Request) -> Response {
  case wisp.path_segments(request) {
    ["move"] -> handle_move(request)
    _ -> wisp.ok()
  }
}
fn move_decoder() {
  use fen <- decode.field("fen", decode.string)
  use turn <- decode.field("turn", chess.player_decoder())
  use failed_moves <- decode.field("failed_moves", decode.list(decode.string))
  decode.success(#(fen, turn, failed_moves))
}

fn handle_move(request: Request) -> Response {
  use body <- wisp.require_string_body(request)

  let decode_result = json.parse(body, move_decoder())
  case decode_result {
    Error(_) -> {
      io.println("Failed to decode JSON")
      wisp.bad_request()
    }
    Ok(move) -> {
      let move_result = chess.move(move.0, move.1, move.2)
      case move_result {
        Ok(move) -> {
          wisp.ok() |> wisp.string_body(move)
        }
        Error(reason) -> {
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
