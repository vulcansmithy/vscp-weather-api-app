# frozen_string_literal: true

# app/serializers/weather_serializer.rb
class WeatherSerializer
  include JSONAPI::Serializer

  # @TODO
  set_id { |_object| 'melbourne' }

  attributes :temperature_degrees, :wind_speed
end
