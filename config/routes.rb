Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: %i[show new create] do
    member do
      post 'activate'
      post 'deactivate'
    end
  end
end
