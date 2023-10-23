# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  use_doorkeeper do
    controllers token_info: "token_info"
  end

  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations", omniauth_callbacks: "accounts/omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"

  resources :users do
    resources :games, only: [:index, :show]
    resources :personality_tests, only: [:index, :show]

    resources :holland_quizzes, only: [:show]
    resources :intelligence_quizzes, only: [:show]

    get :download, on: :collection
  end

  resources :schools
  resources :school_importers

  get "/pumi/provinces" => "provinces#index"
  resources :high_schools
  resources :high_school_importers

  resources :jobs
  resources :job_importers

  resources :job_clusters
  resources :job_cluster_importers

  resources :majors
  resources :major_importers

  resources :self_understanding_questions
  resources :holland_questions
  resources :holland_question_importers

  resources :videos
  resources :video_importers

  resources :visits
  resources :pages

  resources :intelligence_categories
  resources :intelligence_category_importers

  resources :intelligence_questions
  resources :intelligence_question_importers

  resources :career_websites
  resources :career_website_importers

  resources :personality_types
  resources :personality_type_importers

  # https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
  as :account do
    match "/confirmation" => "confirmations#update", via: :put, as: :update_account_confirmation
  end

  resource :about, only: [:show]
  get "/privacy-policy", to: "abouts#privacy_policy"
  get "/terms-and-conditions", to: "abouts#terms_and_conditions"

  resources :accounts do
    member do
      post :resend_confirmation
      put :archive
      put :restore
      put :enable_dashboard
      put :disable_dashboard
    end
  end

  namespace :api do
    namespace :v1 do
      match "me" => "users#me", :via => :get
      resources :users, only: [:create]
      resources :schools, only: [:index, :create]
      resources :games, only: [:create]
      resources :personality_tests, only: [:create]
      devise_scope :account do
        post "/accounts/sign_in" => "sessions#create"
        post "/accounts/sign_out" => "sessions#destroy"
      end
    end

    namespace :v2 do
      resources :majors, only: [:index]
      resources :schools, only: [:index]
      resources :jobs, only: [:index]
      resources :job_clusters, only: [:index]
      resources :holland_quizzes, only: [:create, :update]
      resources :intelligence_quizzes, only: [:create, :update]
      resources :users, only: [:create]
      resources :videos, only: [:index]
      resources :visits, only: [:create]
      resources :career_websites, only: [:index]
      resources :personality_types, only: [:index]

      get "*path" => "api#routing_error"
    end
  end

  mount Pumi::Engine => "/pumi"

  if Rails.env.production?
    # Sidekiq
    authenticate :account, lambda { |u| u.primary_admin? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  else
    mount Sidekiq::Web => "/sidekiq"
  end
end
