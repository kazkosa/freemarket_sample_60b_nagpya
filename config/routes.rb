Rails.application.routes.draw do
  resources :card 
  get 'regulation/new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :products , only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :likes,     only: [:create,:destroy]
    resources :comments,  only: [:new, :create]
    collection do
      get :sell
    end
    member do 
      get :showmain
      get :show_transaction_main
      get :show_completed_main
      get :purchase_transaction
      get :purchase_completed
      get :buy
      get :pay
      get :ship
      get :recieve
      get :pend
      get :resell
      get :close
    end

  end
  resources :users do
    member do
      get :plofile
      get :identification
      get :card
      get :logout
      get :notification
      get :todo
      get :like
      get :showedit
      get :show_transaction
      get :show_completed
      get :purchase
      get :purchased
    end
  end
  resources :trials, only: [:index,:create,:new, :edit, :update]
  resources :regulation do
    collection do
      get :singup1
      get :singup2
      get :singup3
      get :singup4
      get :singup5
    end
  end 
end  

