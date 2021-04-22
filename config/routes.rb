Rails.application.routes.draw do
  namespace :api do
    get "/hikes" => "hikes#index"
    get "/hikes/:id" => "hikes#show"
  end
end
