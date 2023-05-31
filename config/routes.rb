# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"

  resources :users do
    resources :games, only: [:index, :show]
    resources :personality_tests, only: [:index, :show]

    get :download, on: :collection
  end

  resources :schools
  resources :school_importers

  resources :middle_schools
  resources :middle_school_importers

  resources :jobs
  resources :job_importers

  resources :college_majors
  resources :college_major_importers

  resources :holland_questions
  resources :holland_question_importers

  # https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
  as :account do
    match "/confirmation" => "confirmations#update", via: :put, as: :update_account_confirmation
  end

  resource :about, only: [:show]

  resources :accounts do
    member do
      post :resend_confirmation
      put :archive
      put :restore
    end
  end

  namespace :api do
    namespace :v1 do
      match "me" => "users#me", :via => :get
      resources :users, only: [:create]
      resources :schools, only: [:index, :create]
      resources :games, only: [:create]
      resources :personality_tests, only: [:create]
      resources :high_schools, only: [:index] do
        get :grades, on: :collection
      end
      devise_scope :account do
        post "/accounts/sign_in" => "sessions#create"
        post "/accounts/sign_out" => "sessions#destroy"
      end
    end

    namespace :v2 do
      resources :college_majors, only: [:index]
    end
  end

  mount Pumi::Engine => "/pumi"
end
