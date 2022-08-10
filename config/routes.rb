Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients
  root 'products#index'

  resources :products, only: %i[show new create] do
    member do
      post 'activate'
      post 'deactivate'
    end
  end
end
