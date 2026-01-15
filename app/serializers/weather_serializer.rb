# app/serializers/weather_serializer.rb
class WeatherSerializer
  include JSONAPI::Serializer

  # @TODO
  set_id { |object| 'melbourne' }

  attributes :temperature_degrees, :wind_speed
end