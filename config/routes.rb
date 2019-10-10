Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :products ,   only: :index
  resources :users do
    collection do
      get :plofile
      get :card
      get :logout
    end
  end
  resources :trials, only: [:index,:create,:new]
end
