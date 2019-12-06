defmodule Cookieater.CookieStore.Client do
  @callback get(key :: String) :: String
  @callback save({key :: String, value :: String}) :: String
  @callback ping() :: String
end
