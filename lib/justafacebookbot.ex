defmodule Justafacebookbot do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: Justafacebookbot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    { :ok, _ } = Plug.Adapters.Cowboy.http Justafacebookbot.Router, []
  end
end
