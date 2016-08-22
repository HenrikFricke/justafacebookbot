defmodule Justafacebookbot.Router do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Root path
  get "/" do
    send_resp(conn, 200, "This entire website runs on Elixir plugs!...")
  end

  get "/webhook" do
    conn = Plug.Conn.fetch_query_params(conn)
    if conn.params["hub.mode"] === "subscribe" &&
      conn.params["hub.verify_token"] === System.get_env("VALIDATION") do
        send_resp(conn, 200, conn.params["hub.challenge"])
    else
      send_resp(conn, 403, "Something went wrong.")
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
