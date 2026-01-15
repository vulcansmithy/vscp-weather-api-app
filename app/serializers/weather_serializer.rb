# app/serializers/weather_serializer.rb
class WeatherSerializer
  include JSONAPI::Serializer

  attributes :temperature_degrees, :wind_speed
end