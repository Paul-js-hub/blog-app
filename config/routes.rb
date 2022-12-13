Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :destroy]
  end

  resources :posts, only: [:new, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end

  devise_scope  :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  get 'users/Authentication'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :destroy] do
          resources :comments, only: [:index, :create] do
          end
        end
      end
      post 'login', to: 'authentication#create'
     post 'register', to: 'users#create'
    end
  end
end
