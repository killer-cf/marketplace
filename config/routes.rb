Rails.application.routes.draw do
  devise_for :admins, :controllers => {:registrations => "registrations"}
  devise_for :clients
  root 'products#index'

  resources :products, only: %i[show new create] do
    member do
      post 'activate'
      post 'deactivate'
      post 'increase_stock'
    end
  end
  resources :pending_admins, only: :index do
    member do
      post 'approve'
      post 'reject'
    end
  end
  resources :stock_products, only: :index 
end
