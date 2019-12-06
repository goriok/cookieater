defmodule Cookieater.Router do
  use Plug.Router
  require Logger

  alias Cookieater.CookiesController

  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :dispatch

  get "/cookies/:sid" do
    Logger.info("GET /cookies/#{sid}")
    conn
    |> get_cookies_response(CookiesController.get(sid))
  end

  defp get_cookies_response(conn, {:not_found}) do conn |> send_resp(404, "") end

  defp get_cookies_response(conn, {:ok, res}) do conn |> send_resp(200, Poison.encode!(res)) end

  put "/cookies/:sid" do
    cookies_string = conn.resp_body
    conn
    |> put_cookies_response(CookiesController.save(%{sid: sid, cookie_string: cookies_string}))
  end

  defp put_cookies_response(conn, {:ok, res}) do
    conn |> send_resp(201, Poison.encode!(res))
  end

  get "/ping" do
    Logger.info("GET /ping")
    conn
    |> ping_response(get_store().ping())
  end

  defp ping_response(conn, {:ok, res}) do conn |> send_resp(200, res) end

  defp ping_response(conn, {:error}) do conn |> send_resp(503, "") end

  defp get_store() do
    Application.get_env(:cookieater, :store_client)
  end

end