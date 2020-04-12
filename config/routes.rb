Rails.application.routes.draw do
  root to: 'home#top'
  get "top" => "home#top"
  get "about" => "home#about"
  resources :posts
  resources :users, only: [:index, :show, :create, :edit, :update] do
    collection do
      get "signup" => "users#new"
      get "login" => "users#login_form"
      post "login" => "users#login"
      post "logout" => "users#logout"
    end
    member do
      get "likes" => "users#likes"
    end
  end
  # paramsの値がparams[:post_id]に格納されるように設定
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
end
