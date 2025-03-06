Rails.application.routes.draw do
  namespace :api do
    get "/hikes" => "hikes#index"
    get "/hikes/:id" => "hikes#show"
    # get "/breweries" => "breweries#index"
    get "/search_results" => "search_results#index"
    get "/brewery_search" => "search_results#brewery_search_index"
    get "/state_geographic_center" => "search_results#state_geographic_center"
    get "/territories" => "territories#index"
    get "/saved_hikes" => "saved_hikes#index"
    post "/saved_hikes" => "saved_hikes#create"
    post "/users" => "users#create"
    post "/sessions" => "sessions#create"
  end
  # get '*path' => 'application#index'
end
