Rails.application.routes.draw do
  namespace :api do
    get "/hikes" => "hikes#index"
    get "/hikes/:id" => "hikes#show"
    # get "/breweries" => "breweries#index"
    get "/search_results" => "search_results#index"
    get "/territories" => "territories#index"
  end
end
