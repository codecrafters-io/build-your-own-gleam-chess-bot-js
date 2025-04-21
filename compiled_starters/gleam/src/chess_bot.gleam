import gleam/dynamic/decode
import gleam/javascript/promise.{type Promise}
import gleam/json
import glen
import glen/status
import chess_bot/chess
import gleam/io

pub fn main() {
  // You can use print statements as follows for debugging, they'll be visible when running tests.
  io.println("Logs from your program will appear here!")

  // Uncomment this block to pass the first stage
  //
  // glen.serve(8000, handle_request)
}

fn handle_request(request: glen.Request) -> Promise(glen.Response) {
  case glen.path_segments(request) {
    ["move"] -> handle_move(request)
    _ -> glen.response(status.ok) |> promise.resolve
  }
}

fn move_decoder() {
  use fen <- decode.field("fen", decode.string)
  use turn <- decode.field("turn", chess.player_decoder())
  use failed_moves <- decode.field("failed_moves", decode.list(decode.string))
  decode.success(#(fen, turn, failed_moves))
}

fn handle_move(request: glen.Request) -> Promise(glen.Response) {
  use body <- glen.require_string_body(request)
  let decode_result = json.parse(body, move_decoder())
  case decode_result {
    Error(_) -> glen.response(status.bad_request) |> promise.resolve
    Ok(move) -> {
      let move_result = chess.move(move.0, move.1, move.2)
      case move_result {
        Ok(move) ->
          glen.response(status.ok) |> glen.text_body(move) |> promise.resolve
        Error(reason) ->
          glen.response(status.internal_server_error)
          |> glen.text_body(reason)
          |> promise.resolve
      }
    }
  }
}