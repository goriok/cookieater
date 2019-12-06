import Config

config :cookieater, :port, 4000

config :cookieater, :secret_key,
       "t6w9z$C&F)J@NcRfUjXn2r4u7x!A%D*G-KaPdSgVkYp3s6v8y/B?E(H+MbQeThWm"

import_config "#{Mix.env() || "dev"}.exs"