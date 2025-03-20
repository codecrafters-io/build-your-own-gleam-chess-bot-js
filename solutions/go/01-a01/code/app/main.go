package main

import (
	"context"
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"
	"fmt"

	"github.com/corentings/chess"
)

func main() {
	fmt.Println("Logs from your program will appear here!")

	server := &http.Server{
		Addr: ":8000",
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if r.URL.Path != "/move" {
				http.Error(w, "Invalid path", http.StatusBadRequest)
				return
			}

			// fmt.Println("Received request to /move")
			request := map[string]any{}
			if err := json.NewDecoder(r.Body).Decode(&request); err != nil {
				http.Error(w, err.Error(), http.StatusBadRequest)
				return
			}

			var fen func(*chess.Game)
			var err error
			fenStr := request["fen"].(string)
			fen, err = chess.FEN(fenStr)
			if err != nil {
				fenStr += " 0 1"
				fen, err = chess.FEN(fenStr)
				if err != nil {
					http.Error(w, err.Error(), http.StatusBadRequest)
					return
				}
			}

			game := chess.NewGame(fen)
			moves := game.ValidMoves()

			w.WriteHeader(http.StatusOK)
			w.Write([]byte(moves[0].String()))
		}),
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	// Channel to listen for interrupt signals
	stop := make(chan os.Signal, 1)
	signal.Notify(stop, os.Interrupt, syscall.SIGTERM)

	// Run server in a goroutine
	go func() {
		if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Printf("Error starting server: %v\n", err)
			os.Exit(1)
		}
	}()

	// Wait for interrupt signal
	<-stop

	// Create shutdown context with timeout
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	// Attempt graceful shutdown
	if err := server.Shutdown(ctx); err != nil {
		log.Printf("Error during server shutdown: %v\n", err)
	}
}
