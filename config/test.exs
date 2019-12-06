import Config

config :cookieater,
       :cookie_store,
       process: [],
       redis_sentinels: false

config :cookieater, :store_client, Test.Cookie.Store