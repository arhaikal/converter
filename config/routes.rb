Rails.application.routes.draw do
  devise_for :users
  resources :exchanges
  root 'exchanges#index'

  namespace :api do
    namespace :v1 do
      resources :historical_rates do
        resources :rates
      end
    end
  end
end
