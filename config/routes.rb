# frozen_string_literal: true

# config/routes.rb
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  api_version(
    module: 'V1',
    path: { value: 'v1' },
    header: { name: 'Accept', value: 'application/vnd.weather.v1+json' },
    parameter: { name: 'version', value: '1' },
    default: true
  ) do
    get '/weather', to: 'weather#show'
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
