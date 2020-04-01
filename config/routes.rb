Rails.application.routes.draw do
  root to: 'home#top'
  get "top" => "home#top"
  get "about" => "home#about"
  resources :posts
  resources :users, only: [:index, :show, :create, :edit, :update] do
    collection do
      get "signup" => "users#new"
    end
  end
  # post "users/create" => "users#create"
  # get "signup" => "users#new"
  # get "users/index" => "users#index"
  # get "users/:id" => "users#show"
end