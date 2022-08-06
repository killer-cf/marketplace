Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %i[show new create]
end
