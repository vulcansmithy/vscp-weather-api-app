# frozen_string_literal: true

require 'rails_helper'

# spec/requests/weather_spec.rb
RSpec.describe 'Weather API', type: :request do
  let(:service) { instance_double(Weather::FetchWeatherService) }

  let(:service_response) do
    {
      temperature_degrees: 29,
      wind_speed: 20
    }
  end

  before do
    allow(Weather::FetchWeatherService)
      .to receive(:new)
      .and_return(service)

    allow(service)
      .to receive(:call)
      .and_return(service_response)

    get '/v1/weather'
  end

  it 'returns weather payload', :aggregate_failures do
    expect(response).to have_http_status(:ok)

    body = response.parsed_body
    expect(body.dig('data', 'attributes', 'wind_speed')).to eq(20)
  end
end
