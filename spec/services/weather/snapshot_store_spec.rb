# frozen_string_literal: true

require 'rails_helper'

# spec/services/weather/snapshot_store_spec.rb
RSpec.describe Weather::SnapshotStore do
  let(:redis) { Redis.new }
  let(:store) { described_class.new(redis: redis) }
  let(:city) { 'melbourne' }
  let(:data) { { temperature_degrees: 22, wind_speed: 10 } }

  before { redis.flushdb }

  describe '#write and #read' do
    it 'store retrieves weather data' do
      store.write(city: city, data: data, ttl: 5)
      result = store.read(city: city)

      expect_weather_data(result)
    end

    it 'expires data after TTL' do
      store.write(city: city, data: data, ttl: 1)
      sleep 2

      expect(store.read(city: city)).to be_nil
    end

    def expect_weather_data(result)
      expect(result[:temperature_degrees]).to eq(22)
      expect(result[:wind_speed]).to eq(10)
    end
  end
end
