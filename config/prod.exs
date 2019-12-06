import Config

config :cookieater,
       :cookie_store,
       process: [],
       redis_sentinels: true

config :cookieater, :store_client, Cookieater.Redis.RedixClient

config :logger,
       :console,
       utc_log: true,
       format: "\n{\"metadata\" : { \"timestamp\" : \"$dateT$timeZ\" }, \"level\": \"$level\",\"message\" : {\"appName\": \"cookieater\", \"message\":\"$message\" }}"