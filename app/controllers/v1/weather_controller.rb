# frozen_string_literal: true

require 'ostruct'

module V1
  # app/controllers/v1/weather_controller.rb
  class WeatherController < ApplicationController
    def show
      data = Weather::FetchWeatherService.new.call
      render json: WeatherSerializer.new(OpenStruct.new(data)).serializable_hash
    end
  end
end
