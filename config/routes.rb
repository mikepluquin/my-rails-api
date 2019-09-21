Rails.application.routes.draw do
  resources :users, except: [:put, :create] do
    resources :posts, except: [:put]
    resources :followeds, only: [:index, :create, :destroy]
    resources :followers, only: [:index]
    resources :conversations, except: [:put] do
      resources :messages, except: [:index, :show, :put]
    end
  end

  resources :posts, only: [:index] do
    resources :likes, only: [:create, :destroy]
  end

  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'
end
