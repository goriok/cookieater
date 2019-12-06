defmodule Example.RouterTest do
  use ExUnit.Case
  use Plug.Test

  require Logger

  alias Cookieater.Router

  @opts Router.init([])

  setup do
    Application.put_env(:cookieater, :store_client, nil)
  end

  test "ping" do
    Application.put_env(:cookieater, :store_client, Test.Cookie.Store)

    conn =
      :get
      |> conn("/ping")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "ping with error" do
    :cookieater
    |> Application.put_env(:store_client, Test.Cookie.Error.Store)

    conn =
      :get
      |> conn("/ping")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 503
  end

  test "get cookies" do
    :cookieater
    |> Application.put_env(:store_client, Test.Cookie.Store)

    conn =
      :get
      |> conn("/cookies/123")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "get cookies empty" do
    :cookieater
    |> Application.put_env(:store_client, Test.CookieStore.NotFound)

    conn =
      :get
      |> conn("/cookies/123")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end

  test "save cookie" do
    :cookieater
    |> Application.put_env(:store_client, Test.Cookie.Store)

    conn =
      :put
      |> conn("/cookies/somekey123", "asd")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 201
  end
end