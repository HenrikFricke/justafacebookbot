defmodule Justelixir.GifsRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  @url "http://api.giphy.com/v1/gifs/"
  @api_key "dc6zaTOxFJmzC"

  get "/" do
    response = HTTPotion.get "#{@url}random?api_key=#{@api_key}"
    {:ok, body} = Poison.decode(response.body)
    gif = HTTPotion.get body["data"]["image_original_url"]
    send_resp(conn, 200, gif.body)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
