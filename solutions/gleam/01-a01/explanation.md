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
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
