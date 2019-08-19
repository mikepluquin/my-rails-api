Rails.application.routes.draw do
  resources :users do
    resources :posts
    resources :followeds, only: [:index, :create, :destroy]
    resources :followers, only: [:index]
    resources :conversations do
      resources :messages, except: [:index, :show]
    end
  end

  resources :posts, only: [:index] do
    resources :likes, only: [:create, :destroy]
  end

  post '/auth/login', to: 'authentication#login'
end
