# frozen_string_literal: true

module Weather
  module Providers
    # app/services/weather/providers/open_weather_map.rb
    class OpenWeatherMap < Base
      ENDPOINT = 'https://api.openweathermap.org/data/2.5/weather'
      CITY = 'melbourne,AU'
      UNITS = 'metric'

      def fetch
        response = fetch_weather
        return unless response&.success?

        extract_weather(response.body)
      rescue Faraday::Error
        nil
      end

      private

      def fetch_weather
        connection.get(
          ENDPOINT,
          q: CITY,
          appid: api_key,
          units: UNITS
        )
      end

      def extract_weather(body)
        {
          temperature_degrees: body.dig('main', 'temp')&.to_i,
          wind_speed: body.dig('wind', 'speed')&.to_i
        }
      end

      def api_key
        ENV.fetch('OPENWEATHER_API_KEY')
      end
    end
  end
end
