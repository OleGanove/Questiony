Rails.application.routes.draw do
  devise_for 	:users
  resources 	:users, only: [:show]
  resources 	:friendships
  resources 	:questions do
  	resources 	:answers, except: [:index]
  end
  resources   :conversations do
    member do 
      post :reply
      post :trash
      post :untrash
    end
  end

  root "welcome#index"

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent"  => "mailbox#sent",  as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  get "*path" => redirect("/")
end
