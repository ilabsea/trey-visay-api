Rails.application.routes.draw do
  devise_for :accounts, path: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'

  resources :users do
    resources :games, only: [:index, :show]
    resources :personality_tests, only: [:index, :show]

    get :download, on: :collection
  end

  resource :about, only: [:show]
  resources :accounts
  namespace :api do
    namespace :v1 do
      match 'me' => 'users#me', :via => :get
      resources :users, only: [:create]
      resources :schools, :only => [:index, :create]
      resources :games, only: [:create]
      resources :personality_tests, only: [:create]
      resources :high_schools, only: [:index] do
        get :grades, on: :collection
      end
      devise_scope :account do
        post '/accounts/sign_in' => 'sessions#create'
        post '/accounts/sign_out' => 'sessions#destroy'
      end
    end
  end

  mount Pumi::Engine => '/pumi'
end
