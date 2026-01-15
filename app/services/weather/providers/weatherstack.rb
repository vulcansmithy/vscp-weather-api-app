# frozen_string_literal: true

require 'rails_helper'

module Weather
  module Providers
    # app/services/weather/providers/weatherstack.rb
    class Weatherstack < Base
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
          'http://api.weatherstack.com/current',
          access_key: api_key,
          query: 'Melbourne'
        )
      end

      def extract_weather(body)
        {
          temperature_degrees: body.dig('current', 'temperature'),
          wind_speed: body.dig('current', 'wind_speed')
        }
      end

      def api_key
        ENV.fetch('WEATHERSTACK_API_KEY')
      end
    end
  end
end
