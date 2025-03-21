import { Chess } from "npm:chess.js";

export async function makeMove(fen: string): Promise<string> {
  const chess = new Chess(fen);

  const response = await fetch("http://localhost:8000/move", {
    method: "POST",
    signal: AbortSignal.timeout(5000),
    body: JSON.stringify({
      fen,
      turn: chess.turn() === "w" ? "white" : "black",
      failed_moves: [],
    }),
  });

  if (!response.ok) {
    throw new Error(
      `Failed to make move, got status ${response.status}: ${await response
        .text()}`,
    );
  }

  return await response.text();
}

export function moveIsValid(fen: string, move: string): boolean {
  const chess = new Chess(fen);
  try {
    chess.move(move, { strict: false });
    return true;
  } catch {
    return false;
  }
}