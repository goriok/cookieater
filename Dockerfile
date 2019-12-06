FROM elixir:latest

COPY . /app/
COPY docker-entrypoint.sh /app

WORKDIR /app

RUN chmod +x docker-entrypoint.sh
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.clean --all
RUN mix deps.get
RUN MIX_ENV=prod mix release
ENTRYPOINT ["./docker-entrypoint.sh"]