# frozen_string_literal: true

module Weather
  # app/services/weather/fetch_weather_service.rb
  class FetchWeatherService
    CITY = 'melbourne'
    CACHE_KEY = 'weather:melbourne'
    CACHE_TTL = 3.seconds

    PROVIDERS = [
      Weather::Providers::Weatherstack,
      Weather::Providers::OpenWeatherMap
    ].freeze

    def initialize(snapshot_store: SnapshotStore.new)
      @snapshot_store = snapshot_store
    end

    def call
      Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_TTL) do
        data = fetch_from_providers
        persist(data)
        data
      end
    rescue StandardError
      fetch_from_redis
    end

    private

    attr_reader :snapshot_store

    def fetch_from_providers
      PROVIDERS.each do |provider|
        result = provider.new.fetch
        return result if valid_payload?(result)
      end
      raise 'All providers failed'
    end

    def persist(data)
      snapshot_store.write(
        city: CITY,
        data: {
          temperature_degrees: data[:temperature_degrees],
          wind_speed: data[:wind_speed]
        }
      )
    end

    def fetch_from_redis
      data = snapshot_store.read(city: CITY)
      raise 'No cached data available' unless data

      data.slice(:temperature_degrees, :wind_speed)
    end

    def valid_payload?(data)
      data.is_a?(Hash) &&
        data[:temperature_degrees].present? &&
        data[:wind_speed].present?
    end
  end
end