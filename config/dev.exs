import Config

config :cookieater,
       :cookie_store,
       process: [{Redix, name: :redix}],
       redis_sentinels: false

config :cookieater, :store_client, Cookieater.Redis.RedixClient