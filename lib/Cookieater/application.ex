defmodule Cookieater.Application do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Starting application with port #{get_port()}")
    [
      get_webserver_process() |
      get_cookie_store_opts()
      |> get_cookie_store_process()
    ]
    |> Supervisor.start_link([strategy: :one_for_one, name: Example.Supervisor])
  end

  defp get_cookie_store_process([_, redis_sentinels: true]) do
    sentinels = System.get_env("REDIS_SENTINELS")
                |> String.split(",")
    group = System.get_env("REDIS_SENTINELS_GROUP")
    [
      {
        Redix,
        sentinel: [
          sentinels: sentinels,
          group: group
        ],
        name: :redix
      }
    ]
  end

  defp get_cookie_store_process(opts) do
    opts[:process]
  end

  defp get_webserver_process() do
    {
      Plug.Cowboy,
      scheme: :http,
      plug: Cookieater.Router,
      options: [
        port: get_port()
      ]
    }
  end

  defp get_port() do
    :cookieater
    |> Application.get_env(:port)
  end

  defp get_cookie_store_opts() do
    Application.get_env(:cookieater, :cookie_store)
  end
end