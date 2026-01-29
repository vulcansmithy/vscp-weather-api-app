# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Weather API',
        version: 'v1',
        description: 'Weather API – Version 1'
      },
      paths: {},
      servers: [
        { url: 'http://localhost:3000', description: 'Local' }
      ],
      components: {
        schemas: {
          WeatherResponse: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: { type: :string, example: 'melbourne' },
                  type: { type: :string, example: 'weather' },
                  attributes: {
                    type: :object,
                    properties: {
                      temperature_degrees: { type: :integer, example: 29 },
                      wind_speed: { type: :integer, example: 20 }
                    },
                    required: %w[temperature_degrees wind_speed]
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
