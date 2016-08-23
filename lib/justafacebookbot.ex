defmodule Justelixir do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Justelixir.Router, [],
        [port: String.to_integer(System.get_env("PORT") || "4001")])
    ]

    opts = [strategy: :one_for_one, name: Justelixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
