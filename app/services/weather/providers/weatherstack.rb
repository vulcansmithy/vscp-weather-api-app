# frozen_string_literal: true

module Weather
  module Providers
    # app/services/weather/providers/weatherstack.rb
    class Weatherstack < Base
      def fetch
        response = connection.get(
          'http://api.weatherstack.com/current',
          access_key: ENV.fetch('WEATHERSTACK_API_KEY'),
          query: 'Melbourne'
        )

        return unless response.success?

        {
          temperature_degrees: response.body.dig('current', 'temperature'),
          wind_speed: response.body.dig('current', 'wind_speed')
        }
      rescue Faraday::Error
        nil
      end
    end
  end
end
