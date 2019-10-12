Rails.application.routes.draw do
  get 'regulation/new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :products ,   only: :index
  resources :users do
    collection do
      get :plofile
      get :identification
      get :card
      get :logout
      get :notification
      get :todo
      get :like
    end
  end
  resources :trials, only: [:index,:create,:new]
  resources :regulation do
    collection do
      get :singup1
      post :singup2
      post :singup3
      get :singup4
    end
  end  
end
