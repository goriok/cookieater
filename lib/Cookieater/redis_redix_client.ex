defmodule Cookieater.Redis.RedixClient do
  @behaviour Cookieater.CookieStore.Client
  require Redix
  require Logger

  def ping() do
    {:ok, Redix.command!(:redix, ["PING"])}
  end

  def get(key) do
    Redix.command!(:redix, ["GET", key])
    |> get_response()
  end

  defp get_response({:ok, nil}) do {:ok, []} end

  defp get_response(res) do {:ok, res} end

  def save(%{key: key, value: value}) do
    Redix.command!(:redix, ["SET", key, value])
    {:ok, key}
  end

end