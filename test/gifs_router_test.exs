defmodule Justelixir.GifsRouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Mock

  @opts Justelixir.GifsRouter.init([])

  setup do
    doc = %{body: "{\"data\":{\"image_original_url\":\"http://test.com\"}}"}
    {:ok, doc: doc}
  end

  test_with_mock "does call giphy api", %{doc: doc}, HTTPotion, [],
    [get: fn(_url) -> doc end] do
    Justelixir.GifsRouter.call(conn(:get, "/"), @opts)
    assert called HTTPotion.get("http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=")
  end

  test_with_mock "does call giphy api with given tag", %{doc: doc}, HTTPotion, [],
    [get: fn(_url) -> doc end] do
    Justelixir.GifsRouter.call(conn(:get, "/panda"), @opts)
    assert called HTTPotion.get("http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=panda")
  end

  test_with_mock "does load gif image", %{doc: doc}, HTTPotion, [],
    [get: fn(_url) -> doc end] do
    Justelixir.GifsRouter.call(conn(:get, "/"), @opts)
    assert called HTTPotion.get("http://test.com")
  end

  test_with_mock "returns gif image", %{doc: doc}, HTTPotion, [],
    [get: fn(_url) -> doc end] do
    conn = Justelixir.GifsRouter.call(conn(:get, "/"), @opts)
    assert conn.status == 200
    assert conn.resp_body == doc.body
  end
end
