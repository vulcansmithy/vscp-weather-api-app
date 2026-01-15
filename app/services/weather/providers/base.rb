# app/services/weather/providers/base.rb
module Weather
  module Providers
    class Base
      def connection
        Faraday.new do |f|
          f.options.timeout = 2
          f.response :json
          f.request :retry, max: 1
        end
      end
    end
  end
end