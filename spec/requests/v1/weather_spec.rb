# spec/requests/weather_spec.rb
RSpec.describe 'Weather API', type: :request do
  it 'returns weather payload' do
    allow_any_instance_of(Weather::FetchWeatherService)
      .to receive(:call)
      .and_return({ temperature_degrees: 29, wind_speed: 20 })

    get '/v1/weather'

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body.dig('data', 'attributes', 'wind_speed')).to eq(20)
  end
end