# frozen_string_literal: true

module Weather
  # app/services/weather/snapshot_store.rb
  class SnapshotStore
    KEY_PREFIX = 'weather:snapshot'
    DEFAULT_TTL = 10.seconds

    def initialize(redis: Rails.application.config.redis)
      @redis = redis
    end

    def write(city:, data:, ttl: DEFAULT_TTL)
      key = redis_key(city)
      payload = serialize(data)

      redis.set(key, payload, ex: ttl)
    rescue Redis::BaseError => e
      Rails.logger.error("[Redis] write failed: #{e.message}")
      false
    end

    def read(city:)
      key = redis_key(city)
      raw = redis.get(key)
      return nil unless raw

      deserialize(raw)
    rescue Redis::BaseError => e
      Rails.logger.error("[Redis] read failed: #{e.message}")
      nil
    end

    private

    attr_reader :redis

    def redis_key(city)
      "#{KEY_PREFIX}:#{city.downcase}"
    end

    def serialize(data)
      JSON.generate(data.merge(updated_at: Time.current.iso8601))
    end

    def deserialize(raw)
      JSON.parse(raw, symbolize_names: true)
    end
  end
end
