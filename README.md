

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

To run the rails server locally

```bash
rails server
```



## Calling the API Endpoint

Since the API endpoint for this web service is properly versioned using the following versioning strategies

- **Path Strategy**, This strategy uses a URL path prefix to request a specific version of your API.
- **Request Parameter Strategy**. This strategy uses a request parameter to request a specific version of your API.
- **HTTP Header**. This strategy uses an HTTP header to request a specific version of your API.
- **Default Version Strategy**. If a request is made to your API without specifying a specific version, by default a RoutingError (i.e. 404) will occur. You can optionally configure Versionist to return a specific version by default when none is specified. To specify that a version should be used as the default, include `:default => true` in the config hash passed to the `api_version` method

Calling the API endpoint using Path Strategy

```bash
curl "http://localhost:3000/v1/weather?city=melbourne"
```

Calling the API endpoint using Request Parameter
```bash
curl "http://localhost:3000/weather?city=melbourne&version=1"
```

Calling the API endpoint using HTTP Header
```bash
curl -H "Accept: application/vnd.weather.v1+json" "http://localhost:3000/weather?city=melbourne"
```
Calling the API endpoint using the Default Version
```bash
curl "http://localhost:3000/weather?city=melbourne"
```



## Testing

To run the `rspec` test

```bash
bundle exec rspec
```



## Linting

To enforce coding standard, this Service app is using `rubocop`. To run `rubocop`

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

   

