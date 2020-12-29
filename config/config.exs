import Config

config :logger,
  compile_time_purge_matching: [
    [module: Day14, level_lower_than: :error]
  ]
