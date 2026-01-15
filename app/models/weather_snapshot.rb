# frozen_string_literal: true

# WeatherSnapshot
class WeatherSnapshot < ApplicationRecord
  validates :city, presence: true
  validates :temperature_c, presence: true
  validates :wind_speed, presence: true
end
