# Weather API (Rails 7.1)

A production-grade, API-only Rails application that returns current weather
information for Melbourne with provider failover and caching.

## Requirements

- Ruby 3.4.2
- Rails 7.1
- SQLite
- Weatherstack API key
- OpenWeatherMap API key



## Setting up the app locally

1. git clone the repo
   ```bash
   git clone git@github.com:vulcansmithy/vscp-weather-api-app.git
   ```

2. do a `cd` to `weather_api` folder

   ```bash
   cd weather_api
   ```

3. do a `bundle install`

   ```
   bundle install
   ```

4. copy the file env.example to .env

   ```
   cp env.example .env
   ```

5. edit `.env` file and add the appriopriate the `WEATHERSTACK_API_KEY` and `OPENWEATHER_API_KEY`

   ```bash
   WEATHERSTACK_API_KEY=[insert API Key here..]
   OPENWEATHER_API_KEY=[insert API Key here..]
   ```

6. initialize the corresponding database (used for caching)

   ``` bash
   rails db:create
   rails db:migrate
   ```



## Running the app locally

```bash
rails server
```



## Calling the API

```bash
curl "http://localhost:3000/v1/weather?city=melbourne"
```

```bash
curl "http://localhost:3000/weather?city=melbourne&version=1"
```

```bash
curl -H "Accept: application/vnd.weather.v1+json" "http://localhost:3000/weather?city=melbourne"
```

```bash
curl "http://localhost:3000/weather?city=melbourne"
```



## Testing

```bash
bundle exec rspec
```



## Linting

```bash
bundle exec rubocop
```



## Design decisions

* Service Objects for domain logic

* Provider strategy for failover

* Short-TTL cache to protect external APIs

* DB fallback for high availability

* Strict API versioning

  

## Future Improvements

1. Redis instead of memory cache

2. Circuit breaker per provider

3. Background refresh via Sidekiq

4. Rate limiting with Rack::Attack

5. API authentication

6. Dockerizing deployment and  CI/CD

7. Multi-city support

8. API documentation (OpenAPI)

   

