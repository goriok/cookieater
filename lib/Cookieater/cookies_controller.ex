defmodule Cookieater.CookiesController do
  require Logger

  alias Cookieater.Cookie

  def get(key) do
    store_client().get(key)
    |> get_cookies() end

  defp get_cookies({:ok, []}) do
    {:not_found} end

  defp get_cookies({:ok, cookies_header_string}) do
    cookies =
      cookies_header_string
      |> String.split("|||")
      |> Enum.map(
           fn
             cookie_string -> convert_to_cookie(cookie_string)
           end
         )
    {:ok, cookies}
  end

  def save(%{sid: sid, cookie_string: cookies_string}) do
    store_client().save(%{key: sid, value: cookies_string})
    |> get_save_response()
  end

  defp get_save_response({:ok, sid}) do
    {
      :ok,
      [
        %Cookie{
          name: "sid",
          value: "set-cookie: sid=#{sid}"
        },
        %Cookie{
          name: "bitter",
          value: "set-cookie: bitter=#{get_bitter(sid)}"
        }
      ]
    }
  end

  defp get_bitter(sid) do
    :crypto.hmac(:sha, get_secret(), sid)
    |> Base.encode16
    |> String.downcase
  end

  defp get_secret() do
    System.get_env("SECRET_KEY") || "abcasdfak2323241lsdja"
  end

  defp convert_to_cookie(set_cookies_string) do
    capture =
      ~r/(?<=set-cookie:\s)(?<name>[\w_]+)=(?<value>[\w%]+);\sPath=(?<path>[\/\w]+)/
      |> Regex.named_captures(set_cookies_string)
    %Cookie{
      name: capture["name"],
      value: capture["value"],
      path: capture["path"]
    }
  end

  defp store_client do
    Application.get_env(:cookieater, :store_client) end
end