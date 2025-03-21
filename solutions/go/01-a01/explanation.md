The entry point for your Chess Bot implementation is in `app/main.go`.

Study and uncomment the relevant code:

```go
// Uncomment this block to pass the first stage

// Run server in a goroutine
go func() {
	if err := server.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
		log.Printf("Error starting server: %v\n", err)
		os.Exit(1)
	}
}()
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
