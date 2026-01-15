# frozen_string_literal: true

module V1
  # app/controllers/v1/weather_controller.rb
  class WeatherController < ApplicationController
    WeatherData = Struct.new(:temperature_degrees, :wind_speed, keyword_init: true)

    def show
      data = Weather::FetchWeatherService.new.call
      weather = WeatherData.new(data)
      render json: WeatherSerializer.new(weather).serializable_hash
    end
  end
end
