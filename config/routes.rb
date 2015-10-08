Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :questions
  root "welcome#index"

  get "*path" => redirect("/")
end
