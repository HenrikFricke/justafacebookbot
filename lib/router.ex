defmodule Justelixir.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  # Root path
  get "/" do
    send_resp(conn, 200, "Here is nothing, but nice to see you ;)")
  end

  forward "/gifs", to: Justelixir.GifsRouter

  match _ do
    send_resp(conn, 404, "oops")
  end
end
