# frozen_string_literal: true

require 'rails_helper'

# spec/services/weather/fetch_weather_service_spec.rb
RSpec.describe Weather::FetchWeatherService do
  let(:provider) { instance_double(Weather::Providers::Weatherstack) }

  before do
    allow(Weather::Providers::Weatherstack)
      .to receive(:new)
      .and_return(provider)

    allow(provider)
      .to receive(:fetch)
      .and_return(
        {
          temperature_degrees: 29,
          wind_speed: 20
        }
      )
  end

  it 'returns unified weather data', :aggregate_failures do
    result = described_class.new.call

    expect(result[:temperature_degrees]).to eq(29)
    expect(result[:wind_speed]).to eq(20)
  end
end
