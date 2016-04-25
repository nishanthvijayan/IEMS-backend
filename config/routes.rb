Rails.application.routes.draw do

  root "sessions#new"

  get 'signup' => 'regular_users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy' 

  resources :regular_users, path: 'users',   :only => [ :index, :edit, :update, :create, :destroy ] do

    member do
      patch 'manage'
    end

    resources :transactions, :only => [:index]
  end
  resources :transactions, :only => [:destroy, :edit, :update]

  resources :guest_users,   path: 'guests', :only => [ :index, :new, :create, :edit, :update, :destroy ]
  get 'history' => 'versions#index'

  resources :clients, :except => [:show]

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'users' => 'users#index'
      post 'transaction' => 'transaction#create'
      post 'authenticate' => 'sessions#create'
    end
  end

  get "/uploads/transactions/:id/:basename.:extension" => "transactions#getimage"
end
