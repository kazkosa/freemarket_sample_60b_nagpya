Rails.application.routes.draw do
  resources :card
  get 'regulation/new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :products , only: [:index, :show, :create] do
    collection do
      get :buy
      get :sell
    end
  end
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
      get :singup2
      get :singup3
      get :singup4
      get :singup5
    end
  end 
end  

