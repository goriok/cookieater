defmodule Example.CookiesControllerTest do
  use ExUnit.Case
  require Logger

  alias Cookieater.Cookie

  alias Cookieater.CookiesController

  setup do
    Application.put_env(:cookieater, :store_client, Test.Cookie.Store)
  end

  test "should return a cookie struct list" do
    {:ok, cookies} =  CookiesController.get("key")
    assert cookies |> Enum.all?(fn %Cookie{} = x -> x end)
  end

  test "should return :not_found when empty list" do
    Application.put_env(:cookieater, :store_client, Test.CookieStore.NotFound)
    assert {:not_found} = CookiesController.get("key")
  end

  test "should return cookie struct list when save executed" do
    {:ok, cookies} =  CookiesController.save(%{sid: "asd", cookie_string: "asdas"})
    assert cookies |> Enum.all?(fn %Cookie{} = x -> x end)
  end
end