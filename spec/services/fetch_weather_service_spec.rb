# frozen_string_literal: true

# spec/services/weather/fetch_weather_service_spec.rb
RSpec.describe Weather::FetchWeatherService do
  it 'returns unified weather data' do
    allow_any_instance_of(Weather::Providers::Weatherstack)
      .to receive(:fetch)
      .and_return({ temperature_degrees: 29, wind_speed: 20 })

    result = described_class.new.call

    expect(result[:temperature_degrees]).to eq(29)
    expect(result[:wind_speed]).to eq(20)
  end
end
