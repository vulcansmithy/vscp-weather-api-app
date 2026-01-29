# frozen_string_literal: true

# app/application_controller.rb
class ApplicationController < ActionController::API
  rescue_from StandardError do
    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end
end
