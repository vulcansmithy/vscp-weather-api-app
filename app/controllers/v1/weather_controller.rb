require 'ostruct'

# app/controllers/v1/weather_controller.rb
module V1
  class WeatherController < ApplicationController
    def show
      data = Weather::FetchWeatherService.new.call
      render json: WeatherSerializer.new(OpenStruct.new(data)).serializable_hash
    end
  end
end