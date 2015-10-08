Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :questions do
  	resources :answers, except: [:index]
  end
  root "welcome#index"

  get "*path" => redirect("/")
end
