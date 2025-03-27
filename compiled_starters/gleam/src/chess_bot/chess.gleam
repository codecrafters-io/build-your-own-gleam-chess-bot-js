import gleam/dynamic/decode

pub type Player {
  White
  Black
}

pub fn player_decoder() {
  use player_string <- decode.then(decode.string)
  case player_string {
    "white" -> decode.success(White)
    "black" -> decode.success(Black)
    _ -> decode.failure(White, "Invalid player")
  }
}

pub fn move(
  _fen: String,
  _turn: Player,
  _failed_moves: List(String),
) -> Result(String, String) {
  Ok("e0")
}