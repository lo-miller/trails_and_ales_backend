# README - Trails and Ales Backend

This is the backend API for the Trails and Ales application, a service that helps users discover hiking trails and nearby breweries. This Rails API works in conjunction with a Vue.js frontend located [here](https://github.com/lo-miller/trails_and_ales_frontend)

## Features

- Hiking trail information including:
  - Trail details (length, difficulty, elevation gain, etc.)
  - Location data (coordinates, state, region)
  - Trail features and characteristics
- User authentication and authorization
- Saved hikes functionality
- State-based trail filtering

## Technology Stack and System Dependencies

- [Ruby 3.1.2](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails 6.1.3](https://rubygems.org/gems/rails/versions/6.1.3.2?locale=en)
- PostgreSQL database
- JWT for authentication
- RSpec for testing
- FactoryBot for generating test data
- Jbuilder for JSON views

## Prerequisites

Before you begin, ensure you have installed:
- [Ruby 3.1.2](https://www.ruby-lang.org/en/documentation/installation/)
- PostgreSQL
- Bundler

## Installation

1. Clone the repository: 
  ```
  git clone https://github.com/lo-miller/trails_and_ales_backend.git
  cd trails_and_ales_backend
  ```
2. Install dependencies:  `bundle install`
3. Database setup:
  ```
  rails db:create
  rails db:migrate
  rails db:seed
  ```
4. Environment setup
  - This application uses a separate Ruby file for the Google Maps API key configuration:
    - Create a file named `.api_key.rb` in the root directory:
      ```ruby
      GOOGLE_MAPS_API_KEY = "your_google_maps_api_key_here"
      ```
    This file is gitignored to keep the API key secure.

    - Rails master key:
      - Ensure you have the correct `master.key` file in the `config/` directory
      - This is used for Rails credentials encryption

## Running the Application

1. Start the Rails server:
   ```bash
   rails server
   ```

2. The API will be available at `http://localhost:3000`

## API Endpoints

### Hikes
- `GET /api/hikes` - List hikes (accepts state parameter)
- `GET /api/hikes/:id` - Get specific hike details

### User Authentication
- `POST /api/users` - Create new user
- `POST /api/sessions` - User login

### Saved Hikes
- `GET /api/saved_hikes` - List user's saved hikes
- `POST /api/saved_hikes` - Save a new hike
- `GET /api/saved_hikes/:id` - Get saved hike details

## Testing

Run the test suite:
  ```
  bundle exec rspec
  ```

Key test areas include:
- Controller tests for API endpoints
- Model validations and associations
- Authentication flow

## External Services

- [Google Maps API](https://developers.google.com/maps/documentation) for location data
- [Native Land Digital API](https://api-docs.native-land.ca/) for territory information


