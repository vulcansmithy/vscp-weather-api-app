

# Weather RESTful API (Rails 7.1)

This is a  API-only Rails application that returns current weather
information for Melbourne with provider failover and caching.

## Requirements

- Ruby 3.1.3
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

7. install `redis` using `homebrew` (for the MacOS Platform)

   ```bash
   brew install redis
   ```

   

## Running the app locally

Run the `Redis`

```bash
brew services start redis
```

Additional, if you need to stop `redis` server

```bash
brew services stop redis
```

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

  

## Future improvements

1. ~~Redis instead of memory cache. Right now cache are saved in SQLite. This is done for quick development. Similiar strategy for coming up with PoC (Proof-Of-Concept) app. For production ready app, the ideal strategy is to use a NoSQL database like Redis.~~

2. Implement a circuit breaker pattern per Provider to protect the service from calling failing or slow third-party service, e.g., Weatherstack and OpenWeatherMap.

3. Enable or implement a rate limiting mechanism using Rack::Attack. This will prevent API endpoint being abused, e.g., DDoS attach, scraping, etc. It also protect the web service of unecesasry calls to third-party API endpoints that the web services uses, e.g., Weatherstack or OpenWeatherMap.

4. Implement a form of API authentication. By implementing this we can determine who using the API endpoint. 

5. Dockerizing the web service for easy development and deployment.

6. Integrate the web service into a CI/CD workflow. This would easy the transition from development to deploying tested and reviewed implemented features.

7. Implement a multi-city support. Right now this version works for the city of Melbourne. Expanding this feature would be make this web service very useful of other user that may need getting weather information for other cities aside from the city of Melbourne.

8. Implement a API documentation using OpenAPI/Swagger.

   

