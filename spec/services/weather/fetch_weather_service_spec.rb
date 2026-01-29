# frozen_string_literal: true

require 'rails_helper'

# `spec/services/weather/fetch_weather_service_spec.rb`
RSpec.describe Weather::FetchWeatherService do
  let(:store) { instance_double(Weather::SnapshotStore) }
  let(:service) { described_class.new(snapshot_store: store) }

  let(:weatherstack) { instance_double(Weather::Providers::Weatherstack) }
  let(:open_weather) { instance_double(Weather::Providers::OpenWeatherMap) }

  let(:payload) do
    { temperature_degrees: 20, wind_speed: 5 }
  end

  before do
    allow(Weather::Providers::Weatherstack)
      .to receive(:new)
      .and_return(weatherstack)

    allow(Weather::Providers::OpenWeatherMap)
      .to receive(:new)
      .and_return(open_weather)

    allow(weatherstack).to receive(:fetch).and_return(payload)
    allow(open_weather).to receive(:fetch).and_return(nil)

    allow(store).to receive(:write)
    allow(store).to receive(:read).and_return(payload)
  end

  it 'returns weather data from provider' do
    expect(service.call).to eq(payload)
  end

  it 'falls back to redis on failure' do
    allow(weatherstack).to receive(:fetch).and_return(nil)
    allow(open_weather).to receive(:fetch).and_return(nil)

    expect(service.call).to eq(payload)
  end
end
