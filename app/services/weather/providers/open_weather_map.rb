# app/services/weather/providers/open_weather_map.rb
module Weather
  module Providers
    class OpenWeatherMap < Base
      def fetch
        response = connection.get(
          "https://api.openweathermap.org/data/2.5/weather",
          q: "melbourne,AU",
          appid: ENV.fetch("OPENWEATHER_API_KEY"),
          units: "metric"
        )

        return unless response.success?

        {
          temperature_degrees: response.body.dig("main", "temp").to_i,
          wind_speed: response.body.dig("wind", "speed").to_i
        }
      rescue Faraday::Error
        nil
      end
    end
  end
end