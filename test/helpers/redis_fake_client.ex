defmodule Test.Cookie.Store do
  @behaviour Cookieater.CookieStore.Client
  require Logger

  def ping() do
    Logger.info("called ping/0")
    {:ok, ""}
  end

  def get(key) do
    {:ok, "set-cookie: active_session=e%3Ab57845151d52316529aebbfc44831d20%3Ab0c42a05f731be1cbdd407841de4bec36751b25f0a4f4b81924309a2cec5b5c008aea7c62989b0b4f564f5b1ec4a81a13ab0fda1a5f36b2abc7ebd50cf0b254913e618c7ab7090e038ded284cb41098a; Path=/ ||| set-cookie: another_cookie=e%3Ab57845151d52316529aebbfc44831d20%3Ab0c42a05f731be1cbdd407841de4bec36751b25f0a4f4b81924309a2cec5b5c008aea7c62989b0b4f564f5b1ec4a81a13ab0fda1a5f36b2abc7ebd50cf0b254913e618c7ab7090e038ded284cb41098a; Path=/ "}
  end

  def save(%{key: key, value: value}) do
    Logger.info("called save/2 {key: #{key}, value: #{value}}")
    send(self(), value)
    {:ok, key}
  end
end

defmodule Test.CookieStore.NotFound do
  require Logger

  def get(key) do
    {:ok, []}
  end
end

defmodule Test.Cookie.Error.Store do
  @behaviour Cookieater.Cookie.Store.Client
  require Logger

  def ping() do
    Logger.info("called ping/0")
    {:error}
  end

  def get(key) do
    Logger.info("called get/1 {key: #{key}}")
    {:error}
  end

  def save(key, value) do
    Logger.info("called save/2 {key: #{key}, value: #{value}}")
    {:error}
  end
end