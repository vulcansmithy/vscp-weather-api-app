# frozen_string_literal: true

require 'redis'

Redis.current = Redis.new(
  url: ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379/0'),
  connect_timeout: 1,
  read_timeout: 1,
  write_timeout: 1,
  reconnect_attempts: 1
)