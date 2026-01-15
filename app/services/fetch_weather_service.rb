# app/services/fetch_weather_service.rb
class FetchWeatherService
  CITY = 'melbourne'
  CACHE_KEY = 'weather:melbourne'
  CACHE_TTL = 3.seconds

  PROVIDERS = [
    Weatherstack,
    OpenWeatherMap
  ].freeze

  def call
    Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_TTL) do
      data = fetch_from_providers
      persist(data)
      data
    end
  rescue StandardError
    fetch_from_database
  end

  private

  def fetch_from_providers
    PROVIDERS.each do |provider|
      result = provider.new.fetch
      return result if result
    end
    raise 'All providers failed'
  end

  def persist(data)
    WeatherSnapshot.upsert(
      {
        city: CITY,
        temperature_c: data[:temperature_degrees],
        wind_speed: data[:wind_speed],
        updated_at: Time.current
      },
      unique_by: :city
    )
  end

  def fetch_from_database
    snapshot = WeatherSnapshot.find_by(city: CITY)
    raise 'No cached data available' unless snapshot

    {
      temperature_degrees: snapshot.temperature_c,
      wind_speed: snapshot.wind_speed
    }
  end
end
