Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :posts do
    resources :ratings, only: :create, format: 'json'
    resources :comments, only: [:create, :destroy]
  end
    
  root to: 'posts#index'
end
