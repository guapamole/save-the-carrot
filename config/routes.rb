Rails.application.routes.draw do
  require "sidekiq/web"
  devise_for :users
  root 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  resources :ingredients, only: [:index, :new, :create, :edit, :update] do
    get "add_an_image", on: :collection
    post "analyze_image", on: :collection
    post "recipe_done", on: :member
  end

  get "/ingredients_results", to: "ingredients#results"


  resources :cookbooks, only: [:show, :destroy] do
    resources :recipes, only: [:new, :create]
  end

  resources :recipes, only: [:index, :show, :create, :destroy] do
    get "/generate_recipes", to: "recipes#generate_recipes", on: :collection
  end


  resources :ingredients, only: [:destroy]

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
