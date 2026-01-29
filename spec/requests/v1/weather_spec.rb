# frozen_string_literal: true

# rubocop:disable all

require 'rails_helper'
require 'swagger_helper'

# spec/requests/weather_spec.rb
RSpec.describe 'Weather API', type: :request do
  # rubocop:disable Layout/IndentationConsistency
  path '/v1/weather' do
    get 'Fetch current weather' do
      tags 'Weather'
      produces 'application/json'

      response '200', 'weather fetched successfully' do
        schema '$ref' => '#/components/schemas/WeatherResponse'

        example 'application/json', :success, {
          data: {
            id: 'melbourne',
            type: 'weather',
            attributes: {
              temperature_degrees: 29,
              wind_speed: 20
            }
          }
        }

        let(:service) { instance_double(Weather::FetchWeatherService) }

        before do
          allow(Weather::FetchWeatherService)
            .to receive(:new)
            .and_return(service)

          allow(service)
            .to receive(:call)
            .and_return(
              temperature_degrees: 29,
              wind_speed: 20
            )
        end

        run_test!
      end

      response '500', 'internal server error' do
        example 'application/json', :error, {
          error: 'Internal Server Error'
        }

        before do
          allow(Weather::FetchWeatherService)
            .to receive(:new)
            .and_raise(StandardError)
        end

        run_test!
      end
    end
  end
  # rubocop:enable Layout/IndentationConsistency
end
