Rails.application.routes.draw do
  devise_for :users
  #  :controllers => {registrations: 'registrations'}
  resources :posts do
    member do
      put "like" => "posts#upvote"
      put "unlike" => "posts#downvote"
    end
    resources :comments
  end

  root "posts#index"

  resources :users do
    member do
      
    end
  end

  resources :conversations do
    resources :messages
  end

  get 'users/:id' => 'users#show'


  # Friends Routes
  delete 'users/delete/:id' => 'friends#delete_friend'
  put 'users/add/:id' => 'friends#send_friend_request'
  put 'users/accept/:id' => 'friends#accept_friend_request'
  delete 'users/reject/:id' => 'friends#reject_friend_request'
  get 'users/:id/friends' => 'friends#index'
  delete 'users/cancelrequest/:id' => 'friends#cancel_request'
  

  resources :comments do
    member do
      put "delete" => "comments#delete" 
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
